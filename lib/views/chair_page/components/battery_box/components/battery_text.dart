import 'package:flutter/material.dart';
import 'package:safe_chair2/l10n/app_localizations.dart';
import 'package:safe_chair2/model/l10nType.dart';

class BatteryText extends StatelessWidget {
  final int progress;
  final bool active;
  BatteryText({this.active, this.progress});

  @override
  Widget build(BuildContext context) {
    Color getTextColor() {
      if (!active) return Colors.grey;
      if (progress <= 10)
        return Colors.red;
      else if (progress <= 20)
        return Colors.orange;
      else
        return Colors.white;
    }

    TextStyle textStyle = TextStyle(fontSize: 12, color: getTextColor());

    String progressText = active ? '$progress' : '??';

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          AppLocalizations.of(context).uiText(UiType.battery_level),
          style: textStyle,
        ),
        Text('$progressText' + '%', style: textStyle),
      ],
    );
  }
}
