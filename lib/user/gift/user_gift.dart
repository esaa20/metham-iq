import 'package:flutter/material.dart';
import 'package:metham/user/gift/show_user_gift.dart';



class UserGift extends StatelessWidget {
  UserGift({
    required this.catogryName,
    required this.agent,
    required this.userScore,
    required this.docid,
    required this.name,
  });
  String catogryName ;
  String agent;
  int userScore;
  String docid;
  String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(catogryName,style: TextStyle(fontFamily: 'Cairo',),) ,
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
      body: ShowUserGift(kindGift: catogryName, agent: agent, userScore: userScore, docid: docid, name: name,),
    );
  }
}
