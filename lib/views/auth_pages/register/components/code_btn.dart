import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_chair2/providers/auth/register_info.dart';
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
    return Consumer<RegisterInfo>(builder: (context, registerInfo, _) {
      Function onPressed;
      if (usernameCheck(registerInfo.username) && registerInfo.seconds == 0) {
        onPressed = () async {
          registerInfo.startCodeTimer();
          final res = await registerInfo.getOtpCode();
          Toast.show(context, msg: res['message']);
        };
      }

      return FlatButton(
        child: Text(registerInfo.gettingCode
            ? '${registerInfo.seconds}${this.widget.waitText}'
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
