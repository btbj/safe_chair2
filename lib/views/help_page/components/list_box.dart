import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_chair2/providers/article_list_info.dart';
// import 'package:safe_chair2/providers/app_info.dart';
import './title_btn.dart';
// import '../assets/help_docs_zh.dart' as zh;
// import '../assets/help_docs_en.dart' as en;

class ListBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ArticleListInfo>(builder: (context, articleListInfo, _) {
      // AppInfo appInfo = Provider.of<AppInfo>(context);
      // String lang = appInfo.isEN ? 'en' : 'zh';
      // articleListInfo.lang = lang;
      return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: List<Widget>.generate(articleListInfo.articleList.length, (index) {
          return TitleBtn(
            article: articleListInfo.articleList[index],
            // content: articleListInfo.articleList[index]['content'],
          );
        }),
      ),
    );
    });
  }
}
