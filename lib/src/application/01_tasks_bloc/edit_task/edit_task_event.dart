part of 'edit_task_bloc.dart';

abstract class EditTaskEvent extends Equatable {
  const EditTaskEvent();

  @override
  List<Object> get props => [];
}

class SetFavAndCompeletionStateEvent extends EditTaskEvent {
  final bool isFavorite;
  final bool isCompleted;
  const SetFavAndCompeletionStateEvent({
    required this.isFavorite,
    required this.isCompleted,
  });

  @override
  List<Object> get props => [isCompleted, isFavorite];
}

class ChangeTaskFavoriteStatusEvent extends EditTaskEvent {
  final bool isFavorite;
  final int taskId;
  const ChangeTaskFavoriteStatusEvent({
    required this.isFavorite,
    required this.taskId,
  });

  @override
  List<Object> get props => [taskId, isFavorite];
}

class ChangeTaskCompeletionStatusEvent extends EditTaskEvent {
  final bool isCompleted;
  final int taskId;

  const ChangeTaskCompeletionStatusEvent({
    required this.isCompleted,
    required this.taskId,
  });

  @override
  List<Object> get props => [taskId, isCompleted];
}
