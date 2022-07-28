part of 'tasks_bloc.dart';

class TasksState extends Equatable {
  const TasksState({
    required this.loadedTasks,
    required this.isLoading,
  });
  final List<ToDoTask> loadedTasks;
  final bool isLoading;

  factory TasksState.initial() {
    return const TasksState(
      loadedTasks: [],
      isLoading: true,
    );
  }

  TasksState copyWith({List<ToDoTask>? loadedTasks, bool? isLoading}) {
    return TasksState(
      loadedTasks: loadedTasks ?? this.loadedTasks,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object> get props => [
        loadedTasks,
        isLoading,
      ];
}
