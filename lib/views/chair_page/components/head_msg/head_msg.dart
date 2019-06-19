import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_chair2/providers/chair_control_info.dart';
import 'package:safe_chair2/l10n/app_localizations.dart';
import 'package:safe_chair2/model/l10nType.dart';

class HeadMsg extends StatelessWidget {
  Widget _buildIcon(bool active, bool hasError) {
    if (!hasError) {
      return ClipOval(
        child: Container(
          alignment: Alignment.center,
          height: 15,
          width: 15,
          color: Colors.blue,
          child: Icon(Icons.favorite, color: Colors.white, size: 10),
        ),
      );
    } else {
      return ClipOval(
        child: Container(
          alignment: Alignment.center,
          height: 15,
          width: 15,
          color: active ? Colors.red : Colors.grey,
          child: Text(
            '!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      );
    }
  }

  Widget _buildText(String message, bool active, bool hasError) {
    Color textColor = Colors.white;
    if (hasError) textColor = Colors.red;
    if (!active) textColor = Colors.grey;
    return Text(
      message,
      style: TextStyle(color: textColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChairControlInfo>(builder: (context, chairControlInfo, _) {
      String errMsg;
      bool active = chairControlInfo.connected;
      bool hasError = true;

      if (!active) {
        errMsg = AppLocalizations.of(context)
            .messageText(MessageType.error_no_signal);
      } else {
        if (chairControlInfo.chairState.battery < 10)
          errMsg = AppLocalizations.of(context)
              .messageText(MessageType.error_low_battery);
        if (chairControlInfo.temperatureMonitor != null) {
          if (chairControlInfo.temperatureMonitor.highOn &&
              chairControlInfo.temperatureMonitor.highLimit <
                  chairControlInfo.chairState.temperature) {
            errMsg = AppLocalizations.of(context)
                .messageText(MessageType.error_high_temp);
          }
          if (chairControlInfo.temperatureMonitor.lowOn &&
              chairControlInfo.temperatureMonitor.lowLimit >
                  chairControlInfo.chairState.temperature) {
            errMsg = AppLocalizations.of(context)
                .messageText(MessageType.error_low_temp);
          }
        }
        if (!chairControlInfo.chairState.buckle)
          errMsg = AppLocalizations.of(context)
              .messageText(MessageType.error_buckle);
        if (!chairControlInfo.chairState.lfix)
          errMsg =
              AppLocalizations.of(context).messageText(MessageType.error_lfix);
        if (!chairControlInfo.chairState.rfix)
          errMsg =
              AppLocalizations.of(context).messageText(MessageType.error_rfix);
        if (!chairControlInfo.chairState.routation)
          errMsg = AppLocalizations.of(context)
              .messageText(MessageType.error_routation);
        if (!chairControlInfo.chairState.pad)
          errMsg =
              AppLocalizations.of(context).messageText(MessageType.error_pad);
        if (!chairControlInfo.chairState.leg)
          errMsg =
              AppLocalizations.of(context).messageText(MessageType.error_leg);
      }
      if (errMsg == null) {
        hasError = false;
        errMsg =
            AppLocalizations.of(context).messageText(MessageType.error_none);
      }

      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildIcon(active, hasError),
          SizedBox(width: 5),
          _buildText(errMsg, active, hasError),
        ],
      );
    });
  }
}
