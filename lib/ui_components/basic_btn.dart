import 'package:flutter/material.dart';

class BasicBtn extends StatelessWidget {
  final Function onTap;
  final String label;

  BasicBtn({this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;

    return FlatButton(
      child: Text(label, style: TextStyle(fontSize: 16)),
      onPressed: onTap,
      color: primaryColor,
      disabledColor: Colors.grey,
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 40),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.all(Radius.circular(25.0)),
      ),
    );
  }
}
