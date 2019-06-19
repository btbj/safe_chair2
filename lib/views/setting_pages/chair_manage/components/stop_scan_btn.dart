import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_chair2/providers/chair_control_info.dart';

class StopScanBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ChairControlInfo>(builder: (context, _chairControlInfo, _) {
      return StreamBuilder<bool>(
        stream: _chairControlInfo.scanStateSubject,
        builder: (context, scanStateSnapshot) {
          Color primaryColor = Theme.of(context).primaryColor;
          // bool scanning = _chairControlInfo.scanning;
          bool scanning = scanStateSnapshot.data ?? false;
          return FlatButton(
            child: Icon(
              scanning ? Icons.cancel : Icons.refresh,
              color: primaryColor,
            ),
            onPressed: () {
              if (scanning) {
                _chairControlInfo.stopScan();
              } else {
                _chairControlInfo.startScan();
              }
            },
          );
        },
      );
    });
  }
}
