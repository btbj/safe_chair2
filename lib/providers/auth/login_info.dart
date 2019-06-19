import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:safe_chair2/util/service.dart' as service;

class LoginInfo with ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  
  String username = '';
  String password = '';

  Future<Map> login() async {
    print('login');

    final res = await service.request('/user/do_login', data: {
      'username': username,
      'password': password,
    });
    print(res);
    return res;
  }
}
