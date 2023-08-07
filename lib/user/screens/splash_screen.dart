import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'auth_screen.dart';
import 'home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
          splashIconSize: 200,
          backgroundColor: Color(0xFF9C0000),
          splash: CircleAvatar(
            radius: 100,
            backgroundImage: AssetImage('images/meth.jpg'),
          ),
          nextScreen: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (ctx , Usersnapshot){
              if(Usersnapshot.hasData){
                return HomeScreenUser();
              }
              return AuthScreen();
            },
          )
      ),
    );
  }
}

