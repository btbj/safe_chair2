import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_chair2/providers/setting/chair_instruction_info.dart';
import 'package:safe_chair2/l10n/app_localizations.dart';
import 'package:safe_chair2/model/l10nType.dart';

class InfoBox extends StatelessWidget {
  Widget _buildLine(BuildContext context, UiType type, String info) {
    final TextStyle textStyle = TextStyle(color: Colors.grey);
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(AppLocalizations.of(context).uiText(type), style: textStyle),
          Text(info, style: textStyle),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChairInstructionInfo>(builder: (context, chairInstructionInfo, _) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _buildLine(context, UiType.chair_name_label, chairInstructionInfo.chairName),
          _buildLine(context, UiType.chair_model_label, chairInstructionInfo.chairModel),
          _buildLine(context, UiType.chair_range_label, chairInstructionInfo.chairRange),
          _buildLine(context, UiType.chair_install_label, chairInstructionInfo.chairInstallType),
        ],
      );
    }
      
    );
  }
}