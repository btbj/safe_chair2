import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
// import 'package:safe_chair2/model/ChairState.dart';
import 'package:safe_chair2/model/Chair.dart';
// import 'package:safe_chair2/util/service.dart' as service;
import 'package:safe_chair2/util/ble.dart';

class ChairControlInfo with ChangeNotifier, BleMixin{
  ChairControlInfo() {
    this.initChair();
    this.initBle();
  }
  // ChairState _chairState;
  // ChairState get chairState => _chairState;
  // bool get connected => _chairState != null;

  // bool hasBleError = false;
  // bool hasNotificationError = false;

  // Chair _targetChair = Chair(
  //   mac: 'fda50693-a4e2-4fb1-afcf-c6eb07647826',
  //   name: 'name',
  //   model: 'model',
  //   enName: 'enName',
  //   enModel: 'enModel',
  // );
  Chair _targetChair;
  Chair get targetChair => _targetChair;
  set targetChair(Chair value) {
    this._targetChair = value;
    Chair.setCurrentChair(value);
    notifyListeners();
  }

  void initChair() async {
    this._targetChair = await Chair.getCurrentChair();
    return;
  }

}
