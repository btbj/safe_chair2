// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:money_baby/providers/login.dart';
// import 'package:money_baby/ui_components/toast.dart';

// class CodeBtn extends StatefulWidget {
//   final int countSeconds;
//   final String getCodeText;
//   final String waitText;
//   CodeBtn(
//       {this.countSeconds = 10,
//       this.getCodeText = '获取验证码',
//       this.waitText = 's后获取'});

//   @override
//   _CodeBtnState createState() => _CodeBtnState();
// }

// class _CodeBtnState extends State<CodeBtn> {
//   bool usernameCheck(String username) {
//     if (username.isEmpty) return false;
//     RegExp regExp =
//         RegExp(r'^1[\d]{10}$$');
//     bool hasMatch = regExp.hasMatch(username);
//     return hasMatch;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<LoginInfo>(builder: (context, loginInfo, _) {
//       Function onPressed;
//       if (usernameCheck(loginInfo.username) && loginInfo.seconds == 0) {
//         onPressed = () async {
//           loginInfo.startCodeTimer();
//           final res = await loginInfo.getOtpCode();
//           Toast.show(context, msg: res['message']);
//         };
//       }

//       return FlatButton(
//         child: Text(loginInfo.gettingCode ? '${loginInfo.seconds}${this.widget.waitText}': '${this.widget.getCodeText}'),
//         onPressed: onPressed,
//         color: Colors.green,
//         textColor: Colors.white,
//         disabledColor: Colors.grey[300],
//         padding: EdgeInsets.symmetric(vertical: 5),
//       );
//     });
//   }
// }
