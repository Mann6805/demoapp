import 'package:awesome_notifications/awesome_notifications.dart';
import 'dart:math';

import 'package:flutter/material.dart';

class NotificationServices {
  static Future<void> initfunction() async {
    await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(channelKey: "channelKey", channelName: "channelName", channelDescription: "channelDescription", locked: true, enableVibration: true, playSound: true, importance: NotificationImportance.Max, defaultPrivacy: NotificationPrivacy.Public, defaultRingtoneType: DefaultRingtoneType.Notification)

      ]
    );
  }

  static Future<void> scheduleNotification(
    {
      required String message,
    }
  ) async {
    Random random = Random();
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: random.nextInt(1000)+1, 
        channelKey: "channelKey",
        title: "TrashHandler",
        body: message,
        category: NotificationCategory.Message,
        notificationLayout: NotificationLayout.BigText,
        locked: true,
        wakeUpScreen: true,
        autoDismissible: false,
        fullScreenIntent: true,
        backgroundColor: Colors.transparent
      ),
      schedule: NotificationCalendar(
        hour: 22,
        minute: 37,
        second: 0,
        millisecond: 0,
        repeats: true,
        preciseAlarm: true,
        allowWhileIdle: true,
      )
    );
  }

}