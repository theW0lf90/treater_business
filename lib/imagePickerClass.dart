
 import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
 import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
 import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:treater_business/signedbusiness_model.dart';

class ImageHandler {
  //OPENS GALLERY and SELECTS IMAGE
  // UPLOADS TO FIREBASE STORAGE
  // UPDATES DOC with new URL
  openGallery(BuildContext context, SignedBusiness signedBusiness) async{
    print('Entering ImageHandler Class');
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery ,
    );
    if(pickedFile != null && pickedFile.path.length >3 ) {
      print('imagepath businessName' + pickedFile.path.toString());

      uploadFile(pickedFile.path, signedBusiness);
    };
  }


  Future uploadFile(String filePath, SignedBusiness signedBusiness) async {
    File file = File(filePath);

    try {
      print('entering try with' + file.path );
      await firebase_storage.FirebaseStorage.instance
          .ref('uploads/file-to-upload.png')
          .putFile(file);
      updateSignedBusinessRef(signedBusiness);
    } on firebase_core.FirebaseException catch (e) {
      print(e);
      // e.g, e.code == 'canceled'
    }
  }

  Future updateSignedBusinessRef(SignedBusiness signedBusiness) async {
    var dlURL = await firebase_storage.FirebaseStorage.instance
        .ref('uploads/file-to-upload.png').getDownloadURL();
    print('get download url ' + dlURL);
    if(dlURL.length > 3) {
      FirebaseFirestore.instance.collection('SignedBusiness').doc(signedBusiness.uid).update({
        'Comp_imgURL': dlURL
      }).then((value) => print('image updated on signedBuss ref'))
          .catchError((onError) => print('failed to update image'));

      FirebaseFirestore.instance.collection('DK').doc('Companies').collection(signedBusiness.comptype).doc(signedBusiness.linkedUid).update({
        'Comp_imgURL': dlURL
      }).then((value) => print('image updated at companyRef'))
          .catchError((onError) => print('failed to update image'));
    };
  }

  Future updateCompaniesRef(String uid) async {
    var dlURL = await firebase_storage.FirebaseStorage.instance
        .ref('uploads/file-to-upload.png').getDownloadURL();
    print('get download url ' + dlURL);
    if(dlURL.length > 3) {
      FirebaseFirestore.instance.collection('Companies').doc(uid).update({
        'Comp_imgURL': dlURL
      }).then((value) => print('image updated'))
          .catchError((onError) => print('failed to update image'));
    };
  }
}

