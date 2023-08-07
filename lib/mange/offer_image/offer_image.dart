import 'package:flutter/material.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:metham/mange/offer_image/upload_form_offer.dart';


class OfferImage extends StatefulWidget {
  const OfferImage({Key? key}) : super(key: key);

  @override
  State<OfferImage> createState() => _OfferImageState();
}

class _OfferImageState extends State<OfferImage> {
  void _submitAuthForm(
      String cofferName,
      File offerImage,
      BuildContext ctx
      )async{
    UserCredential authResult;
    try {
      // for sorage image
      final ref = FirebaseStorage.instance.ref().child('user_image').child(cofferName+ '.jpg');
      await ref.putFile(offerImage);
      final url = await ref.getDownloadURL();
      //end
      await FirebaseFirestore.instance.collection('carouse').doc().set({
        'name':cofferName,
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
          child:UploadFormOffer(_submitAuthForm),
        ),
      ),
    );
  }
}
