import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:safe_chair2/providers/app_info.dart';

class LangBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppInfo>(builder: (context, info, _) {
      final currentLocal = Intl.getCurrentLocale();
      final textstyle = TextStyle(color: Colors.white30);
      final textstyleSelected = TextStyle(color: Theme.of(context).primaryColor);

      return Container(
        margin: EdgeInsets.only(bottom: 30),
        child: FlatButton(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('中', style: currentLocal != 'en_US' ? textstyleSelected : textstyle),
              Text('|', style: textstyle,),
              Text('EN', style: currentLocal == 'en_US' ? textstyleSelected : textstyle),
            ],
          ),
          onPressed: () {
            if (currentLocal == 'en_US') {
              info.locale = Locale('zh');
            } else {
              info.locale = Locale('en');
            }
          },
        ),
      );
    });
  }
}