import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_chair2/providers/app_info.dart';
import 'package:safe_chair2/providers/setting/chair_instruction_info.dart';
import 'package:safe_chair2/model/Chair.dart';
import 'package:safe_chair2/l10n/app_localizations.dart';
import 'package:safe_chair2/model/l10nType.dart';
import './components/info_box.dart';
import './components/video_btn.dart';

class ChairIntroPage extends StatelessWidget {
  final Chair chair;
  ChairIntroPage({this.chair});

  @override
  Widget build(BuildContext context) {
    AppInfo _appInfo = Provider.of<AppInfo>(context);
    return ChangeNotifierProvider(
      builder: (context) => ChairInstructionInfo(token: _appInfo.user.token, chair: chair),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            AppLocalizations.of(context).uiText(UiType.chair_intro_title),
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        ),
        body: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(height: 20),
                  InfoBox(),
                  SizedBox(height: 20),
                  VideoBtn(),
                ],
              ),
            ),
          ],
        ),
      ),
      
    );
  }
}