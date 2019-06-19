import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_chair2/providers/auth/resetpwd_info.dart';
import './components/title_row.dart';
import './components/resetpwd_form.dart';
import './components/resetpwd_btn.dart';

class ResetpwdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ResetpwdInfo>(
      builder: (context) => ResetpwdInfo(),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          backgroundColor: Colors.black87,
          appBar: AppBar(
            backgroundColor: Colors.black87,
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
                    ResetpwdForm(),
                    SizedBox(height: 15),
                    ResetpwdBtn(),
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