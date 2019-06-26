import 'dart:async';
import 'package:safe_chair2/model/Chair.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_chair2/providers/chair_control_info.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:safe_chair2/ui_components/indicator.dart';
import 'package:safe_chair2/ui_components/toast.dart';

class ScanResultList extends StatefulWidget {
  @override
  _ScanResultListState createState() => _ScanResultListState();
}

class _ScanResultListState extends State<ScanResultList> {
  StreamSubscription connectingSub;
  Map nameMap;

  @override
  void initState() {
    this.initNameMap();
    super.initState();
  }

  void initNameMap() async {
    this.nameMap = await Chair.getNameMap();
    setState(() {});
  }

  Widget _buildLoadingBox(ChairControlInfo chairControlInfo) {
    return StreamBuilder<bool>(
      stream: chairControlInfo.scanStateSubject,
      builder: (context, scanStateSnapshot) {
        Color primaryColor = Theme.of(context).primaryColor;
        // if (!chairControlInfo.scanning) return Container();
        final bool scanning = scanStateSnapshot.data ?? false;
        if (!scanning) return Container();
        return Container(
          padding: EdgeInsets.all(15),
          child: Container(
            child: SizedBox(
              height: 25,
              width: 25,
              child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(primaryColor)),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    return Consumer<ChairControlInfo>(builder: (context, chairControlInfo, _) {
      final List<ScanResult> list =
          chairControlInfo.scanResults.values.toList();

      List<Widget> itemList = List<Widget>.generate(list.length, (index) {
        final item = list[index];
        String nameText = 'unknown';
        if (item.device.name.isNotEmpty) nameText = item.device.name;
        if (nameMap != null && nameMap.containsKey(item.device.id.toString()))
          nameText = nameMap[item.device.id.toString()];

        return ListTile(
          leading: Icon(Icons.devices, color: primaryColor),
          title: Text(
            nameText,
            style: TextStyle(color: primaryColor),
          ),
          subtitle: Text(
            item.device.id.toString(),
            style: TextStyle(color: Colors.white54, fontSize: 10),
          ),
          trailing: Text(
            item.rssi.toString(),
            style: TextStyle(color: primaryColor),
          ),
          onTap: () {
            Indicator.show(context);
            chairControlInfo.connect(item.device);
            connectingSub =
                chairControlInfo.connectingStateSubject.listen((connecting) {
              if (!connecting) {
                Indicator.close(context);
                connectingSub.cancel();
                if (chairControlInfo.targetChar == null) {
                  Toast.show(context, msg: '连接失败');
                } else {
                  Toast.show(context, msg: '连接成功');
                  Navigator.pop(context);
                }
              }
            });
          },
        );
      });
      itemList.add(_buildLoadingBox(chairControlInfo));
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: itemList,
      );
    });
  }

  @override
  void dispose() {
    this.connectingSub?.cancel();
    super.dispose();
  }
}
