import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:safe_chair2/model/Chair.dart';
import 'package:safe_chair2/util/service.dart' as service;

class ChairManageInfo with ChangeNotifier {
  ChairManageInfo() {
    initChairNameMap();
    initChairList();
  }
  bool _mounted = true;
  List<Chair> _chairList = [];
  List<Chair> get chairList => _chairList;
  bool _editing = false;
  bool get editing => _editing;
  set editing(bool value) {
    this._editing = value;
    if (_mounted) {
      notifyListeners();
    }
  }

  Map _chairNameMap = {};
  Map get chairNameMap => this._chairNameMap;

  Future initChairList() async {
    final map = await Chair.getChairMap();
    this._chairList = List<Chair>.generate(map.length, (index) {
      return Chair.parse(map.values.toList()[index]);
    });
    if (_mounted) {
      notifyListeners();
    }
    return;
  }

  Future initChairNameMap() async {
    final map = await Chair.getNameMap();
    this._chairNameMap = map;
    if (_mounted) {
      notifyListeners();
    }
    return;
  }

  void saveName(Chair chair, String name) async {
    if (name.isEmpty) {
      this._chairNameMap.remove(chair.uuid);
    } else {
      this._chairNameMap[chair.uuid] = name;
    }
    await chair.saveName(name);
    if (_mounted) {
      notifyListeners();
    }
    return;
  }

  Future addChair(Chair chair) async {
    this._chairList.add(chair);
    await Chair.saveChair(chair);
    if (_mounted) {
      notifyListeners();
    }
    return;
  }

  Future deleteChair(Chair chair) async {
    this._chairList.remove(chair);
    await Chair.removeChair(chair);
    if (_mounted) {
      notifyListeners();
    }
    return;
  }

  Future<Map> getChairInfoByMac({String token, String mac}) async {
    print('get chair info by mac');

    final res = await service.request(
      '/device/get_info_by_mac',
      data: {
        'token': token,
        'mac': mac,
      },
    );
    print('r: $res');
    return res;
  }

  @override
  void dispose() {
    super.dispose();
    _mounted = false;
  }
}
