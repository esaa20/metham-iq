import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:metham/authForm.dart';





class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;
  void _submitAuthForm(
      String password,
      String username,
      String phonenumber,
      String city,
      String agentName,
      bool isLogin,
      BuildContext ctx
      )async{
    UserCredential authResult;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {

        authResult = await _auth.signInWithEmailAndPassword(
            email: '${phonenumber}@gmail.com', password: password);
      }
      else {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: '${phonenumber}@gmail.com', password: password);
      }
      // for sorage image

      //end
      if(isLogin == false){
        await FirebaseFirestore.instance.collection('users').doc(authResult.user!.uid).set({
          'username':username,
          'email':'${phonenumber}@gmail.com',
          'password':password,
          'phonenumber': phonenumber,
          'userid' :  FirebaseAuth.instance.currentUser!.uid ,
          'score': 0,
          'agent':'0',
          'city':city,
          'Agent name':agentName
        });
      }

    }on PlatformException  catch(err) {
      String? message = 'An error occured , please check your credentials!';
      if(err.message != null){
        message = err.message ;
      }

      setState(() {
        _isLoading = false ;
      });
    }catch(err){
      //print(err);
      setState(() {
        _isLoading = false ;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF9C0000), Color(0xFF2E0101)], // Set the desired colors for the gradient
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: AuthForm(_submitAuthForm, _isLoading),
      ),
    );

  }
}
