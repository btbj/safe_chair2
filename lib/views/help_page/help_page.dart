import 'package:flutter/material.dart';
import 'package:safe_chair2/ui_components/head_bar.dart';
import 'package:safe_chair2/l10n/app_localizations.dart';
import 'package:safe_chair2/model/l10nType.dart';
import './components/list_box.dart';

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            HeadBar(
              title: AppLocalizations.of(context).uiText(UiType.help_title),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  ListBox(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
