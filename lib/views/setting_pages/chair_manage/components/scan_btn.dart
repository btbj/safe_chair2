import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:provider/provider.dart';
import 'package:safe_chair2/providers/setting/chair_manage_info.dart';
import 'package:safe_chair2/providers/chair_control_info.dart';
// import 'package:safe_chair2/model/Chair.dart';
import 'package:safe_chair2/ui_components/basic_btn.dart';
import 'package:safe_chair2/l10n/app_localizations.dart';
import 'package:safe_chair2/model/l10nType.dart';
import 'package:safe_chair2/ui_components/toast.dart';
import '../scan_list.dart';

class ScanBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ChairManageInfo>(builder: (context, chairManageInfo, _) {
      return BasicBtn(
        label: AppLocalizations.of(context).uiText(UiType.add_chair_btn_text),
        onTap: () async {
          print('add chair');
          ChairControlInfo chairControlInfo = Provider.of<ChairControlInfo>(context);
          await chairControlInfo.refreshBleState();
          if (chairControlInfo.state != BluetoothState.on) {
            Toast.show(context, msg: '请打开蓝牙');
          } else {
            chairControlInfo.startScan();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ScanListPage(),
              ),
            ).then((_) {
              chairControlInfo.stopScan();
            });
          }
          // chairManageInfo.addChair(Chair(
          //   mac: 'fda50693-a4e2-4fb1-afcf-c6eb07647826',
          //   name: 'name',
          //   model: 'model',
          //   enName: 'enName',
          //   enModel: 'enModel',
          // ));
        },
      );
    });
  }
}
