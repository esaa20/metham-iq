import 'package:flutter/material.dart';
import 'package:metham/user/show_items/show_items.dart';

class Items extends StatelessWidget {
  Items({
    required this.catogryName,
});
  String catogryName ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(catogryName, style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold),) ,
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
      body: ShowItems(kindItem: catogryName,),
    );
  }
}
