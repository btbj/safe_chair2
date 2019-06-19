import 'package:flutter/material.dart';

class BasicFrame extends StatelessWidget {
  final Widget child;
  BasicFrame({this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: child,
    );
  }
}