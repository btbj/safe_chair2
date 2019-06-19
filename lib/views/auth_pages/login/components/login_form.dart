import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_chair2/providers/auth/login_info.dart';
import 'package:safe_chair2/ui_components/input_box.dart';
import 'package:safe_chair2/l10n/app_localizations.dart';
import 'package:safe_chair2/model/l10nType.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  void initState() {
    _usernameController.addListener(() {
      LoginInfo _loginInfo = Provider.of<LoginInfo>(context);
      _loginInfo.username = _usernameController.text;
    });
    _passwordController.addListener(() {
      LoginInfo _loginInfo = Provider.of<LoginInfo>(context);
      _loginInfo.password = _passwordController.text;
    });
    super.initState();
  }

  Widget _buildUsernameTextField() {
    return InputBox(
      controller: _usernameController,
      icon: Icons.person_outline,
      hintText: AppLocalizations.of(context).messageText(MessageType.email_hint),
    );
  }

  Widget _buildPasswordTextField() {
    return InputBox(
      controller: _passwordController,
      icon: Icons.lock_outline,
      hintText: AppLocalizations.of(context).messageText(MessageType.password_hint),
      obscureText: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginInfo>(builder: (context, loginInfo, _) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 55.0, vertical: 5.0),
        child: Form(
          key: loginInfo.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildUsernameTextField(),
              SizedBox(height: 15),
              _buildPasswordTextField(),
            ],
          ),
        ),
      );
    });
  }
}
