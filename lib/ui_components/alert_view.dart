import 'package:flutter/material.dart';
import 'dart:async';
import 'package:safe_chair2/model/ChairState.dart';
import 'package:safe_chair2/l10n/app_localizations.dart';
import 'package:safe_chair2/model/l10nType.dart';
// import 'package:safe_chair2/util/notification_manager.dart';

class AlertView {
  static Future show(BuildContext context, AlertType type) {
    // NotificationManager notificationManager = NotificationManager();
    // notificationManager.init();
    // notificationManager.show(context, type);
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialogBox(type),
    );
  }
}

class AlertDialogBox extends StatelessWidget {
  final AlertType type;
  AlertDialogBox(this.type);

  String _getMessage(BuildContext context) {
    String msg = '';
    switch (type) {
      case AlertType.babyInCarWhenLeaving:
        msg = AppLocalizations.of(context)
            .messageText(MessageType.alert_baby_in_car);
        break;
      case AlertType.installErr:
        msg = AppLocalizations.of(context)
            .messageText(MessageType.alert_install_err);
        break;
      case AlertType.lowBattery:
        msg = AppLocalizations.of(context)
            .messageText(MessageType.alert_low_battery);
        break;
      case AlertType.highTemp:
        msg = AppLocalizations.of(context)
            .messageText(MessageType.alert_high_temp);
        break;
      case AlertType.lowTemp:
        msg = AppLocalizations.of(context)
            .messageText(MessageType.alert_low_temp);
        break;
    }
    return msg;
  }

  Widget _buildShadow({double height, double width, Offset offset}) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(color: Colors.transparent, boxShadow: [
        BoxShadow(
          color: Colors.red,
          blurRadius: 30,
          spreadRadius: 10,
          offset: offset,
        ),
      ]),
    );
  }

  Widget _buildInfoBox(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 20,
      child: SimpleDialog(
        contentPadding: EdgeInsets.symmetric(horizontal: 25),
        title: Text(AppLocalizations.of(context).uiText(UiType.alert_title)),
        children: <Widget>[
          Container(
            width: 250,
            margin: EdgeInsets.symmetric(vertical: 15),
            child: Text(_getMessage(context), softWrap: true),
          ),
          RaisedButton(
            child: Text(
              AppLocalizations.of(context)
                  .uiText(UiType.alert_confirm_btn_text),
            ),
            onPressed: () {
              print('alert close');
              Navigator.pop(context);
            },
          ),
          SizedBox(height: 15),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Column(
        children: <Widget>[
          _buildShadow(height: 1, offset: Offset(0, -20)),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _buildShadow(width: 1, offset: Offset(-3, 0)),
                _buildInfoBox(context),
                _buildShadow(width: 1, offset: Offset(3, 0)),
              ],
            ),
          ),
          _buildShadow(height: 1, offset: Offset(0, 20)),
        ],
      ),
    );
  }
}
