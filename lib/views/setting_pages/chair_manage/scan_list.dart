import 'package:flutter/material.dart';
import 'package:safe_chair2/l10n/app_localizations.dart';
import 'package:safe_chair2/model/l10nType.dart';
import './components/scan_result_list.dart';
import './components/stop_scan_btn.dart';

class ScanListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          AppLocalizations.of(context).uiText(UiType.chair_manage_title),
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        actions: <Widget>[
          StopScanBtn(),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: 20),
                ScanResultList(),
                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
