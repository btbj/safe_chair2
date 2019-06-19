import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_chair2/providers/chair_control_info.dart';
import 'package:safe_chair2/model/TemperatureMonitor.dart';

class TemperatureSwitch extends StatelessWidget {
  final bool isHigh;
  TemperatureSwitch({this.isHigh});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return Consumer<ChairControlInfo>(builder: (context, chairControlInfo, _) {
      TemperatureMonitor tempMonitor = chairControlInfo.temperatureMonitor;
      return Switch(
        value: isHigh ? tempMonitor.highOn : tempMonitor.lowOn,
        onChanged: (value) async {
          if (isHigh) {
            tempMonitor.highOn = value;
          } else {
            tempMonitor.lowOn = value;
          }
          chairControlInfo.temperatureMonitor = tempMonitor;
        },
        activeColor: primaryColor,
        inactiveTrackColor: Colors.grey[700],
        inactiveThumbColor: Colors.grey[400],
      );
    });
  }
}
