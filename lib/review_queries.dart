import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:treater_business/custom_alert.dart';
import 'package:treater_business/review_model.dart';

class ReviewQueries {
  // Company company;
  // ReviewQueries({this.company});

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  get context => null;

  Stream<List<Review>> streamReviewList(String collectionType, String compId) {
    return _firestore
        .collection('DK')
        .doc('ReviewsRoot')
        .collection(collectionType)
        .doc(compId)
        .collection('Reviews')
        .orderBy('Rev_timestamp', descending: true)
        .snapshots()
        .map((snapShot) => snapShot.docs
            .map((document) => Review.fromJson(document.data()))
            .toList());
  }

  Future<List<Review>> getReviewList(
      String collectionType, String compId) async {
    var querySnap = await _firestore
        .collection('DK')
        .doc('ReviewsRoot')
        .collection(collectionType)
        .doc(compId)
        .collection('Reviews')
        .orderBy('Rev_timestamp', descending: true)
        .get();
    var futureList =
        querySnap.docs.map((snap) => Review.fromJson(snap.data())).toList();
    print(futureList.length.toString());
    return futureList;
  }

  Future getSingleReview(
      String collectionType, String userID, String compId) async {
    return _firestore
        .collection('DK')
        .doc('ReviewsRoot')
        .collection(collectionType)
        .doc(compId)
        .collection('Reviews')
        .doc(userID)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        //   print('Document data: ${documentSnapshot.data()}');
        var data = documentSnapshot.data();
        final Map<String, dynamic> map = data;
        final Review review = Review.fromJson(map);
        print(review.compName +
            " " +
            review.revCompType +
            " " +
            review.revCompUid);
      } else {
        print('Document does not exist on the database');
      }
    });
  }

  Future<Review> getExistingReview(
      String collectionType, String userID, String compId) async {
    Review review;
    _firestore
        .collection('DK')
        .doc('ReviewsRoot')
        .collection(collectionType)
        .doc(compId)
        .collection('Reviews')
        .doc(userID)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        //   print('Document data: ${documentSnapshot.data()}');
        var data = documentSnapshot.data();
        final Map<String, dynamic> map = data;
        review = Review.fromJson(map);
        print("EXISTING REVIE" +
            review.compName +
            " " +
            review.revCompType +
            " " +
            review.revCompUid);
      } else {
        print('Document does not exist on the database');
      }
    });
    return review;
  }

  Future respondToReview(
      Review review, String response, String businessUid) async {
    DateTime now = DateTime.now();
    String revResponseDate = now.day.toString() +
        "." +
        now.month.toString() +
        "." +
        now.year.toString();

    return _firestore
        .collection('DK')
        .doc('ReviewsRoot')
        .collection(review.revCompType)
        .doc(review.revCompUid)
        .collection('Reviews')
        .doc(review.revFromId)
        .update({
      'Rev_answer': response,
      'Rev_has_answer': true,
      'Rev_answer_timestamp': Timestamp.now(),
      'Rev_answer_uid': businessUid,
      'Rev_response_date': revResponseDate,
    }).then((value) => showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomAlert(
                      title: 'Succes', message: 'Tak for din besvarelse');
                }) //print('Rev updated'))
            .catchError((error) => showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomAlert(
                      title: 'Fejl',
                      message: 'Der er desværre sket en fejl. Prøv igen');
                }))); //  print("Failed to update review: $error")));
  }

  Future writeReview(Review review) async {
    return _firestore
        .collection('DK')
        .doc('ReviewsRoot')
        .collection(review.revCompType)
        .doc(review.revCompUid)
        .collection('Reviews')
        .doc(review.revFromId)
        .set({
      'Rev_ag_score': review.revAgScore,
      'Rev_availability_rating': review.revAvailabilityRating,
      'Rev_comp_name': review.compName,
      'Rev_comp_type': review.revCompType,
      'Rev_comp_uid': review.revCompUid,
      'Rev_date': review.revDate,
      'Rev_flag': review.revFlag,
      'Rev_from_id': review.revFromId,
      'Rev_id': review.revFromId,
      'Rev_result_rating': review.revResultRating,
      'Rev_text': review.revText,
      'Rev_timestamp': Timestamp.now(),
      'Rev_trust_rating': review.revTrustRating,
      'Rev_type_title': review.revTypeTitle,
      'Rev_username': review.revUsername,
    }).then((value) => showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomAlert(
                      title: 'Anmeldelse uploadet',
                      message: 'Tak for din anmeldelse');
                }) //print('Rev updated'))
            .catchError((error) => showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomAlert(
                      title: 'Anmeldelse uploadet',
                      message: 'Tak for din anmeldelse');
                }))); //  print("Failed to update review: $error")));
  }
}
