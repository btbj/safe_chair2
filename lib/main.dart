import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:safe_chair2/l10n/app_localizations.dart';
import 'package:safe_chair2/model/l10nType.dart';
import 'package:safe_chair2/views/splash/splash.dart';
import 'package:provider/provider.dart';
import 'package:safe_chair2/providers/app_info.dart';
import 'package:safe_chair2/providers/chair_control_info.dart';
import 'package:safe_chair2/providers/article_list_info.dart';

void main() async {
  // 设置不能横屏
  // await SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);

  // SystemChrome.setSystemUIOverlayStyle(
  //   SystemUiOverlayStyle.dark.copyWith(
  //     statusBarBrightness: Brightness.dark,
  //   ),
  // );
  ErrorWidget.builder = (FlutterErrorDetails flutterErrorDetails) {
    // print(flutterErrorDetails.toString());
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text("On Error", textDirection: TextDirection.ltr),
          Text(flutterErrorDetails.exceptionAsString(), textDirection: TextDirection.ltr),
          Text(flutterErrorDetails.stack.toString(), textDirection: TextDirection.ltr, maxLines: 20),
        ],
      ),
    );
  };

  Future<Null> _reportError(dynamic error, dynamic stackTrace) async {
    print('catch error=' + error.toString());
  }

  FlutterError.onError = (FlutterErrorDetails details) async {
    Zone.current.handleUncaughtError(details.exception, details.stack);
  };

  runZoned(() async {
    runApp(MyApp());
  }, onError: (error, stackTrace) async {
    await _reportError(error, stackTrace);
  });
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
        statusBarBrightness: Brightness.dark,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppInfo>(builder: (context) => AppInfo()),
        ChangeNotifierProvider<ChairControlInfo>(
            builder: (context) => ChairControlInfo()),
        ChangeNotifierProvider<ArticleListInfo>(
            builder: (context) => ArticleListInfo(title: 'help', cateId: '1')),
      ],
      child: MyAppRoot(),
    );
    // return ChangeNotifierProvider<AppInfo>(
    //   builder: (context) => AppInfo(),
    //   child: MyAppRoot(),
    // );
  }
}

class MyAppRoot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // print([1, 2, 3][6]);
    return Consumer<AppInfo>(builder: (context, info, _) {
      return MaterialApp(
          onGenerateTitle: (context) =>
              AppLocalizations.of(context).uiText(UiType.app_title),
          // debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Color.fromARGB(255, 217, 132, 44),
          ),
          home: SplashPage(info),
          locale: info.locale,
          localizationsDelegates: [
            AppLocalizationsDelegate(),
            CupertinoLocalizationsDelegate.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [
            // 支持语言设置
            const Locale('en', 'US'), // English
            const Locale('zh', 'CH'), // Chinese
          ]);
    });
  }
}
