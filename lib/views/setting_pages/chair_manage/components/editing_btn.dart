import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_chair2/providers/setting/chair_manage_info.dart';
import 'package:safe_chair2/l10n/app_localizations.dart';
import 'package:safe_chair2/model/l10nType.dart';

class EditingBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ChairManageInfo>(builder: (context, chairManageInfo, _) {
      bool editing = chairManageInfo.editing;
      return FlatButton(
        child: Text(
          editing
              ? AppLocalizations.of(context).uiText(UiType.finish_btn)
              : AppLocalizations.of(context).uiText(UiType.edit_btn),
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        onPressed: () {
          chairManageInfo.editing = !editing;
        },
      );
    });
  }
}
