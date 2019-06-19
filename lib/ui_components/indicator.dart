import 'package:flutter/material.dart';

class Indicator {
  static show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        Color primaryColor = Theme.of(context).primaryColor;
        return Container(
          child: Center(
            child: Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Container(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(primaryColor)
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static close(BuildContext context) {
    Navigator.pop(context);
  }
}
