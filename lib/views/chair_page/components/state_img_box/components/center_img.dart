import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_chair2/providers/chair_control_info.dart';

class CenterImg extends StatelessWidget {
  Widget _buildImageBox(ChairControlInfo _chairControlInfo) {
    final bool active = _chairControlInfo.connected;
    final Color blendColor = !active ? Colors.black : null;
    AssetImage image = AssetImage('lib/assets/img/chair_img/chair.png');
    if (active) {
      if (!_chairControlInfo.chairState.buckle) {
        image = AssetImage('lib/assets/img/chair_img/chair-err1.png');
      } else if (!_chairControlInfo.chairState.lfix) {
        image = AssetImage('lib/assets/img/chair_img/chair-err2.png');
      } else if (!_chairControlInfo.chairState.rfix) {
        image = AssetImage('lib/assets/img/chair_img/chair-err3.png');
      } else if (!_chairControlInfo.chairState.routation) {
        image = AssetImage('lib/assets/img/chair_img/chair-err4.png');
      } else if (!_chairControlInfo.chairState.pad) {
        image = AssetImage('lib/assets/img/chair_img/chair-err5.png');
      } else if (!_chairControlInfo.chairState.leg) {
        image = AssetImage('lib/assets/img/chair_img/chair-err6.png');
      }
    }

    return Image(
      height: 220,
      image: image,
      color: blendColor,
      colorBlendMode: BlendMode.color,
      fit: BoxFit.cover,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChairControlInfo>(builder: (context, _chairControlInfo, _) {
      return Container(
        alignment: Alignment.center,
        height: 250,
        width: 180,
        child: _buildImageBox(_chairControlInfo),
        // child: Column(
        //   mainAxisSize: MainAxisSize.min,
        //   children: <Widget>[
        //     _buildImageBox(model),
        //     Text(model.chairState.state, style: TextStyle(color: Colors.white)),
        //   ],
        // ),
      );
    });
  }
}
