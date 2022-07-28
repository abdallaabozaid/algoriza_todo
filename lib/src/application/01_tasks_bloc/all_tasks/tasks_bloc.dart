import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/src/domain/01_tasks/i_tasks_repo.dart';
import 'package:todo_app/src/domain/01_tasks/task_entity.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  List<ToDoTask> loadedTasks = [];
  final ITasksRepo _tasksRepo;
  TasksBloc(this._tasksRepo) : super(TasksState.initial()) {
    on<GetAllTasksEvent>(_onGetAllTasks);
    on<RemoveTaskEvent>(_onRemoveTaskEvent);
  }

  FutureOr<void> _onGetAllTasks(
      GetAllTasksEvent event, Emitter<TasksState> emit) async {
    emit(
      state.copyWith(
        isLoading: true,
      ),
    );

    loadedTasks = await _tasksRepo.getAllTasks();

    emit(
      state.copyWith(
        isLoading: false,
        loadedTasks: loadedTasks,
      ),
    );
  }

  FutureOr<void> _onRemoveTaskEvent(
      RemoveTaskEvent event, Emitter<TasksState> emit) async {
    emit(
      state.copyWith(
        isLoading: true,
      ),
    );

    loadedTasks = await _tasksRepo.removeTask(removedTask: event.removedTask);
    emit(
      state.copyWith(
        isLoading: false,
        loadedTasks: loadedTasks,
      ),
    );
  }
}
