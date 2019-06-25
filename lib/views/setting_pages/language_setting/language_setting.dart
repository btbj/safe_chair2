import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_chair2/providers/app_info.dart';
import 'package:safe_chair2/l10n/app_localizations.dart';
import 'package:safe_chair2/model/l10nType.dart';
import 'package:intl/intl.dart';

class LanguageSettingPage extends StatelessWidget {
  bool checkEnglish() {
    final String currentLanguageCode = Intl.getCurrentLocale();
    final String shortLocaleCode = Intl.shortLocale(currentLanguageCode);
    // print('$currentLanguageCode $shortLocaleCode');
    return shortLocaleCode != 'zh';
  }

  Widget _buildChineseLine(bool isEN) {
    return Consumer<AppInfo>(builder: (context, appInfo, _) {
      final Color primaryColor = Theme.of(context).primaryColor;
      return ListTile(
        title: Text('中文', style: TextStyle(color: primaryColor, fontSize: 16)),
        trailing: isEN ? SizedBox(width: 10) : Icon(Icons.check_circle, color: primaryColor),
        onTap: () {
          if (isEN) {
            Intl.defaultLocale = 'zh';
            appInfo.locale = Locale('zh');
          }
        },
      );
    });
    
  }

  Widget _buildEnglishLine(bool isEN) {
    return Consumer<AppInfo>(builder: (context, appInfo, _) {
      final Color primaryColor = Theme.of(context).primaryColor;
      return ListTile(
        title: Text('English', style: TextStyle(color: primaryColor, fontSize: 16)),
        trailing: !isEN ? SizedBox(width: 10) : Icon(Icons.check_circle, color: primaryColor),
        onTap: () {
          if (!isEN) {
            Intl.defaultLocale = 'en';
            appInfo.locale = Locale('en');
          }
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isEN = checkEnglish();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          AppLocalizations.of(context).uiText(UiType.language_setting_title),
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _buildChineseLine(isEN),
                _buildEnglishLine(isEN),
              ],
            ),
          ),
        ],
      ),
    );
  }
}