import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_chair2/providers/app_info.dart';
import 'package:safe_chair2/l10n/app_localizations.dart';
import 'package:safe_chair2/model/l10nType.dart';

class VersionBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle =
        TextStyle(color: Colors.grey[700], fontSize: 12);
    return Consumer<AppInfo>(builder: (context, appInfo, _) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            AppLocalizations.of(context).uiText(UiType.account_prefix) +
                appInfo.user.username,
            style: textStyle,
          ),
          SizedBox(height: 3),
          Text(
            AppLocalizations.of(context).uiText(UiType.version_prefix) +
                appInfo.versionName + '(' + appInfo.versionCode + ')',
            style: textStyle,
          ),
          SizedBox(height: 3),
          Text(
            AppLocalizations.of(context).uiText(UiType.privacy_policy),
            style: textStyle,
          ),
        ],
      );
    });
  }
}
