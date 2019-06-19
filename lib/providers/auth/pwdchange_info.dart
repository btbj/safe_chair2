import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
// import 'package:safe_chair2/util/service.dart' as service;

class PwdchangeInfo with ChangeNotifier {
  PwdchangeInfo(String username) {
    this._username = username;
  }
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  
  String _username = '';
  String get username => _username;
  String password = '';
  String passwordConfirm = '';

  Future<Map> changepwd() async {
    print('changepwd');
    return null;

    // final res = await service.request('/user/do_login', data: {
    //   'username': username,
    //   'password': password,
    // });
    // print(res);
    // return res;
  }

}
