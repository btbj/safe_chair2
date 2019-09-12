import 'package:flutter/material.dart';
import 'package:safe_chair2/ui_components/head_bar.dart';
import 'package:safe_chair2/l10n/app_localizations.dart';
import 'package:safe_chair2/model/l10nType.dart';
import './components/head_msg/head_msg.dart';
import './components/state_img_box/state_img_box.dart';
import './components/ble_state_bar/ble_state_bar.dart';
import './components/temperature_box/temperature_box.dart';
import './components/battery_box/battery_box.dart';

class ChairPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            HeadBar(
              title: AppLocalizations.of(context).uiText(UiType.chair_title),
            ),
            HeadMsg(),
            Expanded(
              flex: 5,
              child: StateImgBox(),
            ),
            Expanded(flex: 3, child: BleStateBar()),
            Expanded(flex: 2, child: TemperatureBox()),
            Expanded(flex: 2, child: BatteryBox()),
            // Expanded(
            //   child: ListView(
            //     children: <Widget>[
            //       Container(
            //         height: MediaQuery.of(context).size.height - 180,
            //         child: Column(
            //           // mainAxisSize: MainAxisSize.max,
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: <Widget>[
            //             HeadMsg(),
            //             StateImgBox(),
            //             BleStateBar(),
            //             TemperatureBox(),
            //             BatteryBox(),
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
