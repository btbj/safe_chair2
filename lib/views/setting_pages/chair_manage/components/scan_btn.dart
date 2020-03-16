import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:provider/provider.dart';
import 'package:safe_chair2/providers/app_info.dart';
import 'package:safe_chair2/providers/setting/chair_manage_info.dart';
import 'package:safe_chair2/providers/chair_control_info.dart';
import 'package:safe_chair2/model/Chair.dart';
import 'package:safe_chair2/ui_components/basic_btn.dart';
import 'package:safe_chair2/l10n/app_localizations.dart';
import 'package:safe_chair2/model/l10nType.dart';
import 'package:safe_chair2/ui_components/toast.dart';
import '../scan_list.dart';

class ScanBtn extends StatelessWidget {
  void checkConnectedDevice(
      BuildContext context, ChairManageInfo chairManageInfo) async {
    AppInfo appInfo = Provider.of<AppInfo>(context);
    ChairControlInfo chairControlInfo = Provider.of<ChairControlInfo>(context);
    BluetoothDevice connectedDevice = chairControlInfo.connectedDevice;
    if (connectedDevice == null) return;
    String mac = Chair.checkMac(connectedDevice.name.toString());
    final res = await chairManageInfo.getChairInfoByMac(
      token: appInfo.user.token,
      mac: mac,
    );
    Toast.show(context, msg: res['message']);
    if (res['success']) {
      chairManageInfo.addChair(Chair(
        uuid: connectedDevice.id.toString(),
        mac: mac,
        name: res['data']['product']['name'],
        model: res['data']['product']['model'],
        enName: res['data']['product']['en_name'],
        enModel: res['data']['product']['en_model'],
      ));
    } else {
      chairControlInfo.disconnect();
      chairControlInfo.clearChairState();
      chairControlInfo.cancelAllAlertSubject.add(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChairManageInfo>(builder: (context, chairManageInfo, _) {
      return BasicBtn(
        label: AppLocalizations.of(context).uiText(UiType.add_chair_btn_text),
        onTap: () async {
          print('add chair');
          ChairControlInfo chairControlInfo =
              Provider.of<ChairControlInfo>(context);
          // await chairControlInfo.refreshBleState();
          // if (chairControlInfo.state != BluetoothState.on) {
          //   Toast.show(context, msg: '请打开蓝牙');
          // } else {
          //   chairControlInfo.startScan();
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => ScanListPage(),
          //     ),
          //   ).then((_) {
          //     chairControlInfo.stopScan();
          //     this.checkConnectedDevice(context, chairManageInfo);
          //   });
          // }
          if (await FlutterBlue.instance.isOn) {
            chairControlInfo.startScan();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ScanListPage(),
              ),
            ).then((_) {
              FlutterBlue.instance.stopScan();
              this.checkConnectedDevice(context, chairManageInfo);
            });
          } else {
            Toast.show(context, msg: 'Please Turn On Bluetooth');
          }
        },
      );
    });
  }
}
