import 'package:flutter/material.dart';
import 'package:metham/mange/gift/show_gift.dart';


class Gift extends StatelessWidget {
  Gift({
    required this.catogryName,
  });
  String catogryName ;

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
      body: ShowGift(kindItem: catogryName,),
    );
  }
}
