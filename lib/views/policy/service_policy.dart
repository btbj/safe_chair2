import 'package:flutter/material.dart';
import 'package:safe_chair2/l10n/app_localizations.dart';
import 'package:safe_chair2/model/l10nType.dart';

class ServicePolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: primaryColor),
        title: Text(
          AppLocalizations.of(context).uiText(UiType.policy_title),
          style: TextStyle(color: primaryColor),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'service policy',
              style: TextStyle(color: primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
