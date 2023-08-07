import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:metham/mange/screens/home_screen.dart';
import 'package:metham/user/show_items/catogriy.dart';

import '../methods/drawer.dart';


class HomeScreenUser extends StatefulWidget {
  const HomeScreenUser({Key? key}) : super(key: key);

  @override
  _HomeScreenUserState createState() => _HomeScreenUserState();
}

class _HomeScreenUserState extends State<HomeScreenUser> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(builder: (ctx,futureSnapshot){
      if(futureSnapshot.connectionState == ConnectionState.waiting){
        return Center(child: CircularProgressIndicator(),);
      }
      return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
          builder: (ctx,Snapshot){
            if (Snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final userDocs = Snapshot.data!.docs ; // here all information of users
            final useridd = userDocs.map((doc) => doc['userid']).toList(); // here list of userid of all users
            final userphon = userDocs.map((doc) => doc['phonenumber']).toList(); // here list of users phonenumbers
            int index = useridd.indexOf(FirebaseAuth.instance.currentUser!.uid); // to find the user

            print(userDocs[index].id); // name of user who make the Auth
              return Scaffold(
                appBar: AppBar(
                  title: Text(userDocs[index]['username'], style: TextStyle(fontFamily: 'Cairo', ),),
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
                drawer: drawerHead(
                  password:userDocs[index]['password'] ,
                  username:userDocs[index]['username'] ,
                  phone: userDocs[index]['phonenumber'],
                  email: userDocs[index]['email'],
                  score: userDocs[index]['score'],
                  phones: userphon,
                  userdc: userDocs,
                  myindex: index,
                  Agent: userDocs[index]['agent'],
                  docid: userDocs[index].id,
                ),
                body: Container(
                  child: catogriy(),
                ),
              );
          });
    }, future: null,);
  }
}
