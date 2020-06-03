import 'package:flutter/material.dart';
import './components/progress_arc.dart';
import './components/top_arc.dart';
import './components/temperature_text_box.dart';
import 'package:safe_chair2/providers/chair_control_info.dart';
import 'package:provider/provider.dart';

class TemperatureBox extends StatelessWidget {
  int getProgress(int temperature) {
    if (temperature == null) return null;
    final int low = 10;
    final int high = 40;
    int progress;
    if (temperature <= low) {
      progress = 0;
    } else if (temperature >= high) {
      progress = 100;
    } else {
      progress = (temperature - low) * 100 ~/ (high - low);
    }
    return progress;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChairControlInfo>(builder: (context, chairControlInfo, _) {
      final deviceHeight = MediaQuery.of(context).size.height;
      bool smallSize = false;
      if (deviceHeight < 700) smallSize = true;
      final int temperature = chairControlInfo.connected
          ? chairControlInfo.chairState.temperature
          : null;
      return Container(
        alignment: Alignment.center,
        height: smallSize ? 50 : 100,
        width: 250,
        decoration: BoxDecoration(
          // color: Colors.green,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: <Widget>[
            TopArc(),
            SizedBox(height: 10),
            ProgressArc(progress: getProgress(temperature)),
            SizedBox(height: 20),
            TemperatureTextBox(
                temperature,
                chairControlInfo.temperatureMonitor == null
                    ? false
                    : chairControlInfo.temperatureMonitor.isF),
          ],
        ),
      );
    });
  }
}
