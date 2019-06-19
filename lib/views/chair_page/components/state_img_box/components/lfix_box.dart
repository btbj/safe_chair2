import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_chair2/providers/chair_control_info.dart';

class LFixBox extends StatelessWidget {
  Color _getBlendColor(ChairControlInfo chairControlInfo) {
    if (chairControlInfo.connected) {
      if (!chairControlInfo.chairState.lfix) {
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
      return ClipOval(
        child: SizedBox(
          height: 40,
          width: 40,
          child: Image(
            image: AssetImage('lib/assets/img/state_icon/icon2.png'),
            color: _getBlendColor(_chairControlInfo),
            colorBlendMode: BlendMode.color,
            fit: BoxFit.cover,
          ),
        ),
      );
    });
  }
}
