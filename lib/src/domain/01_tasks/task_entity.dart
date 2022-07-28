import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:todo_app/src/domain/01_tasks/value_objects.dart';
import 'package:todo_app/src/infrastructure/01_tasks/local/tasks_database.dart';

class ToDoTask extends Equatable {
  final int id;
  final TaskTitle title;
  final PriorityColor priorityColor;
  final TaskDate date;
  final TaskStartTime startTime;
  final TaskEndTime endTime;
  final Reminder reminder;
  final Repeat repeat;
  final CompeletionStatus compeletionStatus;
  final FavoriteStatus favoriteStatus;

  const ToDoTask({
    required this.id,
    required this.title,
    required this.priorityColor,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.reminder,
    required this.repeat,
    required this.compeletionStatus,
    required this.favoriteStatus,
  });

  @override
  List<Object> get props {
    return [
      id,
      title,
      priorityColor,
      date,
      startTime,
      endTime,
      reminder,
      repeat,
      compeletionStatus,
      favoriteStatus,
    ];
  }

  ToDoTask copyWith({
    int? id,
    TaskTitle? title,
    PriorityColor? priorityColor,
    TaskDate? date,
    TaskStartTime? startTime,
    TaskEndTime? endTime,
    Reminder? reminder,
    Repeat? repeat,
    CompeletionStatus? compeletionStatus,
    FavoriteStatus? favoriteStatus,
  }) {
    return ToDoTask(
      id: id ?? this.id,
      title: title ?? this.title,
      priorityColor: priorityColor ?? this.priorityColor,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      reminder: reminder ?? this.reminder,
      repeat: repeat ?? this.repeat,
      compeletionStatus: compeletionStatus ?? this.compeletionStatus,
      favoriteStatus: favoriteStatus ?? this.favoriteStatus,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{
      TasksDatabase.id: id,
      TasksDatabase.title: title.toJson(),
      TasksDatabase.date: date.toJson(),
      TasksDatabase.startTime: startTime.toJson(),
      TasksDatabase.priority: priorityColor.toJson(),
      TasksDatabase.endTime: endTime.toJson(),
      TasksDatabase.reminder: reminder.toJson(),
      TasksDatabase.repeat: repeat.toJson(),
      TasksDatabase.compeletion: compeletionStatus.isCompeleted ? 1 : 0,
      TasksDatabase.favorite: favoriteStatus.isFavorite ? 1 : 0,
    };

    return result;
  }

  factory ToDoTask.fromMap(Map<String, dynamic> map) {
    return ToDoTask(
      id: map[TasksDatabase.id]?.toInt() ?? 0,
      title: TaskTitle.fromJson(map[TasksDatabase.title]),
      priorityColor: PriorityColor.fromJson(map[TasksDatabase.priority]),
      date: TaskDate.fromJson(map[TasksDatabase.date]),
      startTime: TaskStartTime.fromJson(map[TasksDatabase.startTime]),
      endTime: TaskEndTime.fromJson(map[TasksDatabase.endTime]),
      reminder: Reminder.fromJson(map[TasksDatabase.reminder]),
      repeat: Repeat.fromJson(map[TasksDatabase.repeat]),
      compeletionStatus: CompeletionStatus(map[TasksDatabase.compeletion] == 1),
      favoriteStatus: FavoriteStatus(map[TasksDatabase.favorite] == 1),
    );
  }

  String toJson() => json.encode(toMap());

  factory ToDoTask.fromJson(String source) =>
      ToDoTask.fromMap(json.decode(source));
}
