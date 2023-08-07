import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:metham/mange/catogriy_image/catogriy_image.dart';
import 'package:metham/mange/catogriy_image/catogriy_image_web.dart';
import 'package:metham/mange/gift/gift_screen.dart';
import 'package:metham/mange/gift_catogriy_image/gift_catogriy_image.dart';
import 'package:metham/mange/gift_catogriy_image/web_gift_cat.dart';
import 'package:metham/mange/messages/messages.dart';
import 'package:metham/mange/offer_image/offer_image.dart';
import 'package:metham/mange/offer_image/offer_web.dart';
import 'package:metham/mange/upload_item/web_upload.dart';
import 'package:metham/mange/users/users.dart';


import '../scores/Score.dart';
import '../upload_item/upload_item.dart';

class drawerHead extends StatefulWidget {

  @override
  State<drawerHead> createState() => _drawerHeadState();
}

class _drawerHeadState extends State<drawerHead> {
  @override
  Widget build(BuildContext context) {

    // for up load item
    File? _pickedImage ;
    final ImagePicker _picker = ImagePicker();
    void uploadImage() async{
      final pickedImageFile = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50, maxWidth: 150 );
      setState(() {
        _pickedImage = File(pickedImageFile!.path) ;
      });
      //widget.imagePickFn(_pickedImage!);
      // for storage image
      final ref = FirebaseStorage.instance.ref().child('user_image').child('electric' + '.jpg');
      await ref.putFile(_pickedImage!);
      //end
    }
// end up load item
    final double widdth = MediaQuery.of(context).size.width - 80;
    final double hight = MediaQuery.of(context).size.height;

    return Drawer(
      width: widdth,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF9C0000), Color(0xFF2E0101)], // Set the desired colors for the gradient
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: hight*0.07683,),
            Container(
              height: hight*0.25,
              width: widdth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: hight*0.015,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: (widdth+80)*0.256,
                      height:hight*0.129,
                      child: Image.asset(
                        'images/meth.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  Text(
                    "مجموعة ميثم مرزة التجارية",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey[50], fontFamily: 'Cairo'),
                  ),
                  SizedBox(
                    height: hight*0.015,
                  ),
                ],
              ),
              // for DrawerHead designe color
            ),
            SizedBox(
              height: hight*0.015,
            ),
            Container(
              width: MediaQuery.of(context).size.width*0.45,
                child: ElevatedButton(
                    onPressed: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){return Users();})),
                    child: Text('المستخدمين', style: TextStyle(color: Color(0xFF9C0000), fontFamily: 'Cairo'),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[200] ,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), // Adjust the radius as needed
                    ),
                  ),
                ),
            ),
            // Container(
            //   width: MediaQuery.of(context).size.width*0.45,
            //   child: ElevatedButton(
            //       onPressed: (){
            //     Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){return UploadItem();}));},
            //       child: Text('تحميل البضاعة', style: TextStyle(color: Color(0xFF9C0000), fontFamily: 'Cairo'),),
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: Colors.grey[200],
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(20), // Adjust the radius as needed
            //       ),
            //     ),
            //   ),
            // ),
            Container(
              width: MediaQuery.of(context).size.width*0.45,
              child: ElevatedButton(
                  onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){return mesages();}));},
                  child: Text('رسائل', style: TextStyle(color: Color(0xFF9C0000), fontFamily: 'Cairo'),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[200] ,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), // Adjust the radius as needed
                    ),
                  ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width*0.45,
              child: ElevatedButton(
                  onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){return Gift();}));},
                  child: Text('قسم الهدايا', style: TextStyle(color: Color(0xFF9C0000), fontFamily: 'Cairo'),),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[200],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // Adjust the radius as needed
                  ),
                ),
              ),
            ),
            // Container(
            //   width: MediaQuery.of(context).size.width*0.45,
            //   child: ElevatedButton(
            //     onPressed: (){
            //       showModalBottomSheet(context: context, isScrollControlled: true, builder: (_) {
            //         return UploadImageCatogriy();
            //
            //       });
            //     },
            //     child: Text('صورة للصنف المنتج', style: TextStyle(color: Color(0xFF9C0000), fontFamily: 'Cairo'),),
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: Colors.grey[200],
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(20), // Adjust the radius as needed
            //       ),
            //     ),
            //   ),
            // ),
            // Container(
            //   width: MediaQuery.of(context).size.width*0.45,
            //   child: ElevatedButton(
            //     onPressed: (){
            //       showModalBottomSheet(context: context, isScrollControlled: true, builder: (_) {
            //         return UploadImageCatogriyGift();
            //
            //       });
            //     },
            //     child: Text('صورة للصنف الهدية', style: TextStyle(color: Color(0xFF9C0000), fontFamily: 'Cairo'),),
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: Colors.grey[200],
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(20), // Adjust the radius as needed
            //       ),
            //     ),
            //   ),
            // ),
            // Container(
            //   width: MediaQuery.of(context).size.width*0.45,
            //   child: ElevatedButton(
            //     onPressed: (){
            //       showModalBottomSheet(context: context, isScrollControlled: true, builder: (_) {
            //         return OfferImage();
            //
            //       });
            //     },
            //     child: Text('صورة اعلان', style: TextStyle(color: Color(0xFF9C0000), fontFamily: 'Cairo'),),
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: Colors.grey[200],
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(20), // Adjust the radius as needed
            //       ),
            //     ),
            //   ),
            // ),
            Container(
              width: MediaQuery.of(context).size.width*0.45,
              child: ElevatedButton(
                onPressed: (){
                  showModalBottomSheet(context: context, isScrollControlled: true, builder: (_) {
                    return ImageUploadWidget();

                  });
                },
                child: Text('تحميل البضاعة', style: TextStyle(color: Color(0xFF9C0000), fontFamily: 'Cairo'),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[200],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // Adjust the radius as needed
                  ),
                ),
              ),
            ),
            // Container(
            //   width: MediaQuery.of(context).size.width*0.45,
            //   child: ElevatedButton(
            //     onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){return ImageUploadGiftCat();}));},
            //     child: Text('صورة للصنف الهدية', style: TextStyle(color: Color(0xFF9C0000), fontFamily: 'Cairo'),),
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: Colors.grey[200],
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(20), // Adjust the radius as needed
            //       ),
            //     ),
            //   ),
            // ),
            Container(
              width: MediaQuery.of(context).size.width*0.45,
              child: ElevatedButton(
                onPressed: (){
                  showModalBottomSheet(context: context, isScrollControlled: true, builder: (_) {
                    return ImageUploadOffer();

                  });
                },
                child: Text('صورة اعلان', style: TextStyle(color: Color(0xFF9C0000), fontFamily: 'Cairo'),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[200],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // Adjust the radius as needed
                  ),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width*0.45,
              child: ElevatedButton(
                onPressed: (){
                  showModalBottomSheet(context: context, isScrollControlled: true, builder: (_) {
                    return ImageUploadCatogriyItem();

                  });
                },
                child: Text('صورة للصنف المنتج', style: TextStyle(color: Color(0xFF9C0000), fontFamily: 'Cairo'),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[200],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // Adjust the radius as needed
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}