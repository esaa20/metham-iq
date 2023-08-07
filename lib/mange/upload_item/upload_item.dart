import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'upload_form.dart';

class UploadItem extends StatefulWidget {
  const UploadItem({Key? key}) : super(key: key);

  @override
  State<UploadItem> createState() => _UploadItemState();
}

class _UploadItemState extends State<UploadItem> {
  void _submitAuthForm(
      String itemName,
      String discItem,
      String kindItem,
      File itemImage,
      BuildContext ctx
      )async{
    UserCredential authResult;
    try {
      // for sorage image
      final ref = FirebaseStorage.instance.ref().child('user_image').child(itemName+ '.jpg');
      await ref.putFile(itemImage);
      final url = await ref.getDownloadURL();
      //end

      await FirebaseFirestore.instance.collection('items').doc(kindItem).collection(kindItem).doc(itemName).set({
        'KindItem':kindItem,
        'ItemName':itemName,
        'DiscItem':discItem,
        'image_url': url
      });
      // await FirebaseFirestore.instance.collection('items').doc(kindItem).set({
      //   'id':1,
      //   'image':''
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
    return Scaffold(
      appBar: AppBar(
        title: Text('تحميل البضاعة',style: TextStyle(fontFamily: 'Cairo',),),
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF9C0000), Color(0xFF2E0101)],
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
            ),
          ),
        ),
      ),
      body: UploadForm(_submitAuthForm),
    );
  }
}
