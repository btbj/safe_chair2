import 'package:flutter/material.dart';
import './components/center_img.dart';
import './components/buckle_box.dart';
import './components/lfix_box.dart';
import './components/rfix_box.dart';
import './components/routation_box.dart';
import './components/pad_box.dart';
import './components/leg_box.dart';

class StateImgBox extends StatelessWidget {
  Widget _buildLeftList() {
    return Container(
      height: 220,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          BuckleBox(),
          LFixBox(),
          RFixBox(),
        ],
      ),
    );
  }

  Widget _buildRigheList() {
    return Container(
      height: 220,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          RoutationBox(),
          PadBox(),
          LegBox(),
        ],
      ),
    );
  }

  Widget _buildCenter() {
    return CenterImg();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildLeftList(),
          _buildCenter(),
          _buildRigheList(),
        ],
      ),
    );
  }
}
