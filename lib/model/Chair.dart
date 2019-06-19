import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Chair {
  static final String listKey = 'ChairList';
  static final String currentKey = 'CurrentChair';

  final String mac;
  final String name;
  final String model;
  final String enName;
  final String enModel;

  Chair({
    this.mac,
    this.name,
    this.model,
    this.enName,
    this.enModel,
  });

  static bool checkEnglish() {
    final String currentLanguageCode = Intl.getCurrentLocale();
    final String shortLocaleCode = Intl.shortLocale(currentLanguageCode);
    // print('$currentLanguageCode $shortLocaleCode');
    return shortLocaleCode != 'zh';
  }

  String get nameText {
    bool isEN = checkEnglish();
    if (isEN) {
      return enName;
    } else {
      return name;
    }
  }

  String get modelText {
    bool isEN = checkEnglish();
    if (isEN) {
      return enModel;
    } else {
      return model;
    }
  }

  static String stringfy(Chair chair) {
    final Map<String, String> map = {
      'mac': chair.mac,
      'name': chair.name,
      'model': chair.model,
      'enName': chair.enName,
      'enModel': chair.enModel,
    };
    return jsonEncode(map);
  }

  static Chair parse(Map json) {
    try {
      return Chair(
        mac: json['mac'],
        name: json['name'],
        model: json['model'],
        enName: json['enName'],
        enModel: json['enModel'],
      );
    } catch (e) {
      print('parse chair error');
      return null;
    }
  }

  static Future<Map> getChairMap() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String listString = (prefs.getString(listKey) ?? '{}');
    final Map<String, dynamic> chairsMap = jsonDecode(listString);
    return chairsMap;
  }

  static Future saveChair(Chair chair) async {
    final savedChair = await getChairMap();
    if (savedChair.containsKey(chair.mac)) return;

    savedChair[chair.mac] = {
      'mac': chair.mac,
      'name': chair.name,
      'model': chair.model,
      'enName': chair.enName,
      'enModel': chair.enModel,
    };

    final prefs = await SharedPreferences.getInstance();
    final newDataString = jsonEncode(savedChair);
    await prefs.setString(listKey, newDataString);
    return;
  }

  static Future removeChair(Chair chair) async {
    final Map<String, dynamic> savedChair = await getChairMap();
    if (!savedChair.containsKey(chair.mac)) return;

    final Chair currentChair = await getCurrentChair();
    if (currentChair != null && currentChair.mac == chair.mac) {
      await setCurrentChair(null);
    }

    savedChair.remove(chair.mac);

    final prefs = await SharedPreferences.getInstance();
    final newDataString = jsonEncode(savedChair);
    await prefs.setString(listKey, newDataString);
    return;
  }

   static Future<Chair> getCurrentChair() async {
    final prefs = await SharedPreferences.getInstance();
    final chairString = prefs.getString(currentKey);
    if (chairString == null) return null;
    
    final Map<String, dynamic> chairMap = jsonDecode(chairString);
    return Chair.parse(chairMap);
  }

  static Future<Chair> setCurrentChair(Chair chair) async {
    // print('set chair ${chair.uuid} as current');
    final prefs = await SharedPreferences.getInstance();
    if (chair == null) {
      await prefs.setString(currentKey, null);
      return null;
    }
    final Chair currentChair = await getCurrentChair();
    if (currentChair != null && currentChair.mac == chair.mac) {
      await prefs.setString(currentKey, null);
      return null;
    } else {
      final String chairString = Chair.stringfy(chair);

      await prefs.setString(currentKey, chairString);
      return chair;
    }
  }
}
