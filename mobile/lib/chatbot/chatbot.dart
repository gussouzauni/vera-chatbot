import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'package:Vera/model/message.dart';
import 'package:Vera/services/auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class Chatbot extends StatefulWidget {
  Chatbot({
    Key key,
    this.title,
  }) : super(key: key);

  final String title;

  @override
  HomeScreenDialogFlow createState() => HomeScreenDialogFlow();
}

class HomeScreenDialogFlow extends State<Chatbot> {
  Auth auth = new Auth();
  final List<Message> _messages = <Message>[];
  final TextEditingController _textController = TextEditingController();
  final String svg = 'assets/vtex.svg';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildTextComposer() {
    FirebaseUser user = Provider.of<FirebaseUser>(context);
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextFormField(
                onChanged: (v) {},
                controller: _textController,
                onFieldSubmitted: _handleSubmitted,
                decoration:
                    InputDecoration.collapsed(hintText: "Envie uma mensagem"),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                color: const Color(0xffF71963),
                icon: Icon(Icons.send),
                onPressed: () => _handleSubmitted(_textController.text,
                    user.displayName, user.photoUrl, user),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void response(query) async {
    _textController.clear();
    AuthGoogle authGoogle = await AuthGoogle(
      fileJson: "assets/chatbot.json",
    ).build();

    Dialogflow dialogflow = Dialogflow(
      authGoogle: authGoogle,
      language: Language.english,
    );

    AIResponse response = await dialogflow.detectIntent(query);

    Message message = Message(
      text: response.getMessage() ??
          CardDialogflow(
            response.getListMessage()[0],
          ).title,
      name: "Vera",
      type: false,
    );
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleSubmitted(String text,
      [String name, String photo, FirebaseUser user]) {
    _textController.clear();
    Message message = Message(
      text: text,
      name: name,
      photo: photo,
      type: true,
    );
    setState(() {
      if (text.isNotEmpty) {
        _messages.insert(0, message);
      }
    });

    response(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: <Widget>[
        Container(
          height: 70,
          width: double.maxFinite,
          color: const Color(0xff142032),
          child: Padding(
            padding: EdgeInsets.only(top: 20),
            child: SvgPicture.asset(
              svg,
              color: const Color(0xffF71963),
            ),
          ),
        ),
        Flexible(
            child: ListView.builder(
          padding: EdgeInsets.all(8.0),
          reverse: true,
          itemBuilder: (_, int index) => _messages[index],
          itemCount: _messages.length,
        )),
        Divider(height: 1.0),
        Container(
          decoration: BoxDecoration(color: Theme.of(context).cardColor),
          child: _buildTextComposer(),
        ),
      ]),
    );
  }
}
