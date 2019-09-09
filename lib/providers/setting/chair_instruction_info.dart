import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:safe_chair2/model/Chair.dart';
import 'package:safe_chair2/util/service.dart' as service;

class ChairInstructionInfo with ChangeNotifier {
  ChairInstructionInfo({@required String token, @required Chair chair}) {
    this._targetChair = chair;
    this.getChairInfo(token: token, chair: chair);
  }

  bool isEN = Chair.checkEnglish();
  Chair _targetChair;
  Chair get targetChair => _targetChair;

  String get chairName {
    if (_targetChair == null) return '';
    return _targetChair.nameText;
  }

  String get chairModel {
    if (_targetChair == null) return '';
    return _targetChair.modelText;
  }

  String _range = '';
  String _enRange = '';
  String get chairRange => isEN ? _enRange : _range;

  String _installType = '';
  String _enInstallType = '';
  String get chairInstallType => isEN ? _enInstallType : _installType;

  String _installVideoUrl;
  String _enInstallVideoUrl;
  String get chairInstallVideoUrl =>
      isEN ? _enInstallVideoUrl : _installVideoUrl;

  void getChairInfo({String token, Chair chair}) async {
    print('get chair info');
    if (chair == null) return null;
    
    final res = await service.request(
      '/device/get_info_by_mac',
      data: {
        'token': token,
        'mac': chair.mac,
      },
    );
    print('r: $res');
    if (res['success'] && res['data']['product'] != null) {
      Map json = res['data']['product'];
      this._range = json['useful_area'];
      this._enRange = json['en_useful_area'];
      this._installType = json['setup_type'];
      this._enInstallType = json['en_setup_type'];
      this._installVideoUrl = json['setup_video_url'];
      this._enInstallVideoUrl = json['en_setup_video_url'];
      Chair newChair = Chair(
        uuid: targetChair.uuid,
        mac: targetChair.mac,
        name: json['name'],
        model: json['model'],
        enName: json['en_name'],
        enModel: json['en_model'],
      );
      await Chair.saveChair(newChair);
      this._targetChair = newChair;
      notifyListeners();
    }
  }
}
