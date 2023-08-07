import 'package:flutter/material.dart';
import 'package:metham/mange/messages/mesageON.dart';
import 'package:metham/mange/messages/new_messages.dart';
class mesages extends StatefulWidget {
  const mesages({Key? key}) : super(key: key);

  @override
  _mesagesState createState() => _mesagesState();
}

class _mesagesState extends State<mesages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الاشعارات',style: TextStyle(fontFamily: 'Cairo',),),
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
        child: Column(
          children: [
            Expanded(child: Onmeassge()),
            NewMessage()
          ],
        ),
      ),
    );
  }
}
