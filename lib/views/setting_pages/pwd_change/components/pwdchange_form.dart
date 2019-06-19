import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_chair2/providers/auth/pwdchange_info.dart';
import 'package:safe_chair2/ui_components/input_box.dart';
import 'package:safe_chair2/l10n/app_localizations.dart';
import 'package:safe_chair2/model/l10nType.dart';

class PwdchangeForm extends StatefulWidget {
  @override
  _PwdchangeFormState createState() => _PwdchangeFormState();
}

class _PwdchangeFormState extends State<PwdchangeForm> {
  TextEditingController _usernameController;
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _pwdConfirmController = TextEditingController();
  @override
  void initState() {
    _passwordController.addListener(() {
      PwdchangeInfo _pwdchangeInfo = Provider.of<PwdchangeInfo>(context);
      _pwdchangeInfo.password = _passwordController.text;
    });
    _pwdConfirmController.addListener(() {
      PwdchangeInfo _pwdchangeInfo = Provider.of<PwdchangeInfo>(context);
      _pwdchangeInfo.passwordConfirm = _pwdConfirmController.text;
    });
    super.initState();
  }

  Widget _buildUsernameTextField() {
    PwdchangeInfo _pwdchangeInfo = Provider.of<PwdchangeInfo>(context);
    _usernameController = TextEditingController(text: _pwdchangeInfo.username);
    return InputBox(
      enabled: false,
      controller: _usernameController,
      icon: Icons.person_outline,
      hintText: AppLocalizations.of(context).messageText(MessageType.email_hint),
    );
  }

  Widget _buildPasswordTextField() {
    return InputBox(
      controller: _passwordController,
      icon: Icons.lock_open,
      hintText: AppLocalizations.of(context).messageText(MessageType.password_hint),
      obscureText: true,
    );
  }
  Widget _buildPasswordConfirmTextField() {
    return InputBox(
      controller: _pwdConfirmController,
      icon: Icons.lock_open,
      hintText: AppLocalizations.of(context).messageText(MessageType.password_confirm_hint),
      obscureText: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PwdchangeInfo>(builder: (context, pwdchangeInfo, _) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 55.0, vertical: 5.0),
        child: Form(
          key: pwdchangeInfo.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildUsernameTextField(),
              SizedBox(height: 15),
              _buildPasswordTextField(),
              SizedBox(height: 15),
              _buildPasswordConfirmTextField()
            ],
          ),
        ),
      );
    });
  }
}
