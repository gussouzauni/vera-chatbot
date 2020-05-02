import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  Message({
    this.text,
    this.name,
    this.photo,
    this.type,
  });

  final String text;
  final String name;
  final String photo;
  final bool type;

  List<Widget> otherMessage(context) {
    return <Widget>[
      Container(
          margin: const EdgeInsets.only(right: 16.0),
          child: CircleAvatar(
            child: Image.asset(
              'assets/vera-bot.png',
            ),
          )),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              this.name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            Container(
              //custom message here
              margin: const EdgeInsets.only(top: 5.0),
              child: Text(
                text,
                style: TextStyle(fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    ];
  }

  List<Widget> myMessage(context) {
    return <Widget>[
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(this.name, style: Theme.of(context).textTheme.subhead),
            Container(
              margin: const EdgeInsets.only(top: 5.0),
              child: Text(
                text,
                style: TextStyle(fontSize: 15),
              ),
            ),
          ],
        ),
      ),
      Container(
          width: 40,
          height: 40,
          margin: const EdgeInsets.only(left: 16.0),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.fitHeight,
                image: NetworkImage(this.photo),
              ))),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: this.type ? myMessage(context) : otherMessage(context),
      ),
    );
  }
}
