import 'package:flutter/material.dart';
import 'package:safe_chair2/l10n/app_localizations.dart';
import 'package:safe_chair2/model/l10nType.dart';
import './menu_nav.dart';
import 'package:safe_chair2/views/setting_pages/pwd_change/pwd_change.dart';

class PasswordSettingBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MenuNav(
      label: AppLocalizations.of(context).uiText(UiType.password_setting_title),
      onTap: () {
        print('nav to password_setting');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PwdChangePage(),
          ),
        );
      },
    );
  }
}