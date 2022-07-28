part of 'tasks_bloc.dart';

abstract class TasksEvent extends Equatable {
  const TasksEvent();

  @override
  List<Object> get props => [];
}

class GetAllTasksEvent extends TasksEvent {}

class RemoveTaskEvent extends TasksEvent {
  final ToDoTask removedTask;
  const RemoveTaskEvent({
    required this.removedTask,
  });

  @override
  List<Object> get props => [removedTask];
}
