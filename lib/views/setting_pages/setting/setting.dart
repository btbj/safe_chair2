import 'package:flutter/material.dart';
import 'package:safe_chair2/l10n/app_localizations.dart';
import 'package:safe_chair2/model/l10nType.dart';
import './components/chair_manage_btn.dart';
import './components/chair_intro_btn.dart';
import './components/temperature_setting_btn.dart';
import './components/password_setting_btn.dart';
import './components/language_setting_btn.dart';
import './components/logout_btn.dart';
import './components/version_box.dart';

class SettingPage extends StatelessWidget {
  Widget _buildDivider() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.0),
      child: Divider(color: Colors.grey),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text(
          AppLocalizations.of(context).uiText(UiType.setting_title),
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                ChairManageBtn(),
                ChairIntroBtn(),
                _buildDivider(),
                TemperatureSettingBtn(),
                PasswordSettingBtn(),
                LanguageSettingBtn(),
                SizedBox(height: 20),
                LogoutBtn(),
                SizedBox(height: 15),
                VersionBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
