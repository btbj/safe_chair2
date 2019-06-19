import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_chair2/providers/setting/chair_manage_info.dart';
import 'package:safe_chair2/model/Chair.dart';
import 'package:safe_chair2/providers/chair_control_info.dart';
// import 'package:safe_chair2/providers/app_info.dart';
// import 'package:safe_chair2/l10n/app_localizations.dart';
// import 'package:safe_chair2/model/l10nType.dart';

class ChairList extends StatelessWidget {
  Widget _buildChairItem(Chair chair) {
    return Consumer<ChairManageInfo>(builder: (context, chairManageInfo, _) {
      Color primaryColor = Theme.of(context).primaryColor;
      ChairControlInfo chairControlInfo =
          Provider.of<ChairControlInfo>(context);
      bool selected = chairControlInfo.targetChair != null &&
          chairControlInfo.targetChair.mac == chair.mac;
      return ListTile(
        leading: GestureDetector(
          child: selected
              ? Icon(
                  Icons.check_box,
                  color: primaryColor,
                )
              : Icon(
                  Icons.check_box_outline_blank,
                  color: primaryColor,
                ),
          onTap: () {
            print('select chair');
            if (selected) {
              chairControlInfo.targetChair = null;
            } else {
              chairControlInfo.targetChair = chair;
            }
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(chair.modelText, style: TextStyle(color: primaryColor)),
            Text(chair.nameText, style: TextStyle(color: primaryColor)),
          ],
        ),
        trailing: GestureDetector(
          child: Icon(
            Icons.delete,
            color: Colors.red,
          ),
          onTap: () {
            print('delete chair');
            chairManageInfo.deleteChair(chair);
            chairControlInfo.targetChair = null;
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChairManageInfo>(builder: (context, chairManageInfo, _) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: List<Widget>.generate(
          chairManageInfo.chairList.length,
          (index) {
            return _buildChairItem(chairManageInfo.chairList[index]);
          },
        ),
      );
    });
  }
}
