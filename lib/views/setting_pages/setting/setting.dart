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
// import 'package:provider/provider.dart';
// import 'package:safe_chair2/providers/chair_control_info.dart';
// import 'package:safe_chair2/model/ChairState.dart';
// import 'package:safe_chair2/model/Chair.dart';
// import 'package:safe_chair2/util/notification_manager.dart';

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
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
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
      // floatingActionButton: FloatingActionButton(
      //   child: Text('Msg'),
      //   onPressed: () async {
      //     print('test');
      //     // // ChairControlInfo chairControlInfo = Provider.of<ChairControlInfo>(context);
      //     // String mac = Chair.checkMac('BLE003U');
      //     // print(mac);
      //     final nm = NotificationManager();
      //     if (await nm.init()) {
      //       nm.test(context, Duration(seconds: 2));
      //       // nm.pushMsg(context, 'aaa');
      //     }
      //   },
      // ),
    );
  }
}
