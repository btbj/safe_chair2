import 'dart:async';
import 'package:flutter/material.dart';

class BasicDialog {
  static Future pop(BuildContext context, {@required String message, @required String title}) {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          title: Text(title),
          children: <Widget>[
            SizedBox(height: 15),
            Text(message),
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  color: Colors.grey[300],
                  child: Text('取消'),
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                ),
                SizedBox(width: 15),
                FlatButton(
                  color: Theme.of(context).primaryColor,
                  child: Text('确定', style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                ),
              ],
            )
          ],
        );
      },
    );
  }
}