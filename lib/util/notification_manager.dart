import 'package:flutter/material.dart';
import 'dart:async';
// import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:safe_chair2/l10n/app_localizations.dart';
import 'package:safe_chair2/model/l10nType.dart';
import 'package:safe_chair2/model/ChairState.dart';

class NotificationManager {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  bool noErr = true;

  Future<bool> init() async {
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    noErr = await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    return noErr;
  }

  Future show(BuildContext context, AlertType type) async {
    if (!noErr) return;
    String soundName = getSoundName(type);
    String message = getMessage(context, type);
    
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'ble chennel id', 'ble message chennel', 'show ble message',
        playSound: true, sound: soundName,
        importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails(presentSound: true, sound: '$soundName.caf');
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, '', message, platformChannelSpecifics,
        payload: 'item id 2');
    return;
  }

  Future schedule({int id, String message, Duration duration}) async {
    if (!noErr) return;
    final scheduleTime = new DateTime.now().add(duration);
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'ble channel id2', 'ble schedule chennel name', 'show scheduled ble message',
        importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(
        id, 'aaa', message, scheduleTime, platformChannelSpecifics,
        payload: 'item id 2');
    return;
  }

  Future cancel({int id}) async {
    await flutterLocalNotificationsPlugin.cancel(id);
    return;
  }

  String getMessage(BuildContext context, AlertType type) {
    String message = '';
    switch (type) {
      case AlertType.babayInCarWhenLeaving:
        message = AppLocalizations.of(context).messageText(MessageType.alert_baby_in_car);
        break;
      case AlertType.installErr:
        message = AppLocalizations.of(context).messageText(MessageType.alert_install_err);
        break;
      case AlertType.lowBattery:
        message = AppLocalizations.of(context).messageText(MessageType.alert_low_battery);
        break;
      case AlertType.highTemp:
        message = AppLocalizations.of(context).messageText(MessageType.alert_high_temp);
        break;
      case AlertType.lowTemp:
        message = AppLocalizations.of(context).messageText(MessageType.alert_low_temp);
        break;
      default:
        message = 'error';
    }
    return message;
  }
}

String getSoundName(AlertType type) {
    String sound;
    switch (type) {
      case AlertType.babayInCarWhenLeaving:
        sound = 'baby_in_car_alert';
        break;
      // case AlertType.enterRegion:
      //   sound = 'enter_region';
      //   break;
      // case AlertType.exitRegion:
      //   sound = 'exit_region';
      //   break;
      case AlertType.installErr:
        sound = 'install_err';
        break;
      case AlertType.lowBattery:
        sound = 'low_battery';
        break;
      case AlertType.highTemp:
        sound = 'temp_alert';
        break;
      case AlertType.lowTemp:
        sound = 'temp_alert';
        break;
      default:
    }
    return sound;
  }
