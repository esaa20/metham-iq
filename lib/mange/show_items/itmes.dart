import 'package:flutter/material.dart';
import 'package:metham/mange/show_items/show_items.dart';


class Items extends StatelessWidget {
  Items({
    required this.catogryName,
});
  String catogryName ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        title: Text(catogryName, style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold),) ,
      ),
      body: ShowItems(kindItem: catogryName,),
    );
  }
}
