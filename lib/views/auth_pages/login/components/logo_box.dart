import 'package:flutter/material.dart';

class LogoBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      child: Image.asset(
        'lib/assets/img/logo/logo.png',
        fit: BoxFit.contain,
      ),
    );
  }
}
