import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_chair2/providers/chair_control_info.dart';
import 'package:safe_chair2/model/Chair.dart';
import 'package:safe_chair2/ui_components/indicator.dart';
// import 'package:safe_chair2/ui_components/indicator.dart';
import 'package:safe_chair2/l10n/app_localizations.dart';
import 'package:safe_chair2/model/l10nType.dart';

class ListConnectBtn extends StatefulWidget {
  final Chair chair;
  ListConnectBtn(this.chair);

  @override
  _ListConnectBtnState createState() => _ListConnectBtnState();
}

class _ListConnectBtnState extends State<ListConnectBtn> {
  StreamSubscription scanConnectSub;

  @override
  Widget build(BuildContext context) {
    return Consumer<ChairControlInfo>(builder: (context, chairControlInfo, _) {
      // bool connected = chair.mac == chairControlInfo.connectedDevice.name;
      bool connected = false;
      if (chairControlInfo.connectedDevice != null) {
        connected = widget.chair.mac == chairControlInfo.connectedDevice.name;
      }
      Color primaryColor = Theme.of(context).primaryColor;

      return Container(
        height: 30,
        width: 70,
        child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 0),
          child: Text(
            connected
                ? AppLocalizations.of(context).uiText(UiType.disconnect_btn)
                : AppLocalizations.of(context).uiText(UiType.connect_btn),
            style: TextStyle(color: primaryColor, fontSize: 12),
          ),
          onPressed: () async {
            // print(widget.chair.uuid);
            if (connected) {
              chairControlInfo.clearChairState();
              await chairControlInfo.disconnect();
            } else {
              Indicator.show(context);
              chairControlInfo.scanToConnect(widget.chair);
              scanConnectSub =
                  chairControlInfo.scanConnectStateSubject.listen((scanning) {
                print(scanning);
                if (!scanning) {
                  Indicator.close(context);
                  scanConnectSub?.cancel();
                }
              });
            }
          },
          shape: StadiumBorder(
            side: BorderSide(color: primaryColor),
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    this.scanConnectSub?.cancel();
    super.dispose();
  }
}
