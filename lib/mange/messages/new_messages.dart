import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = new TextEditingController() ;
  var _enteredMessage = '';
  void _sendMessage(String agent)async{
    FocusScope.of(context).unfocus();
    FirebaseFirestore.instance.collection('meassge').add({
      'text':_enteredMessage,
      'createdAt': Timestamp.now(),
      'Agent': agent
    });
    _controller.clear();
    _enteredMessage= '';
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: 'ارسال رسلة...',
                  labelStyle: TextStyle(color: Color(0xFF9C0000), fontFamily: 'Cairo'),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF9C0000)), // Change the color of the underline
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _enteredMessage = value;
                  });
                },
              )),
          IconButton(
            onPressed: (){
              _enteredMessage.trim().isEmpty ? null : _sendMessage('1');
            },
            icon: Icon(Icons.person, color: Color(0xFF9C0000),),
          ),
          IconButton(
            onPressed: (){
              _enteredMessage.trim().isEmpty ? null : _sendMessage('0');
            },
            icon: Icon(Icons.people, color: Color(0xFF9C0000),),
          ),
        ],
      ),
    );
  }
}
