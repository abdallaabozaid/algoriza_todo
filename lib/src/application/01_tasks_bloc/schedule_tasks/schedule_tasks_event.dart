part of 'schedule_tasks_bloc.dart';

abstract class ScheduleTasksEvent extends Equatable {
  const ScheduleTasksEvent();

  @override
  List<Object> get props => [];
}

class GetScheduledTasksEvent extends ScheduleTasksEvent {
  final DateTime date;
  const GetScheduledTasksEvent({
    required this.date,
  });

  @override
  List<Object> get props => [date];
}
