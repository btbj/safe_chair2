import 'package:flutter/material.dart';
import 'package:safe_chair2/l10n/app_localizations.dart';
import 'package:safe_chair2/model/l10nType.dart';
import 'package:safe_chair2/views/auth_pages/register/register.dart';
import 'package:safe_chair2/views/auth_pages/resetpwd/resetpwd.dart';

class NavRow extends StatelessWidget {
  Widget _buildRegisterBtn(BuildContext context) {
    return GestureDetector(
      child: Text(
        AppLocalizations.of(context).uiText(UiType.register_nav_text),
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
      onTap: () {
        print('register');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RegisterPage(),
          ),
        );
      },
    );
  }

  Widget _buildResetPwdBtn(BuildContext context) {
    return GestureDetector(
      child: Text(
        AppLocalizations.of(context).uiText(UiType.resetpwd_nav_text),
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
      onTap: () {
        print('reset pwd');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResetpwdPage(),
          ),
        );
      },
    );
  }

  Widget _buildButonRow(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        _buildRegisterBtn(context),
        Container(
          width: 1,
          height: 15,
          color: primaryColor,
          margin: EdgeInsets.symmetric(horizontal: 5.0),
        ),
        _buildResetPwdBtn(context),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 55.0, vertical: 5.0),
      child: _buildButonRow(context),
    );
  }
}
