import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:metham/user/screens/splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'firebase_options.dart';
Future<void> firebaseMessaging(RemoteMessage message) async{
  if(kDebugMode){
    print(message.messageId);
  }

}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
   FirebaseMessaging.onBackgroundMessage(firebaseMessaging);
  runApp( MyApp());
}


class MyApp extends StatelessWidget {
  void requesPermission() async{
    FirebaseMessaging messaging = FirebaseMessaging.instance ;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      sound: true,
      announcement: false,
      provisional: false
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) { print(message.notification?.title);});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('ar','AE'), // English
      ],
      theme: ThemeData(

      ),
      home: SplashScreen(),
    );
  }
}
