import 'package:flutter/material.dart';
import 'package:safe_chair2/l10n/app_localizations.dart';
import 'package:safe_chair2/model/l10nType.dart';
import './unit_switch.dart';

class UnitLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;

    return ListTile(
      title: Text(
          AppLocalizations.of(context).uiText(UiType.temperature_unit_label),
          style: TextStyle(color: primaryColor)),
      trailing: UnitSwitch(),
    );
  }
}
