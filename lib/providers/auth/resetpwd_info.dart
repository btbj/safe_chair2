import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:safe_chair2/util/service.dart' as service;

class ResetpwdInfo with ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  
  String _username = '';
  String get username => _username;
  set username(String value) {
    this._username = value;
    notifyListeners();
  }
  String code = '';
  String password = '';

  Timer codeTimer;
  int _seconds = 0;
  int get seconds => _seconds;
  set seconds(int value) {
    this._seconds = value;
    notifyListeners();
  }
  bool get gettingCode => _seconds != 0;

  void startCodeTimer() {
    print('start timer');
    this.seconds = 120;
    codeTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      this.seconds = this.seconds - 1;
      print(this.seconds);
      if (this.seconds == 0) {
        timer.cancel();
      }
    });
  }

  void cancelCodeTimer() {
    this.seconds = 0;
    codeTimer?.cancel();
  }

  Future getOtpCode() async {
    final res = await service.request(
      '/user/send_email',
      data: {'username': username},
    );
    print('r: $res');
    if (!res['success']) {
      cancelCodeTimer();
    }
    return res;
  }

  Future<Map> resetpwd() async {
    print('resetpwd');
    return null;

    // final res = await service.request('/user/do_login', data: {
    //   'username': username,
    //   'password': password,
    // });
    // print(res);
    // return res;
  }

  @override
  void dispose() {
    // print('cancel code timer');
    this.cancelCodeTimer();
    super.dispose();
  }
}
