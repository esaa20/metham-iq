import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:metham/user/scores/score_form.dart';


class Scores extends StatefulWidget {
  Scores({
    required this.score,
    required this.myindex,
    required this.userdc,
    required this.phones
  });
  var phones;
  var userdc;
  int myindex;
  int score;
  @override
  _ScoresState createState() => _ScoresState();
}

class _ScoresState extends State<Scores> {
  void _submitAuthForm(
      String Number,
      String scoreTo,
      BuildContext ctx
      )async{
    UserCredential authResult;
    try {
      int index = widget.phones.indexOf(Number);
      CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
      String documentId = '${widget.userdc[index].id}';

      usersCollection.doc(documentId).get().then((DocumentSnapshot snapshot) {
        if (snapshot.exists) {
          // Step 2: Calculate the sum of desired fields
          Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
          int field1Value = data['score'];
          num sum = field1Value +int.parse(scoreTo) ;

          // Step 3: Update the document with the calculated sum

          usersCollection.doc(documentId).update({'score': sum}).then((_) {
            print('Document updated successfully with sum: $sum');
          }).catchError((error) {
            print('Failed to update document: $error');
          });

        }
        else {
          print('Document does not exist');
        }
      }).catchError((error) {
        print('Failed to retrieve document: $error');
      });
      // end
      usersCollection.doc('${widget.userdc[widget.myindex].id}').update({
        'score': widget.score-int.parse(scoreTo)
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
      child: ScoreForm(_submitAuthForm, widget.score),
    );
  }
}
