import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_chair2/providers/app_info.dart';
import './title_btn.dart';
import '../assets/help_docs_zh.dart' as zh;
import '../assets/help_docs_en.dart' as en;

class ListBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppInfo appInfo = Provider.of<AppInfo>(context);
    bool isEN = appInfo.isEN;
    List articles = isEN ? en.articles : zh.articles;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: List<Widget>.generate(articles.length, (index) {
          return TitleBtn(
            title: articles[index]['title'],
            content: articles[index]['content'],
          );
        }),
      ),
    );
  }
}
