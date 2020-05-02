import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Vera/model/user.dart';
import 'package:Vera/screens/login_screen.dart';
import 'package:Vera/services/auth.dart';
import 'package:Vera/services/global.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: const Color(0xff142032)));
    return MultiProvider(
      providers: [
        StreamProvider<User>.value(value: Global.userRef.documentStream),
        StreamProvider<FirebaseUser>.value(value: Auth().user),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Vera - ChatBot',
          home: LoginScreen()),
    );
  }
}
