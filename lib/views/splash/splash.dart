import 'dart:async';

import 'package:flutter/material.dart';
import 'package:safe_chair2/ui_components/FadeRoute.dart';
import 'package:safe_chair2/views/home/home.dart';
import 'package:safe_chair2/views/auth_pages/login/login.dart';
import 'package:safe_chair2/providers/app_info.dart';

class SplashPage extends StatefulWidget {
  final AppInfo appInfo;
  SplashPage(this.appInfo);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  StreamSubscription timerSub;
  @override
  void initState() {
    this.timerSub = this.widget.appInfo.splashSubject.listen((success) {
      timerSub.cancel();
      this.navToNextPage(success);
    });
    super.initState();
  }
  void navToNextPage(bool success) {
    Widget targetPage = success ? HomePage() : LoginPage();

    Navigator.of(context).pushAndRemoveUntil(
      FadeRoute(
        builder: (context) => targetPage,
        settings: RouteSettings(isInitialRoute: true),
      ),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                'lib/assets/img/logo/logo.png',
                height: 100,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 100)
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    this.timerSub?.cancel();
    super.dispose();
  }
}
