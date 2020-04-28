import 'package:flutter/material.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'package:mobile/model/message.dart';

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
  final List<Message> _messages = <Message>[];
  final TextEditingController _textController = TextEditingController();

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration:
                    InputDecoration.collapsed(hintText: "Enviar uma mensagem"),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: () => _handleSubmitted(_textController.text),
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
      name: "Bot",
      type: false,
    );
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    Message message = Message(
      text: text,
      name: "Gustavo Souza",
      type: true,
    );
    setState(() {
      _messages.insert(0, message);
    });
    response(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("ChatBot - VTex"),
        backgroundColor: Colors.amber,
      ),
      body: Column(children: <Widget>[
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
