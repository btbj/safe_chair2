import 'package:flutter/material.dart';
import 'package:safe_chair2/l10n/app_localizations.dart';
import 'package:safe_chair2/model/l10nType.dart';
import 'package:safe_chair2/views/setting_pages/language_setting/language_setting.dart';
import './menu_nav.dart';

class LanguageSettingBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MenuNav(
      label: AppLocalizations.of(context).uiText(UiType.language_setting_title),
      onTap: () {
        print('nav to language_setting manage');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LanguageSettingPage(),
          ),
        );
      },
    );
  }
}
