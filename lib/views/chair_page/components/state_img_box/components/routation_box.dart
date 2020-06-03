import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_chair2/providers/chair_control_info.dart';

class RoutationBox extends StatelessWidget {
  Color _getBlendColor(ChairControlInfo chairControlInfo) {
    if (chairControlInfo.connected) {
      if (!chairControlInfo.chairState.routation) {
        return Colors.red;
      } else {
        return Colors.blue;
      }
    } else {
      return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChairControlInfo>(builder: (context, _chairControlInfo, _) {
      bool smallSize = MediaQuery.of(context).size.height < 700;
      return ClipOval(
        child: SizedBox(
          height: smallSize ? 20 : 40,
          width: smallSize ? 20 : 40,
          child: Image(
            image: AssetImage('lib/assets/img/state_icon/icon4.png'),
            color: _getBlendColor(_chairControlInfo),
            colorBlendMode: BlendMode.color,
            fit: BoxFit.contain,
          ),
        ),
      );
    });
  }
}
