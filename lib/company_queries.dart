import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:treater_business/signedbusiness_model.dart';
import 'company_model.dart';


class CompanyQueries {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  // Widget build(BuildContext context, String collectionType, String documentId) {
  //   DocumentReference docRef = _firestore
  //       .collection('DK')
  //       .doc('Companies')
  //       .collection(collectionType)
  //       .doc(documentId);
  //   return FutureBuilder<DocumentSnapshot>(
  //     future: docRef.get(),
  //     builder:
  //         (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
  //       if (snapshot.hasError) {
  //         return Text("Something went wrong");
  //       }
  //
  //       if (snapshot.hasData && !snapshot.data.exists) {
  //         return Text("Document does not exist");
  //       }
  //
  //       if (snapshot.connectionState == ConnectionState.done) {
  //         Map<String, dynamic> data = snapshot.data.data();
  //         return Text("Full Name: ${data['full_name']} ${data['last_name']}");
  //       }
  //
  //       return Text("loading");
  //     },
  //   );
  // }

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