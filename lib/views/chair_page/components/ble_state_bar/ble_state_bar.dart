import 'package:flutter/material.dart';
import './components/ble_state_box.dart';
import './components/notification_state_box.dart';
import './components/protect_box.dart';

class BleStateBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25),
      alignment: Alignment.center,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          BleStateBox(),
          ProtectBox(),
          NotificationStateBox(),
        ],
      ),
    );
  }
}