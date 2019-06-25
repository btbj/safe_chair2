import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:safe_chair2/model/User.dart';
import 'package:package_info/package_info.dart';
import 'package:intl/intl.dart';
// import 'package:safe_chair2/util/service.dart' as service;
import 'package:rxdart/rxdart.dart';
import 'package:safe_chair2/model/Lang.dart';

class AppInfo with ChangeNotifier {
  AppInfo() {
    this.getVersionInfo();
    this.startSplashTimer();
  }

  PublishSubject<bool> splashSubject = PublishSubject();

  String _versionName;
  String get versionName => _versionName;

  User _user;
  User get user => _user;
  set user(User value) {
    _user = value;
    notifyListeners();
  }

  Locale _locale;
  Locale get locale => _locale;
  set locale(Locale value) {
    this._locale = value;
    Lang.saveLang(value);
    notifyListeners();
  }
  bool get isEN {
    final String currentLanguageCode = Intl.getCurrentLocale();
    final String shortLocaleCode = Intl.shortLocale(currentLanguageCode);
    // print('$currentLanguageCode $shortLocaleCode');
    return shortLocaleCode != 'zh';
  }

  void logout() {
    _user = null;
    User.saveUser(null);
    notifyListeners();
  }

  Future<bool> autoLogin() async {
    final User storedUser = await User.getUser();
    
    if(storedUser == null) {
      return false;
    } else {
      this._user = storedUser;
      return true;
    }

    // final res = await service.request('/user/refresh_token', data: {
    //   'token': storedUser.token,
    //   'username': storedUser.username,
    // });
    // print('autoLogin: $res');
    // if (res['success']) {
    //   this.user = User(
    //     token: res['data']['token'],
    //     username: storedUser.username,
    //   );
    //   User.saveUser(user);
    // }
    // return res;
  }

  void getVersionInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _versionName = packageInfo.version;
  }

  Future initLang() async {
    this._locale = await Lang.getLang();
    notifyListeners();
    return;
  }

  void startSplashTimer() async {
    print('start splash timer');
    Future delayTimer = Future.delayed(Duration(seconds: 3));

    Future.wait([this.autoLogin(), delayTimer, this.initLang()]).then((values) {
      final bool autoLoginSuccess = values[0];
      splashSubject.add(autoLoginSuccess);
    });
  }

  @override
  void dispose() {
    splashSubject.close();
    super.dispose();
  }
}
