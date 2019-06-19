import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_chair2/providers/auth/register_info.dart';
import 'package:safe_chair2/ui_components/input_box.dart';
import 'package:safe_chair2/l10n/app_localizations.dart';
import 'package:safe_chair2/model/l10nType.dart';
import './code_btn.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _codeController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  void initState() {
    _usernameController.addListener(() {
      RegisterInfo _registerInfo = Provider.of<RegisterInfo>(context);
      _registerInfo.username = _usernameController.text;
    });
    _codeController.addListener(() {
      RegisterInfo _registerInfo = Provider.of<RegisterInfo>(context);
      _registerInfo.code = _codeController.text;
    });
    _passwordController.addListener(() {
      RegisterInfo _registerInfo = Provider.of<RegisterInfo>(context);
      _registerInfo.password = _passwordController.text;
    });
    super.initState();
  }

  Widget _buildUsernameTextField() {
    return InputBox(
      controller: _usernameController,
      icon: Icons.email,
      hintText:
          AppLocalizations.of(context).messageText(MessageType.email_hint),
    );
  }

  Widget _buildCodeTextField() {
    return InputBox(
      controller: _codeController,
      icon: Icons.more_horiz,
      hintText: AppLocalizations.of(context).messageText(MessageType.code_hint),
      suffix: CodeBtn(
        getCodeText:
            AppLocalizations.of(context).uiText(UiType.code_btn_get_code),
        waitText: AppLocalizations.of(context).uiText(UiType.code_btn_seconds),
      ),
    );
  }

  Widget _buildPasswordTextField() {
    return InputBox(
      controller: _passwordController,
      icon: Icons.lock_open,
      hintText:
          AppLocalizations.of(context).messageText(MessageType.password_hint),
      obscureText: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterInfo>(builder: (context, registerInfo, _) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 55.0, vertical: 5.0),
        child: Form(
          key: registerInfo.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildUsernameTextField(),
              SizedBox(height: 15),
              _buildCodeTextField(),
              SizedBox(height: 15),
              _buildPasswordTextField(),
            ],
          ),
        ),
      );
    });
  }
}
