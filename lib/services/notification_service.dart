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
    const iosInitSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    //all settings
    const InitializationSettings initializationSettings =
    InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: iosInitSettings,
    );

    await _notificationsPlugin.initialize(
      settings: initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        debugPrint('Notification clicked: ${response.payload}');
      },
    );

    //Notification channel
    await _createNotificationChannel();

    // Notification permission
    await _requestNotificationPermission();

    await _checkAndRequestExactAlarmPermission();
  }

  //find current device timezone
  Future<void> _configureLocalTimezone() async {
    //timezone initalization
    tz.initializeTimeZones();
    try {
      final timezoneInfo = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(timezoneInfo.identifier));
    } catch (e) {
      tz.setLocalLocation(tz.getLocation('UTC'));
    }
  }

  //notification channel create
  Future<void> _createNotificationChannel() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
      _notificationsPlugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();

      if (androidImplementation != null) {
        const AndroidNotificationChannel channel = AndroidNotificationChannel(
          'alarm_channel_id',
          'Alarms',
          description: 'This channel is used for alarm notifications.',
          importance: Importance.max,
          playSound: true,
          enableVibration: true,
          showBadge: true,
        );

        await androidImplementation.createNotificationChannel(channel);
      }
    }
  }

  // request notification permission
  Future<bool> _requestNotificationPermission() async {
    //android
    if (defaultTargetPlatform == TargetPlatform.android) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
      _notificationsPlugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();

      if (androidImplementation != null) {
        final bool? alreadyGranted =
        await androidImplementation.areNotificationsEnabled();

        if (alreadyGranted == false) {
          final bool? granted =
          await androidImplementation.requestNotificationsPermission();
          return granted ?? false;
        } else {
          return alreadyGranted ?? false;
        }
      }
    }

    // iOS
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      final bool? result = await _notificationsPlugin
          .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
      return result ?? false;
    }

    return false;
  }

  Future<void> _checkAndRequestExactAlarmPermission() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
      _notificationsPlugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();

      if (androidImplementation != null) {
        final bool? canScheduleExactAlarms =
        await androidImplementation.canScheduleExactNotifications();

        if (canScheduleExactAlarms == false) {
          await androidImplementation.requestExactAlarmsPermission();
        }
      }
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
    DateTime finalScheduledTime = scheduledTime;
    final now = DateTime.now();

    if (scheduledTime.isBefore(now)) {
      finalScheduledTime = scheduledTime.add(const Duration(days: 1));
    }

    final tz.TZDateTime tzScheduledTime = tz.TZDateTime.from(
      finalScheduledTime,
      tz.local,
    );

    await _notificationsPlugin.zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: tzScheduledTime,
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          'alarm_channel_id',
          'Alarms',
          channelDescription: 'This channel is used for alarm notifications.',
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
          enableVibration: true,
          fullScreenIntent: true,
          category: AndroidNotificationCategory.alarm,
          visibility: NotificationVisibility.public,
          autoCancel: false,
          ongoing: false,
          showWhen: true,
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  //cancel notification
  Future<void> cancelNotification(int id) async {
    await _notificationsPlugin.cancel(id: id);
  }


}