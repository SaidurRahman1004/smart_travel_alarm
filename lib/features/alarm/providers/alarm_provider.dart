import 'package:flutter/material.dart';
import '../../../helpers/database_helper.dart';
import '../../../services/notification_service.dart';
import '../data/models/alarm_model.dart';

class AlarmProvider extends ChangeNotifier {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  final NotificationService _notificationService = NotificationService();

  //store alarm
  List<AlarmModel> _alarms = [];

  List<AlarmModel> get alarms => _alarms;
  //stared notification service when provider create
  AlarmProvider() {
    _notificationService.initialize();
    loadAlarms();
  }
//load all alarm from database
  Future<void> loadAlarms() async {
    _alarms = await _dbHelper.readAllAlarms();
    notifyListeners();
  }

  // Curd
  Future<void> addAlarm(DateTime dateTime) async {
    final newAlarm = AlarmModel(dateTime: dateTime, isActive: true);
    final createdAlarm = await _dbHelper.createAlarm(newAlarm);
    debugPrint(" Adding alarm: ${dateTime.toString()}");

    // schedule Notification
    if (createdAlarm.id != null) {
      await _notificationService.scheduleNotification(
        createdAlarm.id!,
        "Alarm Ringing!",
        "It's time for your scheduled activity.",
        createdAlarm.dateTime,
      );
      debugPrint(" Alarm #${createdAlarm.id} created and scheduled");
    }
    await loadAlarms();
  }

  // on off toggle
  Future<void> toggleAlarm(AlarmModel alarm) async {
    final updatedAlarm = alarm.copyWith(isActive: !alarm.isActive);
    await _dbHelper.update(updatedAlarm);

    //if alarm started restart ssHudule alarm notification
    if (updatedAlarm.isActive) {
      await _notificationService.scheduleNotification(
        updatedAlarm.id!,
        "Alarm Ringing!",
        "Notification Alarm Started",
        updatedAlarm.dateTime,
      );
    } else {
      // cancel shudule notification if off
      await _notificationService.cancelNotification(updatedAlarm.id!);
    }
    await loadAlarms();
  }

//delete alarm
  Future<void> deleteAlarm(AlarmModel alarm) async {
    if (alarm.id != null) {
      await _dbHelper.delete(alarm.id!);
      await _notificationService.cancelNotification(alarm.id!);
      await loadAlarms();
    }
  }
}