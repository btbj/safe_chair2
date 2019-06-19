import 'package:flutter/material.dart';

class VersionBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          '版本号：0.1.0(1)',
          style: TextStyle(
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}
