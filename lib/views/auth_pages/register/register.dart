import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_chair2/providers/auth/register_info.dart';
import './components/title_row.dart';
import './components/register_form.dart';
import './components/register_btn.dart';
import './components/policy_row.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RegisterInfo>(
      builder: (context) => RegisterInfo(),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
          ),
          body: ListView(
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 100),
                    TitleRow(),
                    SizedBox(height: 15),
                    RegisterForm(),
                    SizedBox(height: 15),
                    RegisterBtn(),
                    SizedBox(height: 10),
                    PolicyRow(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}