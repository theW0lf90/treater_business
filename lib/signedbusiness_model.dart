
import 'package:cloud_firestore/cloud_firestore.dart';

class SignedBusiness {
  final String linkedUid;
  final String status;
  final bool verified;
  final String verifiedCvr;
  final String name;
  final String comptype;
  final String uid;
  final String cvr;
  final String zip;
  final String adresse;
  final double averageRating;
  final int reviewCount;
  final String city;
  final String phone;
  final String web;
  final String imgURL;
  List<String> services = [];

  SignedBusiness({this.linkedUid, this.status,this.verified, this.verifiedCvr, this.name, this.comptype, this.uid, this.zip, this.city, this.averageRating, this.reviewCount, this.cvr, this.adresse, this.phone, this.web, this.imgURL, this.services});

  SignedBusiness.fromJson(Map<String, dynamic> parsedJSON)
      :
        linkedUid = parsedJSON['Linked_uid'] ?? '',
        status = parsedJSON['Status'] ?? '',
        verified = parsedJSON['Verified'] ?? false,
        verifiedCvr = parsedJSON['Verified_cvr'] ?? '',
        name = parsedJSON['Comp_name'] ?? '',
        comptype = parsedJSON['Comp_type'] == null ? 'Chiropractor' : parsedJSON['Comp_type'] ?? '',
        uid = parsedJSON['uid'] ?? '',
        cvr = parsedJSON['Comp_cvr'] ?? '',
        adresse = parsedJSON['Comp_adr'] ?? '',
        zip = parsedJSON['Comp_zipcode'].toString(),
        city = parsedJSON['Comp_city'] ?? '',
        averageRating = parsedJSON['averageRating'] == null ? 0.0 : parsedJSON['averageRating'].toDouble(),
        reviewCount = parsedJSON['reviewCount'] ?? 0,
        phone = parsedJSON['Comp_phone'] ?? '',
        web = parsedJSON['Comp_web'] ?? '',
        imgURL = parsedJSON['Comp_imgURL'] == null? '' : parsedJSON['Comp_imgURL'],
        services = parsedJSON['Comp_Services'] == null? [''] : List.from(parsedJSON['Comp_Services']);//== null? [''] : parsedJSON['Comp_Services'];

  SignedBusiness.toJson(Map<String, dynamic> parsedJSON)
  :linkedUid = parsedJSON['Linked_uid'] ?? '',
        status = parsedJSON['Status'] ?? '',
        verified = parsedJSON['Verified'] ?? false,
        verifiedCvr = parsedJSON['Verified_cvr'] ?? '',
        name = parsedJSON['Comp_name'] ?? '',
        comptype = parsedJSON['Comp_type'] == null ? 'Chiropractor' : parsedJSON['Comp_type'] ?? '',
        uid = parsedJSON['uid'] ?? '',
        cvr = parsedJSON['Comp_cvr'] ?? '',
        adresse = parsedJSON['Comp_adr'] ?? '',
        zip = parsedJSON['Comp_zipcode'].toString(),
        city = parsedJSON['Comp_city'] ?? '',
        averageRating = parsedJSON['averageRating'] == null ? 0.0 : parsedJSON['averageRating'].toDouble(),
        reviewCount = parsedJSON['reviewCount'] ?? 0,
        phone = parsedJSON['Comp_phone'] ?? '',
        web = parsedJSON['Comp_web'] ?? '',
        imgURL = parsedJSON['Comp_imgURL'] == null? '' : parsedJSON['Comp_imgURL'],
        services = parsedJSON['Comp_Services'] == null? [''] : List.from(parsedJSON['Comp_Services']);//== null? [''] : parsedJSON['Comp_Services'];


}
