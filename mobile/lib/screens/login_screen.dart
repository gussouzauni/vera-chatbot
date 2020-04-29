import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
      body: Container(
        height: MediaQuery.of(context).size.height / 2,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(top: 52),
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width / 1.4,
              height: 100,
              child: LoginButton(
                text: 'Login com Google',
                icon: FontAwesomeIcons.google,
                color: Colors.blue,
                loginMethod: _auth.googleSignIn,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String text;
  final Function loginMethod;

  const LoginButton(
      {Key key, this.text, this.icon, this.color, this.loginMethod})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      child: FlatButton.icon(
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0)),
        padding: EdgeInsets.all(30),
        icon: Icon(icon, color: Colors.white),
        color: color,
        onPressed: () async {
          var user = await loginMethod();
          if (user != null) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Chatbot()));
          }
        },
        label: Expanded(
          child: Text(
            '$text',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
