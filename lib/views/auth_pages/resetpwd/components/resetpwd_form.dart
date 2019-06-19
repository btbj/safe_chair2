import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_chair2/providers/auth/resetpwd_info.dart';
import 'package:safe_chair2/ui_components/input_box.dart';
import 'package:safe_chair2/l10n/app_localizations.dart';
import 'package:safe_chair2/model/l10nType.dart';
import './code_btn.dart';

class ResetpwdForm extends StatefulWidget {
  @override
  _ResetpwdFormState createState() => _ResetpwdFormState();
}

class _ResetpwdFormState extends State<ResetpwdForm> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _codeController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  void initState() {
    _usernameController.addListener(() {
      ResetpwdInfo _resetpwdInfo = Provider.of<ResetpwdInfo>(context);
      _resetpwdInfo.username = _usernameController.text;
    });
    _codeController.addListener(() {
      ResetpwdInfo _resetpwdInfo = Provider.of<ResetpwdInfo>(context);
      _resetpwdInfo.code = _codeController.text;
    });
    _passwordController.addListener(() {
      ResetpwdInfo _resetpwdInfo = Provider.of<ResetpwdInfo>(context);
      _resetpwdInfo.password = _passwordController.text;
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
    return Consumer<ResetpwdInfo>(builder: (context, resetpwdInfo, _) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 55.0, vertical: 5.0),
        child: Form(
          key: resetpwdInfo.formKey,
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
