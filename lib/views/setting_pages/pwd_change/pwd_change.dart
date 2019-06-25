import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_chair2/providers/app_info.dart';
import 'package:safe_chair2/providers/auth/pwdchange_info.dart';
import 'package:safe_chair2/l10n/app_localizations.dart';
import 'package:safe_chair2/model/l10nType.dart';
import './components/pwdchange_form.dart';
import './components/change_btn.dart';

class PwdChangePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppInfo appInfo = Provider.of<AppInfo>(context);

    return ChangeNotifierProvider<PwdchangeInfo>(
      builder: (context) => PwdchangeInfo(appInfo.user.username),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            AppLocalizations.of(context).uiText(UiType.password_setting_title),
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        ),
        body: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(height: 20),
                  PwdchangeForm(),
                  SizedBox(height: 20),
                  ChangeBtn(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
