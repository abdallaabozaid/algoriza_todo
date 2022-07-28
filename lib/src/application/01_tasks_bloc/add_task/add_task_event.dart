part of 'add_task_bloc.dart';

abstract class AddTaskEvent extends Equatable {
  const AddTaskEvent();
  @override
  List<Object> get props => [];
}

class AdddTaskEvent extends AddTaskEvent {
  const AdddTaskEvent();
}

class TaskTitleChangedEvent extends AddTaskEvent {
  final String title;

  const TaskTitleChangedEvent(this.title);
}

class DateChangedEvent extends AddTaskEvent {
  final DateTime date;

  const DateChangedEvent(this.date);
}

class StartTimeChangedEvent extends AddTaskEvent {
  final TimeOfDay startTime;

  const StartTimeChangedEvent(this.startTime);
}

class EndTimeChangedEvent extends AddTaskEvent {
  final TimeOfDay endTime;

  const EndTimeChangedEvent(this.endTime);
}

class RemindChangedEvent extends AddTaskEvent {
  final ReminderType type;

  const RemindChangedEvent(this.type);
}

class RepeatChangedEvent extends AddTaskEvent {
  final RepeatType type;

  const RepeatChangedEvent(this.type);
}

class PriorityChangedEvent extends AddTaskEvent {
  final PriorityType type;

  const PriorityChangedEvent(this.type);
}



// class DateChangedEvent extends AddTaskEvent {}

