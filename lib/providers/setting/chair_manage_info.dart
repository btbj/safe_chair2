import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:safe_chair2/model/Chair.dart';
// import 'package:safe_chair2/util/service.dart' as service;

class ChairManageInfo with ChangeNotifier {
  ChairManageInfo() {
    initChairList();
  }
  List<Chair> _chairList = [];
  List<Chair> get chairList => _chairList;

  Future initChairList() async {
    final map = await Chair.getChairMap();
    this._chairList = List<Chair>.generate(map.length, (index) {
      return Chair.parse(map.values.toList()[index]);
    });
    notifyListeners();
    return;
  }

  Future addChair(Chair chair) async {
    this._chairList.add(chair);
    await Chair.saveChair(chair);
    notifyListeners();
    return;
  }

  Future deleteChair(Chair chair) async {
    this._chairList.remove(chair);
    await Chair.removeChair(chair);
    notifyListeners();
    return;
  }
  
}
