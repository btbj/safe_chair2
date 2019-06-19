import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_chair2/providers/chair_control_info.dart';
import 'package:flutter_blue/flutter_blue.dart';

class ScanResultList extends StatelessWidget {
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
        return ListTile(
          leading: Icon(Icons.devices, color: primaryColor),
          title: Text(
            item.device.name.toString().isEmpty
                ? 'unknown'
                : item.device.name.toString(),
            style: TextStyle(color: primaryColor),
          ),
          trailing: Text(
            item.rssi.toString(),
            style: TextStyle(color: primaryColor),
          ),
        );
      });
      itemList.add(_buildLoadingBox(chairControlInfo));
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: itemList,
      );
    });
  }
}
