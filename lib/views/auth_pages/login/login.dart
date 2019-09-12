import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_chair2/providers/auth/login_info.dart';
import './components/logo_box.dart';
import './components/login_form.dart';
import './components/nav_row.dart';
import './components/login_btn.dart';
import './components/policy_row.dart';
import 'package:safe_chair2/ui_components/lang_btn.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginInfo>(
      builder: (context) => LoginInfo(),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          backgroundColor: Colors.black,
          body: ListView(
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 60),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        LangBtn(),
                      ],
                    ),
                    LogoBox(),
                    SizedBox(height: 100),
                    LoginForm(),
                    SizedBox(height: 15),
                    NavRow(),
                    SizedBox(height: 80),
                    LoginBtn(),
                    SizedBox(height: 10),
                    PolicyRow(),
                  ],
                ),
              ),
            ],
          ),
          // floatingActionButton: LangBtn(),
        ),
      ),
    );
  }
}
