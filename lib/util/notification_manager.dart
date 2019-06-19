import 'dart:async';
// import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationManager {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  bool noErr = true;

  Future init() async {
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    noErr = await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    return;
  }

  Future show(String message) async {
    if (!noErr) return;
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'ble chennel id', 'ble message chennel', 'show ble message',
        importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
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
}
