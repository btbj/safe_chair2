import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final String title;
  final String content;

  DetailPage({this.title, this.content});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text(
          title,
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              content,
              style: TextStyle(color: primaryColor, fontSize: 17),
            ),
          ),
        ],
      ),
    );
  }
}
