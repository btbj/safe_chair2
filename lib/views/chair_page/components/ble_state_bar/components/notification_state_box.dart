import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_chair2/providers/chair_control_info.dart';
import 'package:safe_chair2/providers/app_info.dart';
import 'package:safe_chair2/l10n/app_localizations.dart';
import 'package:safe_chair2/model/l10nType.dart';

class NotificationStateBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ChairControlInfo>(builder: (context, chairControlInfo, _) {
      final bool hasError = chairControlInfo.hasNotificationError;
      final AppInfo appInfo = Provider.of<AppInfo>(context);
      return Container(
        height: 50,
        width: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(Icons.notifications, color: Colors.white, size: 14),
            Text(
              AppLocalizations.of(context).uiText(UiType.notification_state_text),
              style: TextStyle(color: Colors.white, fontSize: appInfo.isEN ? 10 : 14),
            ),
            SizedBox(width: 5),
            Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                color: hasError ? Colors.red : Colors.green,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ],
        ),
      );
    });
  }
}
