import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:safe_chair2/providers/app_info.dart';
import 'package:safe_chair2/providers/setting/chair_manage_info.dart';
// import 'package:safe_chair2/model/Chair.dart';
import 'package:safe_chair2/l10n/app_localizations.dart';
import 'package:safe_chair2/model/l10nType.dart';
import './components/chair_list.dart';
import './components/scan_btn.dart';
import './components/editing_btn.dart';
import './components/connect_indicator.dart';

class ChairManagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => ChairManageInfo(),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            AppLocalizations.of(context).uiText(UiType.chair_manage_title),
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
          actions: <Widget>[
            EditingBtn(),
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
                  ChairList(),
                  SizedBox(height: 20),
                  ScanBtn(),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Text('test'),
          onPressed: () {
            print('test');
            ConnectIndicator.show(context);
          },
        ),
      ),
    );
  }
}
