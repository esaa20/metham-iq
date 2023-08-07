import 'package:flutter/material.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:metham/mange/catogriy_image/upload_form_catoriy_image.dart';


class UploadImageCatogriy extends StatefulWidget {
  const UploadImageCatogriy({Key? key}) : super(key: key);

  @override
  State<UploadImageCatogriy> createState() => _UploadImageCatogriyState();
}

class _UploadImageCatogriyState extends State<UploadImageCatogriy> {
  void _submitAuthForm(
      String caName,
      File caImage,
      BuildContext ctx
      )async{
    try {
      // for sorage image
      final ref = FirebaseStorage.instance.ref().child('user_image').child(caName+ '.jpg');
      await ref.putFile(caImage);
      final url = await ref.getDownloadURL();
      //end
      await FirebaseFirestore.instance.collection('items').doc(caName).set({
        'id':1,
        'image':url
      });

    }on PlatformException  catch(err) {
      String? message = 'An error occured , please check your credentials!';
      if(err.message != null){
        message = err.message ;
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child:UploadFormCatogriyImage(_submitAuthForm),
        ),
      ),
    );
  }
}
