import 'package:flutter/material.dart';
import 'package:safe_chair2/model/Article.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class DetailPage extends StatelessWidget {
  final Article article;

  DetailPage({this.article});

  @override
  Widget build(BuildContext context) {
    // final Color primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          article.title,
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      ),
      body: ListView(
        children: <Widget>[
          FutureBuilder<Object>(
              future: article.getContent(),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) return Container();
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  // child: Text(
                  //   article.content.isEmpty ? '' : article.content,
                  //   style: TextStyle(color: primaryColor, fontSize: 17),
                  // ),
                  child: HtmlWidget(
                    article.content,
                    // textStyle: TextStyle(color: primaryColor),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
