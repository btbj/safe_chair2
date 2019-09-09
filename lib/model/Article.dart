import 'package:flutter/material.dart';
import 'package:safe_chair2/util/service.dart' as service;

class Article {
  final String id;
  String title;
  String dateTime;
  String content = '';

  Article({@required this.id, this.title = ''});
  factory Article.parse(Map json) {
    return Article(
      id: json['id'],
      title: json['title'],
    );
  }

  Future getContent() async {
    await Future.delayed(Duration(milliseconds: 200));
    final res = await service.request('/article/info', data: {
      'id': this.id,
    });
    // print(res);
    if (res['success']) {
      title = res['data']['info']['title'];
      content = res['data']['info']['content'];
    }
  }
}