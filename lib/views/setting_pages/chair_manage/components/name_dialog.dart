import 'package:flutter/material.dart';
import 'package:safe_chair2/l10n/app_localizations.dart';
import 'package:safe_chair2/model/l10nType.dart';

class NameDialog extends StatefulWidget {
  final String currentName;
  NameDialog(this.currentName);

  @override
  _NameDialogState createState() => _NameDialogState();
}

class _NameDialogState extends State<NameDialog> {
  TextEditingController nameCtr;
  @override
  void initState() {
    nameCtr = TextEditingController(text: this.widget.currentName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      title: Text(AppLocalizations.of(context).uiText(UiType.edit_device_name_title)),
      children: <Widget>[
        SizedBox(height: 15),
        TextField(
          controller: nameCtr,
          cursorColor: Theme.of(context).primaryColor,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(15.0),
            ),
            contentPadding: EdgeInsets.all(15),
          ),
        ),
        SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              color: Colors.grey[300],
              child: Text(AppLocalizations.of(context).uiText(UiType.cancel_btn)),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(width: 15),
            FlatButton(
              color: Theme.of(context).primaryColor,
              child: Text(AppLocalizations.of(context).uiText(UiType.confirm_btn), style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.pop(context, nameCtr.text);
              },
            ),
          ],
        ),
      ],
    );
  }
}
