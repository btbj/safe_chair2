import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_chair2/providers/chair_control_info.dart';
import 'package:safe_chair2/model/TemperatureMonitor.dart';

class UnitSwitch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ChairControlInfo>(builder: (context, chairControlInfo, _) {
      final Color activeColor = Theme.of(context).primaryColor;
      final Color inactiveColor = Colors.grey[700];
      TemperatureMonitor tempMonitor = chairControlInfo.temperatureMonitor;

      return GestureDetector(
        onTap: () {
          tempMonitor.isF = !tempMonitor.isF;
          chairControlInfo.temperatureMonitor = tempMonitor;
        },
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  color: chairControlInfo.temperatureMonitor.isF ? inactiveColor : activeColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
                child: Center(
                  child: Text(
                    '℃',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
              Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  color: !chairControlInfo.temperatureMonitor.isF ? inactiveColor : activeColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Center(
                  child: Text(
                    '℉',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
