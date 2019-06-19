import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_chair2/providers/auth/resetpwd_info.dart';
import 'package:safe_chair2/ui_components/toast.dart';

class CodeBtn extends StatefulWidget {
  final String getCodeText;
  final String waitText;
  CodeBtn({@required this.getCodeText, @required this.waitText});

  @override
  _CodeBtnState createState() => _CodeBtnState();
}

class _CodeBtnState extends State<CodeBtn> {
  bool usernameCheck(String username) {
    if (username.isEmpty) return false;
    RegExp regExp = RegExp(r'^\w[-\w.+]*@([A-Za-z0-9][-A-Za-z0-9]+\.)+[A-Za-z]{2,14}$');
    bool hasMatch = regExp.hasMatch(username);
    return hasMatch;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ResetpwdInfo>(builder: (context, resetpwdInfo, _) {
      Function onPressed;
      if (usernameCheck(resetpwdInfo.username) && resetpwdInfo.seconds == 0) {
        onPressed = () async {
          resetpwdInfo.startCodeTimer();
          final res = await resetpwdInfo.getOtpCode();
          Toast.show(context, msg: res['message']);
        };
      }

      return FlatButton(
        child: Text(resetpwdInfo.gettingCode
            ? '${resetpwdInfo.seconds}${this.widget.waitText}'
            : '${this.widget.getCodeText}'),
        onPressed: onPressed,
        color: Theme.of(context).primaryColor,
        disabledColor: Colors.grey,
        padding: EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.only(
            topEnd: Radius.circular(12.0),
            bottomEnd: Radius.circular(12.0),
          ),
        ),
      );
    });
  }
}
