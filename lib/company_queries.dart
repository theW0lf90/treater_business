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




}