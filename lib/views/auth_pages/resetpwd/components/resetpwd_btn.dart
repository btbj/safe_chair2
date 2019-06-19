import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_chair2/providers/auth/resetpwd_info.dart';
import 'package:safe_chair2/ui_components/basic_btn.dart';
import 'package:safe_chair2/l10n/app_localizations.dart';
import 'package:safe_chair2/model/l10nType.dart';

class ResetpwdBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ResetpwdInfo>(builder: (context, resetpwdInfo, _) {
      return BasicBtn(
        label: AppLocalizations.of(context).uiText(UiType.resetpwd_btn),
        onTap: () async {
          print('username: ${resetpwdInfo.username}');
          print('code: ${resetpwdInfo.code}');
          print('password: ${resetpwdInfo.password}');
          if (resetpwdInfo.username.isEmpty ||
              resetpwdInfo.code.isEmpty ||
              resetpwdInfo.password.isEmpty) return;
          print('success');
        },
      );
    });
  }
}
