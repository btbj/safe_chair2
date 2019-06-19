import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_chair2/providers/auth/pwdchange_info.dart';
import 'package:safe_chair2/ui_components/basic_btn.dart';
import 'package:safe_chair2/l10n/app_localizations.dart';
import 'package:safe_chair2/model/l10nType.dart';

class ChangeBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PwdchangeInfo>(builder: (context, pwdchangeInfo, _) {
      return BasicBtn(
        label:
            AppLocalizations.of(context).uiText(UiType.reset_password_btn_text),
        onTap: () async {
          final result = await pwdchangeInfo.changepwd();
          print(result);
        },
      );
    });
  }
}
