import 'package:flutter/material.dart';
import 'package:safe_chair2/model/Article.dart';
import './detail_page.dart';

class TitleBtn extends StatelessWidget {
  final Article article;
  TitleBtn({this.article});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return ListTile(
      title: Text(article.title, style: TextStyle(color: primaryColor)),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(article: article),
          ),
        );
      },
    );
  }
}
