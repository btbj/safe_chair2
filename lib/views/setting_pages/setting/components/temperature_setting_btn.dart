import 'package:flutter/material.dart';
import 'package:safe_chair2/l10n/app_localizations.dart';
import 'package:safe_chair2/model/l10nType.dart';
import './menu_nav.dart';
import 'package:safe_chair2/views/setting_pages/temp_setting/temp_setting.dart';

class TemperatureSettingBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MenuNav(
      label: AppLocalizations.of(context).uiText(UiType.temperature_setting_title),
      onTap: () {
        print('nav to temperature_setting manage');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TempSettingPage(),
          ),
        );
      },
    );
  }
}