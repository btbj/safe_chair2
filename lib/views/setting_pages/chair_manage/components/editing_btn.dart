import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_chair2/providers/setting/chair_manage_info.dart';

class EditingBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ChairManageInfo>(builder: (context, chairManageInfo, _) {
      bool editing = chairManageInfo.editing;
      return FlatButton(
        child: Text(
          editing ? '完成' : '编辑',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        onPressed: () {
          chairManageInfo.editing = !editing;
        },
      );
    });
  }
}
