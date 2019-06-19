import 'package:flutter/material.dart';

class MenuNav extends StatelessWidget {
  final String label;
  final String endLabel;
  final Function onTap;

  MenuNav({this.label, this.onTap, this.endLabel = ''});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;

    return GestureDetector(
      child: ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(label, style: TextStyle(color: primaryColor)),
            Text(endLabel, style: TextStyle(color: primaryColor)),
          ],
        ),
        trailing: Icon(Icons.keyboard_arrow_right, color: primaryColor,),
      ),
      onTap: onTap,
    );
  }
}