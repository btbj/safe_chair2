import 'package:flutter/material.dart';
import 'package:safe_chair2/l10n/app_localizations.dart';
import 'package:safe_chair2/model/l10nType.dart';
import './components/high_temp_line.dart';
import './components/low_temp_line.dart';
import './components/unit_line.dart';

class TempSettingPage extends StatelessWidget {
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
          AppLocalizations.of(context).uiText(UiType.temperature_setting_title),
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: 20),
                HighTempLine(),
                LowTempLine(),
                _buildDivider(),
                UnitLine(),
              ],
            ),
          ),
        ],
      ),
      );
  }
}