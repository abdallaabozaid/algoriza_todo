part of 'schedule_tasks_bloc.dart';

class ScheduleTasksState extends Equatable {
  const ScheduleTasksState({
    required this.selectedDate,
    required this.scheduledTasks,
  });

  factory ScheduleTasksState.initial() {
    return ScheduleTasksState(
      scheduledTasks: [],
      selectedDate: DateTime.now(),
    );
  }

  final DateTime selectedDate;
  final List<ToDoTask> scheduledTasks;

  @override
  List<Object> get props => [selectedDate, scheduledTasks];

  ScheduleTasksState copyWith({
    DateTime? selectedDate,
    List<ToDoTask>? scheduledTasks,
  }) {
    return ScheduleTasksState(
      selectedDate: selectedDate ?? this.selectedDate,
      scheduledTasks: scheduledTasks ?? this.scheduledTasks,
    );
  }
}
