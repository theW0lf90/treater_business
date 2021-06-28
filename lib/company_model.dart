
import 'package:cloud_firestore/cloud_firestore.dart';

class Company {
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

  Company({this.name, this.comptype, this.uid, this.zip, this.city, this.averageRating, this.reviewCount, this.cvr, this.adresse, this.phone, this.web, this.imgURL, this.services});

  Company.fromJson(Map<String, dynamic> parsedJSON)
      : name = parsedJSON['Comp_name'] ?? '',
        comptype =  parsedJSON['Comp_imgURL'] == null? 'physiotherapist' : parsedJSON['Comp_type'] ?? '',
        uid = parsedJSON['Comp_doc_id'] ?? '',
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
  //
  // factory Company.fromFirestore(DocumentSnapshot doc) {
  //   Map data = doc.data;
  //   return Company(
  //
  //   );
  // }

  String setCategoryImage(String companytype) {
    String imagePath = '';
    switch (companytype) {
      case 'Chiropractor': {  imagePath = 'assets/images/lyng_chiro_resize_128.png'; }
      break;

      case 'Physiotherapist': {  imagePath = 'assets/images/lyng_physio_128.png';}
      break;

      case 'Dentist': { imagePath = 'assets/images/lyng_dentist128.png'; }
      break;

      case 'Beauty': { imagePath = 'assets/images/lyng_beauty_128.png'; }
      break;

      case 'Plastic': { imagePath = 'assets/images/plastickirurg.png'; }
      break;

      default:
        {
          imagePath = 'assets/images/lyng_physio_128.png';
        }
        break;
    }
    return imagePath;
  }
}
