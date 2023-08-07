import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:metham/user/gift/gift_screen.dart';
import 'package:metham/user/meassges/meassges.dart';

import '../scores/Score.dart';


class drawerHead extends StatefulWidget {
  drawerHead({
    required this.phone,
    required this.password,
    required this.email,
    required this.username,
    required this.score,
    required this.phones,
    required this.userdc,
    required this.myindex,
    required this.Agent,
    required this.docid
});
  String username;
  String email;
  String phone;
  String password;
  int score;
  var phones;
  var userdc;
  int myindex;
  String Agent ;
  String docid;

  @override
  State<drawerHead> createState() => _drawerHeadState();
}

class _drawerHeadState extends State<drawerHead> {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    void _deleteAccount() async {
      try {
        // Get the currently signed-in user
        User? user = _auth.currentUser;
        DocumentReference<Map<String, dynamic>>
        documentRef = FirebaseFirestore.instance.collection('users').doc(_auth.currentUser!.uid);
        if (user != null) {
          documentRef.delete();
          // Delete the user account
          await user.delete();

          // Optionally, you can sign out the user after the account is deleted
          await _auth.signOut();


          // Display a success message or navigate to another screen
          // (e.g., a confirmation screen or the login screen).
        } else {
          // Handle the case where the user is not signed in.
        }
      } catch (e) {
        // Handle any errors that occur during the account deletion process.
        print("Error deleting account: $e");
      }
    }
    void Score() {
      showModalBottomSheet(context: context, isScrollControlled: true, builder: (_) {
        return Scores(score: widget.score, myindex: widget.myindex, userdc: widget.userdc, phones: widget.phones);

      });
    }

    File? _pickedImage ;
    final ImagePicker _picker = ImagePicker();
    void uploadImage() async{
      final pickedImageFile = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50, maxWidth: 150 );
      setState(() {
        _pickedImage = File(pickedImageFile!.path) ;
      });
      //widget.imagePickFn(_pickedImage!);
      // for sorage image
      final ref = FirebaseStorage.instance.ref().child('user_image').child('electric' + '.jpg');
      await ref.putFile(_pickedImage!);
      //end
    }

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
                    height:  hight*0.015,
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

            Container(
              width: MediaQuery.of(context).size.width*0.45,
              child: ElevatedButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){return UserGiftScreen(agent: widget.Agent, userScore: widget.score, docid: widget.docid, name:widget.username,);}));},
                child: Text('الهدايا', style: TextStyle(color: Color(0xFF9C0000), fontFamily: 'Cairo'),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[200] ,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
                  ),
                ),
              ),
            ), // gift
            Container(
              width: MediaQuery.of(context).size.width*0.45,
              child: ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => MeassgesUser(agent: widget.Agent,)));},
                child: Text('الاشعارات', style: TextStyle(color: Color(0xFF9C0000), fontFamily: 'Cairo'),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[200] ,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
                  ),
                ),
              ),
            ), // notivication
            Container(
              width: MediaQuery.of(context).size.width*0.45,
              child: ElevatedButton(
                  onPressed: Score,
                  child: Text('أرسال النقاط الذهبية', style: TextStyle(color: Color(0xFF9C0000), fontFamily: 'Cairo'),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[200] ,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
                  ),
                ),
              ),
            ), // point


          /*  Container(
              width: MediaQuery.of(context).size.width*0.45,
              child: ElevatedButton(onPressed: (){
                 FirebaseAuth.instance.signOut();
                },
                  child: Text('تسجيل خروج', style: TextStyle(color: Color(0xFF9C0000), fontFamily: 'Cairo'),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[200] ,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
                  ),
                ),
              ),
            ), // singout */
            widgetuser(ico: Icons.person,catogray: 'name',titel: widget.username,),
            widgetuser(ico: Icons.phone, catogray: 'phone', titel: widget.phone,),
            widgetuser(ico: Icons.lock, catogray: 'Password', titel: widget.password,),
            widgetuser(ico: Icons.monetization_on, catogray: 'score', titel: widget.score,),
            TextButton(
                onPressed: (){FirebaseAuth.instance.signOut();},
                child: Text('تسجيل الخروح', style: TextStyle(fontWeight: FontWeight.bold , fontFamily: 'Cairo', color: Colors.grey[50]),)
            ),
            TextButton(
                onPressed: _deleteAccount ,
                child: Text('حذف الحساب', style: TextStyle(fontWeight: FontWeight.bold , fontFamily: 'Cairo', color: Colors.grey[50]),)
            ),
          ],
        ),
      ),
    );
  }
}

class widgetuser extends StatelessWidget {
   widgetuser({
  required this.ico,
  required this.catogray,
   required this.titel

  });
  IconData ico ;
  String catogray ;
  var titel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(

        children: [
          Icon(ico, color: Colors.grey[50],),
          SizedBox(width: 10,),
          Text("$titel" , style: TextStyle(fontWeight: FontWeight.bold , fontFamily: 'Cairo', color: Colors.grey[50]),),

        ],
      ),
    );
  }
}
