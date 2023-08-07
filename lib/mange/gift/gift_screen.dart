import 'package:flutter/material.dart';
import 'package:metham/mange/gift/catogriy_gift.dart';
import 'package:metham/mange/gift/gift_web.dart';
import 'package:metham/mange/gift/people_have_gifts.dart';
import 'package:metham/mange/gift/up_load_gift/up_load_gift.dart';

class Gift extends StatefulWidget {
  const Gift({Key? key}) : super(key: key);

  @override
  _GiftState createState() => _GiftState();
}

class _GiftState extends State<Gift> {
  void gift(){
    showModalBottomSheet(context: context, isScrollControlled: true, builder: (_) {
      return ImageUploadGift();

    });
  }
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
        actions: [
          IconButton(onPressed: gift,icon: Icon(Icons.card_giftcard),),
          IconButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => UserShowGift()));
          }, icon: Icon(Icons.people)),
        ],
      ),
      body: Container(
        child: catogriyGift(),
      ),
    );
  }
}
