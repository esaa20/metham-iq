import 'package:flutter/material.dart';
import 'package:metham/toManger/manger_to_screen_form.dart';

class MangerToScreen extends StatefulWidget {


  @override
  _MangerToScreenState createState() => _MangerToScreenState();
}

class _MangerToScreenState extends State<MangerToScreen> {
  void _submitAuthForm(
      String password,
      BuildContext ctx
      )async{
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height/1.5,
      child: MangerForm(_submitAuthForm),
    );
  }
}
