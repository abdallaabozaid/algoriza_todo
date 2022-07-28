import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/src/domain/01_tasks/i_tasks_repo.dart';

part 'edit_task_event.dart';
part 'edit_task_state.dart';

class EditTaskBloc extends Bloc<EditTaskEvent, EditTaskState> {
  final ITasksRepo _taskRepo;
  EditTaskBloc(
    this._taskRepo,
  ) : super(EditTaskState.initial()) {
    on<ChangeTaskFavoriteStatusEvent>(_onChangeTaskFavoriteStatusEvent);
    on<ChangeTaskCompeletionStatusEvent>(_onChangeTaskCompeletionStatusEvent);
    on<SetFavAndCompeletionStateEvent>(_onSetFavAndCompeletionStateEvent);
  }

  FutureOr<void> _onChangeTaskFavoriteStatusEvent(
      ChangeTaskFavoriteStatusEvent event, Emitter<EditTaskState> emit) async {
    await _taskRepo.changeTaskFavoriteStatus(
      isFavorite: !event.isFavorite,
      taskId: event.taskId,
    );

    emit(
      state.copyWith(
        isFav: !event.isFavorite,
        taskId: event.taskId,
        startedEdit: true,
      ),
    );
  }

  FutureOr<void> _onChangeTaskCompeletionStatusEvent(
      ChangeTaskCompeletionStatusEvent event,
      Emitter<EditTaskState> emit) async {
    await _taskRepo.changeTaskCompeletionStatus(
      isCompleted: event.isCompleted,
      taskId: event.taskId,
    );

    emit(
      state.copyWith(
        isCompeleted: event.isCompleted,
        taskId: event.taskId,
        startedEdit: true,
      ),
    );
  }

  FutureOr<void> _onSetFavAndCompeletionStateEvent(
      SetFavAndCompeletionStateEvent event, Emitter<EditTaskState> emit) {
    emit(state.copyWith(
      isFav: event.isFavorite,
      isCompeleted: event.isCompleted,
      startedEdit: true,
    ));
  }
}
