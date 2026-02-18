import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  //NotificationService Initialization call once
  Future<void> initialize() async {
    //set timezone
    await _configureLocalTimezone();

    ///Settings For Notifications

    //android
    const initializationSettingsAndroid = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    //ios
    const iosInitSettings = DarwinInitializationSettings();
    //all settings
    const InitializationSettings initializationSettings =
        InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: iosInitSettings,
        );
    await _notificationsPlugin.initialize(settings: initializationSettings);

    final bool? result = await _notificationsPlugin.initialize(
      settings: initializationSettings,
    );
    debugPrint("Notification Service Initialized: $result");
    //Notificaton permisssion
    await _requestNotificationPermission();
  }

  // //find current device timezone
  Future<void> _configureLocalTimezone() async {
    //timezone initalization
    tz.initializeTimeZones();
    try {
      final timezoneInfo = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(timezoneInfo.identifier));
    } catch (e) {
      tz.setLocalLocation(tz.getLocation('UTC'));
      debugPrint("Timezone error: $e");
    }
  }

  // request notification permission
  Future<void> _requestNotificationPermission() async {
    final plugin = _notificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    if (plugin != null) {
      await plugin.requestNotificationsPermission();
    }
  }

  //Notification schedule
  Future<void> scheduleNotification(
    int id,
    String title,
    String body,
    DateTime scheduledTime,
  ) async {
    //cheak if alaerm time is before current time, If earlier, then setting it to tomorrow by adding 1 day
    if (scheduledTime.isBefore(DateTime.now())) {
      scheduledTime = scheduledTime.add(const Duration(days: 1));
    }
    await _notificationsPlugin.zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: tz.TZDateTime.from(scheduledTime, tz.local),
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          'alarm_channel_id',
          'Alarms',
          channelDescription: 'This channel is used for alarm notifications.',
          importance: Importance.max,
          priority: Priority.max,
          playSound: true,
        ),
        iOS: DarwinNotificationDetails(
          sound: 'default.wav',
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      //play sound only when app is in background
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  //cancel notification
  Future<void> cancelNotification(int id) async {
    await _notificationsPlugin.cancel(id: id);
  }
}
