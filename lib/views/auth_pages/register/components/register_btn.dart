import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_chair2/providers/auth/register_info.dart';
import 'package:safe_chair2/ui_components/basic_btn.dart';
import 'package:safe_chair2/l10n/app_localizations.dart';
import 'package:safe_chair2/model/l10nType.dart';
import 'package:safe_chair2/ui_components/indicator.dart';
import 'package:safe_chair2/ui_components/toast.dart';

class RegisterBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterInfo>(builder: (context, registerInfo, _) {
      return BasicBtn(
        label: AppLocalizations.of(context).uiText(UiType.register_btn_text),
        onTap: () async {
          Indicator.show(context);
          print('username: ${registerInfo.username}');
          print('code: ${registerInfo.code}');
          print('password: ${registerInfo.password}');
          if (registerInfo.username.isEmpty ||
              registerInfo.code.isEmpty ||
              registerInfo.password.isEmpty) return;
          print('success');
          final res = await registerInfo.register();
          Indicator.close(context);
          Toast.show(context, msg: res['message']);
          if (res['success']) {
            Navigator.pop(context);
          }
        },
      );
    });
  }
}
