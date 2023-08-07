import 'dart:html' as html;
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core_web/firebase_core_web.dart';
import 'package:image_network/image_network.dart';
import 'package:metham/mange/gift_catogriy_image/image_gift_show/image_gift_show.dart';

class ImageUploadGiftCat extends StatefulWidget {
  @override
  _ImageUploadGiftCatState createState() => _ImageUploadGiftCatState();
}

class _ImageUploadGiftCatState extends State<ImageUploadGiftCat> {
  html.File? _imageFile;
  String? _imageUrl;
  TextEditingController caGiName = TextEditingController();
  // TextEditingController itemName = TextEditingController();
  // TextEditingController desc = TextEditingController();

  // Function to pick an image from the device
  void _pickImage() {
    final html.FileUploadInputElement input = html.FileUploadInputElement();
    input.accept = 'image/*';
    input.click();

    input.onChange.listen((event) {
      if (input.files!.isNotEmpty) {
        setState(() {
          _imageFile = input.files![0]!;
        });
      }
    });
  }

  // Function to read the image file and convert it to a data URL
  Future<String> _readImageFile(html.File file) async {
    final reader = html.FileReader();
    reader.readAsDataUrl(file);
    await reader.onLoad.first;
    return reader.result as String;
  }

  // Function to upload the image and text to Firebase
  Future<void> _uploadData() async {
    if (_imageFile != null &&
        caGiName.text.isNotEmpty) {
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final ref =
      firebase_storage.FirebaseStorage.instance.ref().child('images/$fileName');
      final uploadTask = ref.putBlob(_imageFile);
      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();

      // final data = {
      //   'imageUrl': downloadUrl,
      //   'text1': _textEditingController1.text,
      //   'text2': _textEditingController2.text,
      //   'text3': _textEditingController3.text,
      // };
       await FirebaseFirestore.instance.collection('gift').doc(caGiName.text).set({
         'id':1,
         'image':downloadUrl
      });

      // TODO: Send the 'data' map to Firebase Firestore or Realtime Database.

      setState(() {
        _imageUrl = downloadUrl;
        _imageFile = null; // Clear the image file after uploading
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('اصناف الهدايا',style: TextStyle(fontFamily: 'Cairo',),),
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
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*0.02,),
              if (_imageFile != null)
                FutureBuilder<String>(
                  future: _readImageFile(_imageFile!),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Container(
                        width: MediaQuery.of(context).size.width*0.8,
                        height: MediaQuery.of(context).size.height*0.25,
                        child: Image.memory(
                            base64Decode(snapshot.data!.split(',').last),
                            fit: BoxFit.cover),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              TextButton.icon(
                onPressed: _pickImage,
                icon: Icon(Icons.image , color: Color(0xFF9C0000) ,),
                label: Text('اضافة صورة', style: TextStyle(color: Color(0xFF9C0000), fontFamily: 'Cairo'),),),
              TextField(
                controller: caGiName,
                decoration: InputDecoration(
                  labelText: 'صنف الغرض',
                  labelStyle: TextStyle(color: Color(0xFF9C0000), fontFamily: 'Cairo'),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF9C0000)), // Change the color of the underline
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.02,),
              Container(
                width: MediaQuery.of(context).size.width*0.5,
                child: ElevatedButton(
                  onPressed: _uploadData,
                  child: Text('ارسال', style: TextStyle(color: Colors.grey[50], fontFamily: 'Cairo'),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF9C0000),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.02,),
              Container(
                width: MediaQuery.of(context).size.width*0.6,
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> ImageGift()));
                  },
                  child: Text('صور اصناف الهداية', style: TextStyle(color:Colors.grey[200] , fontFamily: 'Cairo'),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:  Color(0xFF9C0000),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
