import 'package:flutter/material.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:metham/mange/gift/up_load_gift/upload_form_gift.dart';


class UploadGift extends StatefulWidget {
  const UploadGift({Key? key}) : super(key: key);

  @override
  State<UploadGift> createState() => _UploadGiftState();
}

class _UploadGiftState extends State<UploadGift> {
  void _submitAuthForm(
      String giftName,
      String kindGift,
      String giftScore,
      File giftImage,
      BuildContext ctx
      )async{
    try {
      // for sorage image
      final ref = FirebaseStorage.instance.ref().child('user_image').child(giftName+ '.jpg');
      await ref.putFile(giftImage);
      final url = await ref.getDownloadURL();
      //end

      await FirebaseFirestore.instance.collection('gift').doc(kindGift).collection(kindGift).doc(giftName).set({
        'kindGift':kindGift,
        'giftName':giftName,
        'giftScore':giftScore,
        'image_url': url
      });
      // await FirebaseFirestore.instance.collection('gift').doc(kindGift).set({
      //   'id':1,
      // });

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
          child:UploadFormGift(_submitAuthForm),
        ),
      ),
    );
  }
}
