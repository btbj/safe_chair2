import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Chair {
  static final String listKey = 'ChairList';
  static final String currentKey = 'CurrentChair';
  static final String nameMapKey = 'chairNameMap';

  final String uuid;
  final String mac;
  final String name;
  final String model;
  final String enName;
  final String enModel;

  Chair({
    @required this.uuid,
    @required this.mac,
    @required this.name,
    @required this.model,
    @required this.enName,
    @required this.enModel,
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

  DeviceIdentifier get id {
    return DeviceIdentifier(this.uuid);
  }

  static String stringfy(Chair chair) {
    final Map<String, String> map = {
      'uuid': chair.uuid,
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
        uuid: json['uuid'],
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
      'uuid': chair.uuid,
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

  static Future<Map> getNameMap() async {
    final prefs = await SharedPreferences.getInstance();
    String savedString = prefs.getString(nameMapKey) ?? '{}';
    return jsonDecode(savedString);
  }

  Future saveName(String name) async {
    final nameMap = await Chair.getNameMap();
    if (name == null || name.isEmpty) {
      nameMap.remove(this.uuid);
    } else {
      nameMap[this.uuid] = name;
    }

    final prefs = await SharedPreferences.getInstance();
    final newDataString = jsonEncode(nameMap);
    await prefs.setString(nameMapKey, newDataString);
    return;
  }

  static String checkMac(String deviceName) {
    if (deviceName == 'BLE003U') return deviceName;
    RegExp namePattern = RegExp(r"^WD[\d]{3}([\d\w]{12})$");
    RegExp macPattern = RegExp(r"([\d\w]{12})$");
    if (namePattern.hasMatch(deviceName)) {
      return macPattern.stringMatch(deviceName);
    } else {
      return null;
    }
  }
}
