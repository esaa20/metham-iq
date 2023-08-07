import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:metham/mange/scores/score_form.dart';



class Scores extends StatefulWidget {
  Scores({
    required this.score,
    required this.userdc,
  });
  var userdc;
  int score;
  @override
  _ScoresState createState() => _ScoresState();
}

class _ScoresState extends State<Scores> {
  void _submitAuthForm(
      String scoreTo,
      BuildContext ctx
      )async{
    UserCredential authResult;
    try {
      DocumentReference documentRef =
      FirebaseFirestore.instance.collection('users').doc(widget.userdc);
      num sumScore = widget.score + int.parse(scoreTo) ;
      documentRef.update({
        'score': sumScore,
      })
          .then((_) {
        print('Document updated successfully!');
      })
          .catchError((error) {
        print('Error updating document: $error');
      });
    }on PlatformException  catch(err) {
      String? message = 'An error occured , please check your credentials!';
      if(err.message != null){
        message = err.message ;
      }
      //Scaffold.of(ctx).showSnackBar(SnackBar(content: Text(message!), backgroundColor: Theme.of(ctx).errorColor,));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height/1.5,
      child: ScoreForm(_submitAuthForm),
    );
  }
}
