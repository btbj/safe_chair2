import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_chair2/providers/app_info.dart';
import 'package:safe_chair2/ui_components/basic_btn.dart';
import 'package:safe_chair2/l10n/app_localizations.dart';
import 'package:safe_chair2/model/l10nType.dart';
import 'package:safe_chair2/views/auth_pages/login/login.dart';

class LogoutBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppInfo>(
      builder: (context, appInfo, _) {
        return BasicBtn(
          label: AppLocalizations.of(context).uiText(UiType.logout_btn_text),
          onTap: () async {
            await appInfo.logout();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
              (_) => false,
            );
          },
        );
      },
    );
  }
}
