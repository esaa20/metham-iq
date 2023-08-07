import 'package:flutter/material.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:metham/mange/gift_catogriy_image/upload_form_catogriy_image_gift.dart';


class UploadImageCatogriyGift extends StatefulWidget {
  const UploadImageCatogriyGift({Key? key}) : super(key: key);

  @override
  State<UploadImageCatogriyGift> createState() => _UploadImageCatogriyGiftState();
}

class _UploadImageCatogriyGiftState extends State<UploadImageCatogriyGift> {
  void _submitAuthForm(
      String caGiName,
      File caGiImage,
      BuildContext ctx
      )async{
    UserCredential authResult;
    try {
      // for sorage image
      final ref = FirebaseStorage.instance.ref().child('user_image').child(caGiName+ '.jpg');
      await ref.putFile(caGiImage);
      final url = await ref.getDownloadURL();
      //end
      await FirebaseFirestore.instance.collection('gift').doc(caGiName).set({
        'id':1,
        'image':url
      });

    }on PlatformException  catch(err) {
      String? message = 'An error occured , please check your credentials!';
      if(err.message != null){
        message = err.message ;
      }
      //Scaffold.of(ctx).showSnackBar(SnackBar(content: Text(message!), backgroundColor: Theme.of(ctx).errorColor,));
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child:UploadFormCatogriyImageGift(_submitAuthForm),
        ),
      ),
    );
  }
}
