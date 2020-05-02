import 'package:flutter/material.dart';
import 'package:Vera/chatbot/chatbot.dart';
import 'package:Vera/services/auth.dart';

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
        _auth.signOut();
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
      backgroundColor: const Color(0xff142032),
      body: Container(
        margin: EdgeInsets.only(top: 70),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: 100,
              height: 200,
              child: Image.asset('assets/vera.png'),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                margin: EdgeInsets.only(bottom: 30),
                child: LoginButton(
                  text: 'Login',
                  color: const Color(0xffF71963),
                  loginMethod: _auth.googleSignIn,
                ),
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
      decoration: BoxDecoration(shape: BoxShape.circle),
      child: FlatButton.icon(
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(50.0)),
        padding: EdgeInsets.all(10),
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
