import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_chair2/providers/chair_control_info.dart';
import 'package:safe_chair2/providers/app_info.dart';
import 'package:safe_chair2/l10n/app_localizations.dart';
import 'package:safe_chair2/model/l10nType.dart';

class ProtectBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ChairControlInfo>(builder: (context, chairControlInfo, _) {
      final bool haveChair = chairControlInfo.targetChair != null;
      final AppInfo appInfo = Provider.of<AppInfo>(context);

      final Color displayColor =
          chairControlInfo.connected ? Colors.blue : Colors.grey;
      String displayText = haveChair
          ? AppLocalizations.of(context).uiText(UiType.beacon_set_text)
          : AppLocalizations.of(context).uiText(UiType.beacon_notset_text);
      if (chairControlInfo.connected)
        displayText =
            AppLocalizations.of(context).uiText(UiType.beacon_protecting_text);

      return Container(
        height: 60,
        width: 60,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: displayColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Container(
          height: 56,
          width: 56,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Container(
            height: 50,
            width: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: displayColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              displayText,
              style: TextStyle(fontSize: appInfo.isEN ? 9 : 12),
            ),
          ),
        ),
      );
    });
  }
}
