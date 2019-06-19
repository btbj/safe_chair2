import 'dart:async';
import 'package:flutter/material.dart';
import 'package:safe_chair2/ui_components/FadeRoute.dart';
import 'package:safe_chair2/views/home/home.dart';
import 'package:safe_chair2/views/auth_pages/login/login.dart';
import 'package:provider/provider.dart';
import 'package:safe_chair2/providers/app_info.dart';

class SplashPage extends StatelessWidget {

  void startTimer(BuildContext context) async {
    print('start timer');
    // await Future.delayed(Duration(seconds: 3));

    // Navigator.of(context).pushAndRemoveUntil(
    //   FadeRoute(
    //     builder: (context) => HomePage(),
    //     settings: RouteSettings(isInitialRoute: true),
    //   ),
    //   (_) => false,
    // );

    Future delayTimer = Future.delayed(Duration(seconds: 3));
    AppInfo mainInfo = Provider.of<AppInfo>(context);

    Future.wait([mainInfo.autoLogin(), delayTimer]).then((values) {
      final bool autoLoginSuccess = values[0];
      navToNextPage(context, autoLoginSuccess);
    });
  }

  void navToNextPage(BuildContext context, bool success) {
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
    startTimer(context);
    return Scaffold(
      backgroundColor: Colors.black87,
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
}
