import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_chair2/providers/chair_control_info.dart';
import 'package:safe_chair2/l10n/app_localizations.dart';
import 'package:safe_chair2/model/l10nType.dart';
import './temperature_switch.dart';
import './slider_dialog.dart';

class HighTempLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ChairControlInfo>(builder: (context, chairControlInfo, _) {
      String listTitle = AppLocalizations.of(context)
          .uiText(UiType.high_temperature_alert_label);
      Color primaryColor = Theme.of(context).primaryColor;
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: 170,
              child: Text(listTitle,
                  style: TextStyle(color: primaryColor), softWrap: true),
            ),
            FlatButton(
              child: Text(
                chairControlInfo.temperatureMonitor.hightLimitText,
                style: TextStyle(color: primaryColor),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return SliderDialog(
                      isHigh: true,
                      initValue: chairControlInfo.temperatureMonitor.highLimit,
                    );
                  },
                );
              },
            ),
            TemperatureSwitch(isHigh: true),
          ],
        ),
      );
    });
  }
}
