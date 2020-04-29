import 'package:flutter/material.dart';
import 'package:mobile/chatbot/chatbot.dart';
import 'package:mobile/services/auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Auth _auth = new Auth();

  @override
  void initState() {
    super.initState();
    _auth.getUser.then((user) {
      if (user != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Chatbot()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login App :)'),
      ),
      body: Center(
        child: Container(
          alignment: Alignment.center,
          height: 40,
          width: 100,
          color: Colors.amber,
        ),
      ),
    );
  }
}
