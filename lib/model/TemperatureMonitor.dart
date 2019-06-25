import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class TemperatureMonitor {
  static final String _storedKey = 'storedTempMonitor';

  int highLimit;
  int lowLimit;
  bool highOn;
  bool lowOn;
  bool isF;

  TemperatureMonitor({
    this.highLimit = 30,
    this.lowLimit = 20,
    this.highOn = false,
    this.lowOn = false,
    this.isF = false,
  });

  String get hightLimitText {
    String tempValue = !isF ? '$highLimit' : '${(highLimit * 1.8).round() + 32}';
    String unit = !isF ? '℃': '℉';
    return tempValue + unit;
  }

  String get lowLimitText {
    String tempValue = !isF ? '$lowLimit' : '${(lowLimit * 1.8).round() + 32}';
    String unit = !isF ? '℃': '℉';
    return tempValue + unit;
  }

  static String stringfy(TemperatureMonitor monitor) {
    final Map<String, dynamic> map = {
      'highLimit': monitor.highLimit,
      'lowLimit': monitor.lowLimit,
      'highOn': monitor.highOn,
      'lowOn': monitor.lowOn,
      'isF': monitor.isF,
    };
    return jsonEncode(map);
  }

  static TemperatureMonitor parse(String tempString) {
    if (tempString == null) return null;
    try {
      final Map<String, dynamic> map = jsonDecode(tempString);
      return TemperatureMonitor(
        highLimit: map['highLimit'],
        lowLimit: map['lowLimit'],
        highOn: map['highOn'],
        lowOn: map['lowOn'],
        isF: map['isF'],
      );
    } catch (e) {
      print('parse temp error');
      return null;
    }
  }

  static Future saveMonitor(TemperatureMonitor monitor) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (monitor == null) {
      await prefs.remove(_storedKey);
      print('remove temp');
    } else {
      await prefs.setString(_storedKey, TemperatureMonitor.stringfy(monitor));
    }
    return;
  }

  static Future<TemperatureMonitor> getMonitor() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String monitorMapString = prefs.getString(_storedKey);
    var res = TemperatureMonitor.parse(monitorMapString);
    if (res == null) {
      res = TemperatureMonitor();
    }
    return res;
  }
}