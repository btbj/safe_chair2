import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_chair2/providers/chair_control_info.dart';
import 'package:safe_chair2/model/TemperatureMonitor.dart';
import 'package:safe_chair2/l10n/app_localizations.dart';
import 'package:safe_chair2/model/l10nType.dart';

class SliderDialog extends StatefulWidget {
  final bool isHigh;
  final int initValue;
  SliderDialog({@required this.isHigh, @required this.initValue});

  @override
  _SliderDialogState createState() => _SliderDialogState();
}

class _SliderDialogState extends State<SliderDialog> {
  double temp;
  @override
  void initState() {
    temp = widget.initValue.toDouble();
    super.initState();
  }

  String _generateTempString(int temp, bool isF) {
    if (!isF)
      return '$temp' + '℃';
    else {
      final int fTemp = (temp * 1.8).round() + 32;
      return '$fTemp' + '℉';
    }
  }

  Widget _buildInfoText() {
    return Consumer<ChairControlInfo>(builder: (context, chairControlInfo, _) {
      String info =
          AppLocalizations.of(context).uiText(UiType.current_temp_prefix) +
              _generateTempString(
                  temp.toInt(), chairControlInfo.temperatureMonitor.isF);
      return Text(info);
    });
  }

  Widget _buildSlider() {
    return Consumer<ChairControlInfo>(builder: (context, chairControlInfo, _) {
      final int intMax =
          widget.isHigh ? 50 : chairControlInfo.temperatureMonitor.highLimit;
      final int intMin =
          widget.isHigh ? chairControlInfo.temperatureMonitor.lowLimit : 0;
      return Slider(
        value: temp,
        max: intMax.toDouble(),
        min: intMin.toDouble(),
        onChanged: (value) {
          setState(() {
            temp = value;
          });
        },
      );
    });
  }

  Widget _buildConfirmBtn() {
    return Consumer<ChairControlInfo>(builder: (context, chairControlInfo, _) {
      return RaisedButton(
        child: Text(
          AppLocalizations.of(context).uiText(UiType.confirm_btn_text),
        ),
        onPressed: () async {
          print('confirm');
          TemperatureMonitor newMonitor = chairControlInfo.temperatureMonitor;
          if (widget.isHigh) {
            newMonitor.highLimit = temp.toInt();
          } else {
            newMonitor.lowLimit = temp.toInt();
          }
          chairControlInfo.temperatureMonitor = newMonitor;
          // await _model.setTemperatureLimit(TemperatureLimit(
          //   high: widget.isHigh ? temp.toInt() : _model.temperatureLimit.high,
          //   low: !widget.isHigh ? temp.toInt() : _model.temperatureLimit.low,
          //   highSwitch: _model.temperatureLimit.highSwitch,
          //   lowSwitch: _model.temperatureLimit.lowSwitch,
          //   isF: _model.temperatureLimit.isF,
          // ));
          Navigator.pop(context);
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final String title = widget.isHigh
        ? AppLocalizations.of(context)
            .uiText(UiType.high_temperature_setting_dialog_title)
        : AppLocalizations.of(context)
            .uiText(UiType.low_temperature_setting_dialog_title);

    return SimpleDialog(
      title: Text(title),
      contentPadding: EdgeInsets.all(15),
      children: <Widget>[
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _buildInfoText(),
            _buildSlider(),
          ],
        ),
        _buildConfirmBtn(),
      ],
    );
  }
}
