import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_chair2/providers/setting/chair_manage_info.dart';
import 'package:safe_chair2/model/Chair.dart';
import 'package:safe_chair2/ui_components/basic_btn.dart';
import 'package:safe_chair2/l10n/app_localizations.dart';
import 'package:safe_chair2/model/l10nType.dart';

class ScanBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ChairManageInfo>(builder: (context, chairManageInfo, _) {
      return BasicBtn(
        label: AppLocalizations.of(context).uiText(UiType.add_chair_btn_text),
        onTap: () {
          print('add chair');
          chairManageInfo.addChair(Chair(
            mac: 'fda50693-a4e2-4fb1-afcf-c6eb07647826',
            name: 'name',
            model: 'model',
            enName: 'enName',
            enModel: 'enModel',
          ));
        },
      );
    });
  }
}
