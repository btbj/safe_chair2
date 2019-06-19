import 'package:flutter/material.dart';
import './components/battery_icon.dart';
import './components/battery_text.dart';
import 'package:provider/provider.dart';
import 'package:safe_chair2/providers/chair_control_info.dart';

class BatteryBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ChairControlInfo>(builder: (context, chairControlInfo, _) {
      final bool active = chairControlInfo.connected;
      final int progress = active ? chairControlInfo.chairState.battery : 0;
      return Container(
        alignment: Alignment.center,
        height: 80,
        width: 150,
        decoration: BoxDecoration(
          // color: Colors.grey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: <Widget>[
            BatteryIcon(active: active, progress: progress),
            SizedBox(height: 5),
            BatteryText(active: active, progress: progress),
          ],
        ),
      );
    });
  }
}
