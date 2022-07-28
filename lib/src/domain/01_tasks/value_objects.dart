import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:todo_app/config/constants/text_const.dart';
import 'package:todo_app/config/enums.dart';
import 'package:todo_app/src/domain/00_core/validated_value_object.dart';
import 'package:todo_app/src/domain/00_core/value_fauilure.dart';
import 'package:todo_app/src/domain/00_core/value_validators.dart';
import 'package:todo_app/src/infrastructure/01_tasks/local/tasks_database.dart';

class TaskTitle extends ValidatedValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  TaskTitle._({
    required this.value,
  });

  factory TaskTitle(String value) {
    return TaskTitle._(
      value: validateTaskTitleInputAndCaptalize(value),
    );
  }

  @override
  List<Object?> get props => [value];

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({
      TasksDatabase.title: value.fold(
        (l) => 'null',
        (r) => r,
      )
    });

    return result;
  }

  factory TaskTitle.fromMap(Map<String, dynamic> map) {
    return TaskTitle._(
      value: right(map[TasksDatabase.title]!),
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskTitle.fromJson(String source) =>
      TaskTitle.fromMap(json.decode(source));
}

class TaskDate extends Equatable {
  final String value;
  final DateTime date;

  const TaskDate._({
    required this.value,
    required this.date,
  });

  factory TaskDate({required DateTime date}) {
    return TaskDate._(
      value: dateFormatter(date),
      date: date,
    );
  }

  @override
  List<Object?> get props => [value];

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({TasksDatabase.date: value});

    return result;
  }

  factory TaskDate.fromMap(Map<String, dynamic> map) {
    return TaskDate._(
      value: map[TasksDatabase.date] ?? '',
      // date: DateTime.parse(TasksDatabase.date),
      date: DateFormat('yyyy-MM-dd').parse(map[TasksDatabase.date]),
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskDate.fromJson(String source) =>
      TaskDate.fromMap(json.decode(source));
}

class TaskStartTime extends Equatable {
  final String value;
  final TimeOfDay _timeOfDay;

  TimeOfDay get timeOfDay {
    return _timeOfDay;
  }

  const TaskStartTime._(
    this._timeOfDay, {
    required this.value,
  });

  factory TaskStartTime.fromDateTime({required DateTime date}) {
    return TaskStartTime._(TimeOfDay(hour: date.hour, minute: date.minute),
        value: timeFormatterFromDateTime(date));
  }
  factory TaskStartTime.fromTimeOfDay({required TimeOfDay time}) {
    return TaskStartTime._(time, value: timeFormatterFromTimeOfTheDay(time));
  }

  @override
  List<Object?> get props => [value];

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({TasksDatabase.startTime: value});

    return result;
  }

  factory TaskStartTime.fromMap(Map<String, dynamic> map) {
    return TaskStartTime._(
      TimeOfDay(
          hour: DateFormat('hh:mm a').parse(map[TasksDatabase.startTime]).hour,
          minute:
              DateFormat('hh:mm a').parse(map[TasksDatabase.startTime]).minute),
      value: map[TasksDatabase.startTime] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskStartTime.fromJson(String source) =>
      TaskStartTime.fromMap(json.decode(source));
}

class TaskEndTime extends Equatable {
  final String value;
  final TimeOfDay _timeOfDay;

  TimeOfDay get timeOfDay {
    return _timeOfDay;
  }

  const TaskEndTime._(
    this._timeOfDay, {
    required this.value,
  });

  factory TaskEndTime.fromDateTime({required DateTime date}) {
    return TaskEndTime._(TimeOfDay(hour: date.hour, minute: date.minute),
        value: timeFormatterFromDateTime(date));
  }
  factory TaskEndTime.fromTimeOfDay({required TimeOfDay time}) {
    return TaskEndTime._(time, value: timeFormatterFromTimeOfTheDay(time));
  }
  @override
  List<Object?> get props => [value];

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({TasksDatabase.endTime: value});

    return result;
  }

  factory TaskEndTime.fromMap(Map<String, dynamic> map) {
    return TaskEndTime._(
      TimeOfDay(
          hour: DateFormat('hh:mm a').parse(map[TasksDatabase.endTime]).hour,
          minute:
              DateFormat('hh:mm a').parse(map[TasksDatabase.endTime]).minute),
      value: map[TasksDatabase.endTime] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskEndTime.fromJson(String source) =>
      TaskEndTime.fromMap(json.decode(source));
}

abstract class MultpleTypes extends Equatable {
  Enum get type;
  String get label;
  // const MultpleTypes({
  //   required this.type,
  //   required this.label,
  // });

  @override
  List<Object?> get props => [type, label];
}

class PriorityColor extends MultpleTypes {
  @override
  final PriorityType type;
  @override
  final String label;

  final Color color;
  PriorityColor._({
    required this.type,
    required this.label,
    required this.color,
  });

  factory PriorityColor({
    required PriorityType priority,
  }) {
    return PriorityColor._(
      type: priority,
      label: priority.name,
      color: priority == PriorityType.critical
          ? Colors.red
          : priority == PriorityType.high
              ? Colors.orange
              : priority == PriorityType.medium
                  ? Colors.yellow
                  : Colors.blue,
    );
  }

  @override
  List<Object?> get props => [color, label, type];

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({TasksDatabase.priority: label});

    return result;
  }

  factory PriorityColor.fromMap(Map<String, dynamic> map) {
    return PriorityColor._(
      type: map[TasksDatabase.priority] == PriorityType.critical.name
          ? PriorityType.critical
          : map[TasksDatabase.priority] == PriorityType.high.name
              ? PriorityType.high
              : map[TasksDatabase.priority] == PriorityType.medium.name
                  ? PriorityType.medium
                  : PriorityType.low,
      label: map[TasksDatabase.priority]!,
      color: map[TasksDatabase.priority] == PriorityType.critical.name
          ? Colors.red
          : map[TasksDatabase.priority] == PriorityType.high.name
              ? Colors.orange
              : map[TasksDatabase.priority] == PriorityType.medium.name
                  ? Colors.yellow
                  : Colors.blue,
    );
  }

  String toJson() => json.encode(toMap());

  factory PriorityColor.fromJson(String source) =>
      PriorityColor.fromMap(json.decode(source));
}

class Reminder extends MultpleTypes {
  @override
  final ReminderType type;
  @override
  final String label;
  Reminder._({
    required this.type,
    required this.label,
  });

  factory Reminder({
    required ReminderType reminderType,
  }) {
    return Reminder._(
      type: reminderType,
      label: reminderType == ReminderType.tenMins
          ? tenMinsText
          : reminderType == ReminderType.twentyMins
              ? twentyMinsText
              : oneHourText,
    );
  }

  @override
  List<Object?> get props => [type, label];

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({TasksDatabase.reminder: label});

    return result;
  }

  factory Reminder.fromMap(Map<String, dynamic> map) {
    return Reminder._(
      label: map[TasksDatabase.reminder]!,
      type: map[TasksDatabase.reminder] == ReminderType.tenMins.name
          ? ReminderType.tenMins
          : map[TasksDatabase.reminder] == ReminderType.twentyMins.name
              ? ReminderType.twentyMins
              : ReminderType.oneHour,
    );
  }

  String toJson() => json.encode(toMap());

  factory Reminder.fromJson(String source) =>
      Reminder.fromMap(json.decode(source));
}

class Repeat extends MultpleTypes {
  @override
  final RepeatType type;
  @override
  final String label;
  Repeat._({
    required this.type,
    required this.label,
  });

  factory Repeat({
    required RepeatType repeatType,
  }) {
    return Repeat._(
      type: repeatType,
      label: repeatType == RepeatType.daily
          ? dailyRepeatText
          : repeatType == RepeatType.weakly
              ? weaklyRepeatText
              : monthlyRepeatText,
    );
  }

  @override
  List<Object?> get props => [type, label];

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({TasksDatabase.repeat: label});

    return result;
  }

  factory Repeat.fromMap(Map<String, dynamic> map) {
    return Repeat._(
      label: map[TasksDatabase.repeat]!,
      type: map[TasksDatabase.repeat] == RepeatType.daily.name
          ? RepeatType.daily
          : map[TasksDatabase.repeat] == RepeatType.weakly.name
              ? RepeatType.weakly
              : RepeatType.monthly,
    );
  }

  String toJson() => json.encode(toMap());

  factory Repeat.fromJson(String source) => Repeat.fromMap(json.decode(source));
}

class FavoriteStatus extends Equatable {
  bool _isFavorite;
  FavoriteStatus(
    this._isFavorite,
  );

  bool get isFavorite => _isFavorite;
  void setFavoriteStatus(bool isFav) {
    _isFavorite = isFav;
  }

  @override
  List<Object?> get props => [_isFavorite, isFavorite];
}

class CompeletionStatus extends Equatable {
  bool _isCompeletion;
  CompeletionStatus(
    this._isCompeletion,
  );

  bool get isCompeleted => _isCompeletion;

  void setCompeletionStatus(bool isCompeleted) {
    _isCompeletion = isCompeleted;
  }

  @override
  List<Object?> get props => [_isCompeletion, isCompeleted];
}
