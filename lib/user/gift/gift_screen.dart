import 'package:flutter/material.dart';
import 'package:metham/mange/gift/catogriy_gift.dart';
import 'package:metham/user/gift/catogriy_user_gift.dart';

class UserGiftScreen extends StatefulWidget {
  UserGiftScreen({
    required this.agent,
    required this.userScore,
    required this.docid,
    required this.name
});
  String agent;
  int userScore;
  String docid;
  String name;

  @override
  _UserGiftScreenState createState() => _UserGiftScreenState();
}

class _UserGiftScreenState extends State<UserGiftScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الهداية',style: TextStyle(fontFamily: 'Cairo',),),
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
        child: catogriyUserGift(agent: widget.agent, userScore: widget.userScore, docid: widget.docid, name: widget.name,),
      ),
    );
  }
}
