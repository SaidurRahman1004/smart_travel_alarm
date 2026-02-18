import 'package:flutter/material.dart';
Future<DateTime?> showDateTimePicker(BuildContext context) async {
  //date picker
  final DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    // cant before prevoius day
    firstDate: DateTime.now().subtract(const Duration(days: 1)),
    lastDate: DateTime.now().add(const Duration(days: 365)),
  );

  if (pickedDate == null) {
    return null;
  }

  if (!context.mounted) {
    return null;
  }

  // Time picker
  final TimeOfDay? pickedTime = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.fromDateTime(DateTime.now()),
  );


  if (pickedTime == null) {
    return null;
  }

  // return date time combinely
  return DateTime(
    pickedDate.year,
    pickedDate.month,
    pickedDate.day,
    pickedTime.hour,
    pickedTime.minute,
  );
}