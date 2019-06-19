import 'package:flutter/material.dart';
import 'package:safe_chair2/l10n/app_localizations.dart';
import 'package:safe_chair2/model/l10nType.dart';

class TitleRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
      AppLocalizations.of(context).uiText(UiType.register_title),
      // 'title',
      style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20),
    ),
    );
  }
}