import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:safe_chair2/model/Article.dart';
// import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:safe_chair2/util/service.dart' as service;
// import 'package:intl/intl.dart';

class ArticleListInfo with ChangeNotifier {
  ArticleListInfo({@required String title, @required String cateId, String lang}) {
    this._listTitleText = title;
    this.lang = lang;
    initList(reload: true, cateId: cateId);
  }

  String _lang = 'zh';
  String get lang => _lang;
  set lang(String value) {
    this._lang = value;
    // print('set lang $value');
    notifyListeners();
  }

  String _listTitleText;
  String get listTitleText => _listTitleText;
  List<Article> _articleListZh = [];
  List<Article> _articleListEn = [];
  List<Article> get articleList {
    if (lang == 'en') return _articleListEn;
    else return _articleListZh;
  }
  int pageSize = 999;
  String preCateId = '';

  Future initList({bool reload = false, @required String cateId}) async {
    await this.getListInfo(reload: reload, cateId: cateId, targetLang: 'zh');
    await this.getListInfo(reload: reload, cateId: cateId, targetLang: 'en');
  }

  Future<List> getListInfo(
      {bool reload = false, String cateId = '', String targetLang}) async {
    List targetlist = targetLang == 'en' ? this._articleListEn : this._articleListZh;
    if (reload) {
      targetlist.clear();
      preCateId = cateId;
      // notifyListeners();
    }

    final res = await service.request('/article/articles', data: {
      'by': targetlist.isEmpty ? null : targetlist.last.id,
      'lang': targetLang,
      'per_page': pageSize,
      'category': preCateId,
    });
    // print(res);
    if (!res['success']) return null;
    final List list = res['data']['articles'];
    final resultList = List<Article>.generate(list.length, (index) {
      return Article.parse(list[index]);
    });
    targetlist.addAll(resultList);
    notifyListeners();
    return targetlist;
  }
}
