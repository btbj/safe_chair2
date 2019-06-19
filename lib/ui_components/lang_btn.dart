import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:safe_chair2/providers/app_info.dart';

class LangBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppInfo>(builder: (context, info, _) {
      return FloatingActionButton(
        child: Icon(Icons.language),
        onPressed: () {
          final currentLocal = Intl.getCurrentLocale();
          print(currentLocal);
          if (currentLocal == 'en_US') {
            info.locale = Locale('zh');
          } else {
            info.locale = Locale('en');
          }
        },
      );
    });
  }
}