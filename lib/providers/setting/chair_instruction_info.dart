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
    if (chair == null) return;
    
    final res = await service.request(
      '/device/get_info_by_mac',
      data: {
        'token': token,
        'mac': chair.mac,
      },
    );
    print('r: $res');
    if (res['success'] && res['data']['product'] != null) {
      this._range = res['data']['product']['useful_area'];
      this._enRange = res['data']['product']['en_useful_area'];
      this._installType = res['data']['product']['setup_type'];
      this._enInstallType = res['data']['product']['en_setup_type'];
      this._installVideoUrl = res['data']['product']['setup_video_url'];
      this._enInstallVideoUrl = res['data']['product']['en_setup_video_url'];
      notifyListeners();
    }
  }
}
