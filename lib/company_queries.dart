import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:treater_business/signedbusiness_model.dart';
import 'company_model.dart';


class CompanyQueries {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;


  //* Position in DK
  Future<List<Company>> getCountryRank(String collectionType) async {
    print('entering country rank');
    var querySnap = await _firestore
        .collection('DK')
        .doc('Companies')
        .collection(collectionType)
        .where('Comp_acc_rating', isGreaterThan: 1)

    //   .orderBy('Comp_acc_rating', descending: true)
        .get();
    var futureList =
    querySnap.docs.map((snap) => Company.fromJson(snap.data())).toList();
  //  futureList.forEach((element) {print(element.accRating); });
   futureList.sort(( a,b) {
      return a.accRating.compareTo(b.accRating);
    });
    //futureList.forEach((element) {print(element.accRating); });

    return futureList.reversed.toList();

  }

 Future<String> getCountryRank2(String collectionType, String uid) async {
    print('entering country rank2 inputs are $collectionType $uid' );
    var querySnap = await _firestore
        .collection('DK')
        .doc('Companies')
        .collection(collectionType)
        .where('Comp_acc_rating', isGreaterThan: 1)

    //   .orderBy('Comp_acc_rating', descending: true)
        .get();
    var futureList =
    querySnap.docs.map((snap) => Company.fromJson(snap.data())).toList();
      futureList.forEach((element) {print(element.accRating); });

    futureList.sort(( a,b) {
      return a.accRating.compareTo(b.accRating);
    });

    var position = 0;
    //*Reverse from ascending to descending
    futureList = futureList.reversed.toList();

    futureList.forEach((element) {
      if(element.uid == uid) {
        var index = futureList.indexOf(element);
        position = index + 1;
      };
    });

    print('my position is $position');
    return position.toString();
  }

  Future<String> getIndustryReviewData(String collectionType) async {
    print('entering collectiongroup inputs are ' );
    var querySnap = await _firestore
        .collectionGroup('ReviewsRoot')
        .get();
    var futureList =
    querySnap.docs.map((snap) => Company.fromJson(snap.data())).toList();
    futureList.forEach((element) {print(element.accRating); });

    futureList.sort(( a,b) {
      return a.accRating.compareTo(b.accRating);
    });

    var position = 0;
    //*Reverse from ascending to descending
    futureList = futureList.reversed.toList();

 /*   futureList.forEach((element) {
      if(element.uid == uid) {
        var index = futureList.indexOf(element);
        position = index + 1;
      };
    });
*/
    print('my position is $position');
    return position.toString();
  }




  Future <SignedBusiness> getSignedBusinessData(String compId) async {
    var snap = await _firestore.collection('SignedBusiness').doc(compId).get();
    print(snap.data());
    return SignedBusiness.fromJson(snap.data());
  }

  Future <Company> getCompanyData(String collectionType, String compId) async {
    var snap = await _firestore.collection('DK').doc('Companies').collection(collectionType).doc(compId).get();
  print(snap.data());
    return Company.fromJson(snap.data());


    return _firestore
        .collection('DK')
        .doc('Companies')
        .collection(collectionType)
        .doc(compId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        final Map<String, dynamic> map = documentSnapshot.data();
        return Company.fromJson(map);
      } else {
        return null;
      }
      //  if (documentSnapshot.exists) {
      //      print('Document data: ${documentSnapshot.data()}');
      //
      //    final Map<String, dynamic> map = documentSnapshot.data();
      // return Company.fromJson(map);
      //
      //  } else {
      //    print('Document does not exist on the database');
      //  }
    });
  }
  Future updateMySkills(User user, List<String> list, String compType, String linkedUid) async {

    //PREPARE seaarchIndexList
    List<String> searchIndexList = [];

    list.forEach((competence) {
      String tempString = '';
      competence.characters.forEach((element) {
        tempString = tempString.toLowerCase() + element.toLowerCase();
        print('upload $tempString');
        searchIndexList.add(tempString);
      });
    });


    //WRITE TO DATABASE
    CollectionReference consultantsRef = FirebaseFirestore.instance.collection('SignedBusiness');

    consultantsRef.doc(user.uid).get()
        .then((DocumentSnapshot documentSnapshot) {

      consultantsRef.doc(user.uid)
          .update({
        'Comp_Services': FieldValue.arrayUnion(list),
        'Service_Search_index': FieldValue.arrayUnion(searchIndexList),
      });

    });

    FirebaseFirestore.instance.collection('DK').doc('Companies').collection(compType).doc(linkedUid).update({
      'Comp_Services':  FieldValue.arrayUnion(list),
      'Service_Search_index': FieldValue.arrayUnion(searchIndexList),
    }).then((value) => print('image updated at companyRef'))
        .catchError((onError) => print('failed to update image'));
  }

  getInfoFromCompanyRef(BuildContext context,String cvr, String compType ) async {
      CollectionReference companyRef = FirebaseFirestore.instance.collection('DK').doc('Companies').collection(compType);
      companyRef.where('Comp_cvr', isEqualTo: cvr).get()
        .then((QuerySnapshot querySnapshot) {
          querySnapshot.docs.forEach((doc) {
            print(doc['Comp_name']);
          });
        })
          .catchError((onError) => print('error'));
    }


  writeMetaData(String email, Company company, BuildContext context, String contactEmail,String contactPhone) async {
    CollectionReference signedBusinessRef = FirebaseFirestore.instance.collection('SignedBusiness');

    signedBusinessRef.doc(company.uid).get()
        .then((DocumentSnapshot documentSnapshot) {

      if (documentSnapshot.exists) {
        print('Doc exists');
      } else {
        print('is first time user');
        signedBusinessRef.doc(company.uid)
            .set({
        'Linked_uid': company.uid,
        'Verified': false,
        'Timestamp': Timestamp.now(),
        'Contact_email': contactEmail,
        'Contact_phone': contactPhone,
          'Email': email,
          'OnboardingStatus': 'Pending',
          'isFirstLogin': true,
        }).then((value) =>  showDialog(
            context: context,
            builder: (BuildContext context) {
              return Text(''); //OnBoardingController(isOnBoarding: true);
            })

          /*   Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PageControllerOnBoarding(isOnBoarding: true)),
        ) */
        );

      }
    });
  }


}