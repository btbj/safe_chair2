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
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark.copyWith(
      statusBarBrightness: Brightness.dark,
    ),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppInfo>(builder: (context) => AppInfo()),
        ChangeNotifierProvider<ChairControlInfo>(builder: (context) => ChairControlInfo()),
        ChangeNotifierProvider<ArticleListInfo>(builder: (context) => ArticleListInfo(title: 'help', cateId: '1')),
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
    return Consumer<AppInfo>(builder: (context, info, _) {
      return MaterialApp(
          onGenerateTitle: (context) => AppLocalizations.of(context).uiText(UiType.app_title),
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
