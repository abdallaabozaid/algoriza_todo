import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/src/domain/00_core/value_fauilure.dart';
import 'package:todo_app/src/domain/01_tasks/value_failures.dart';
import 'package:todo_app/config/extentions/string_extentions.dart';

Either<ValueFailure<String>, String> validateTaskTitleInputAndCaptalize(
    String? input) {
  if (input == null || input.isEmpty) {
    return left(InvalidTaskTitle(failedValue: input.toString()));
  } else {
    return right(input.inCaps);
  }
}

String dateFormatter(DateTime date) {
  return DateFormat('yyyy-MM-dd').format(date);
}

// TimeOfDay timeOfDayFromTimeString(String timeString) {
//   final now = DateTime.now();
//   final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);

//   final TimeOfDay tod = TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
//   return tod;
// }

String timeFormatterFromDateTime(DateTime date) {
  return DateFormat('hh:mm a').format(date);
}

String timeFormatterFromTimeOfTheDay(TimeOfDay tod) {
  final now = DateTime.now();
  final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
  final format = DateFormat.jm(); //"6:00 AM"
  return format.format(dt);
}
