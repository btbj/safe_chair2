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
    noErr = await flutterLocalNotificationsPlugin
        .initialize(initializationSettings);
    return noErr;
  }

  Future show(BuildContext context, AlertType type) async {
    if (!noErr) return;
    String soundName = getSoundName(type);
    String message = getMessage(context, type);
    ChannelInfo channelInfo = getChannelInfo(type);

    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        channelInfo.channelId,
        channelInfo.channelName,
        channelInfo.channelDescription,
        playSound: true,
        sound: soundName,
        importance: Importance.Max,
        priority: Priority.High);
    var iOSPlatformChannelSpecifics =
        new IOSNotificationDetails(presentSound: true, sound: '$soundName.caf');
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin
        .show(0, '', message, platformChannelSpecifics, payload: 'item id 2');
    return;
  }

  // Future test(BuildContext context, Duration d) async {
  //   String soundName = getSoundName(AlertType.babyInCarWhenLeaving);
  //   ChannelInfo channelInfo = getChannelInfo(AlertType.babyInCarWhenLeaving);
  //   final scheduleTime = new DateTime.now().add(d);
  //   var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
  //       channelInfo.channelId,
  //       channelInfo.channelName,
  //       channelInfo.channelDescription,
  //       playSound: true,
  //       sound: soundName,
  //       importance: Importance.Max,
  //       priority: Priority.High);
  //   var iOSPlatformChannelSpecifics =
  //       new IOSNotificationDetails(presentSound: true, sound: '$soundName.caf');
  //   var platformChannelSpecifics = new NotificationDetails(
  //       androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  //   await flutterLocalNotificationsPlugin.schedule(
  //       999, 'weldon', 'test info', scheduleTime, platformChannelSpecifics,
  //       payload: 'item id 2');
  //   return;
  // }

  Future schedule(BuildContext context, AlertType type) async {
    if (!noErr) return;
    int id = 1;
    String message = getMessage(context, type);
    String soundName = getSoundName(type);
    Duration duration = Duration(seconds: 1);
    if (type == AlertType.babyInCarWhenLeaving) {
      id = 2;
      duration = Duration(seconds: 120);
    } else if (type == AlertType.installErr) {
      id = 3;
      duration = Duration(seconds: 10);
    }
    ChannelInfo channelInfo = getChannelInfo(type);

    String title = AppLocalizations.of(context).uiText(UiType.app_title);
    print('----------------------');
    print(duration.inSeconds);
    final scheduleTime = new DateTime.now().add(duration);
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        channelInfo.channelId,
        channelInfo.channelName,
        channelInfo.channelDescription,
        playSound: true,
        sound: soundName,
        importance: Importance.Max,
        priority: Priority.High);
    var iOSPlatformChannelSpecifics =
        new IOSNotificationDetails(presentSound: true, sound: '$soundName.caf');
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(
        id, title, message, scheduleTime, platformChannelSpecifics,
        payload: 'item id 2');
    return;
  }

  Future cancel(AlertType type) async {
    int id = 1;
    if (type == AlertType.babyInCarWhenLeaving) {
      id = 2;
    } else if (type == AlertType.installErr) {
      id = 3;
    }
    await flutterLocalNotificationsPlugin.cancel(id);
    return;
  }

  Future cancelAll() async {
    await flutterLocalNotificationsPlugin.cancelAll();
    return;
  }

  String getMessage(BuildContext context, AlertType type) {
    String message = '';
    switch (type) {
      case AlertType.babyInCarWhenLeaving:
        message = AppLocalizations.of(context)
            .messageText(MessageType.alert_baby_in_car);
        break;
      case AlertType.installErr:
        message = AppLocalizations.of(context)
            .messageText(MessageType.alert_install_err);
        break;
      case AlertType.lowBattery:
        message = AppLocalizations.of(context)
            .messageText(MessageType.alert_low_battery);
        break;
      case AlertType.highTemp:
        message = AppLocalizations.of(context)
            .messageText(MessageType.alert_high_temp);
        break;
      case AlertType.lowTemp:
        message = AppLocalizations.of(context)
            .messageText(MessageType.alert_low_temp);
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
    case AlertType.babyInCarWhenLeaving:
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

class ChannelInfo {
  String channelId;
  String channelName;
  String channelDescription;
  ChannelInfo(this.channelId, this.channelName, this.channelDescription);
}

ChannelInfo getChannelInfo(AlertType type) {
  switch (type) {
    case AlertType.babyInCarWhenLeaving:
      return ChannelInfo('sId1', 'baby_in_car', 'baby in car when leaving');
      break;
    case AlertType.installErr:
      return ChannelInfo('sId2', 'install_err', 'chair setup error');
      break;
    case AlertType.highTemp:
      return ChannelInfo('sId3', 'temp_alert', 'temperature critical');
      break;
    case AlertType.lowTemp:
      return ChannelInfo('sId3', 'temp_alert', 'temperature critical');
      break;
    case AlertType.lowBattery:
      return ChannelInfo('sId4', 'battery_alert', 'battery level critical');
      break;
    default:
      return null;
  }
}
