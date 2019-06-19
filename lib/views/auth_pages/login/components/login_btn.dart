import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_chair2/providers/auth/login_info.dart';
import 'package:safe_chair2/providers/app_info.dart';
import 'package:safe_chair2/ui_components/basic_btn.dart';
import 'package:safe_chair2/l10n/app_localizations.dart';
import 'package:safe_chair2/model/l10nType.dart';
import 'package:safe_chair2/ui_components/indicator.dart';
import 'package:safe_chair2/ui_components/toast.dart';
import 'package:safe_chair2/model/User.dart';
import 'package:safe_chair2/views/home/home.dart';

class LoginBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginInfo>(builder: (context, loginInfo, _) {
      return BasicBtn(
        label: AppLocalizations.of(context).uiText(UiType.login_btn_text),
        onTap: () async {
          Indicator.show(context);
          print('username: ${loginInfo.username}');
          print('password: ${loginInfo.password}');
          if (loginInfo.username.isEmpty || loginInfo.password.isEmpty) return;
          print('success');
          final res = await loginInfo.login();
          Indicator.close(context);
          Toast.show(context, msg: res['message']);
          if (res['success']) {
            final User user = User(
              token: res['data']['token']['token'],
              username: loginInfo.username,
            );
            User.saveUser(user);
            Provider.of<AppInfo>(context).user = user;
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
                settings: RouteSettings(isInitialRoute: true),
              ),
              (_) => false,
            );
          }
        },
      );
    });
  }
}
