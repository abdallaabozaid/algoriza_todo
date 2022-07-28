part of 'edit_task_bloc.dart';

class EditTaskState extends Equatable {
  EditTaskState({
    required this.isFav,
    required this.isCompeleted,
    required this.startedEdit,
    required this.taskId,
  });
  bool isFav;
  bool isCompeleted;
  bool startedEdit;

  int taskId;

  factory EditTaskState.initial() {
    return EditTaskState(
        isCompeleted: false, isFav: false, startedEdit: false, taskId: 00000);
  }

  @override
  List<Object> get props => [isFav, isCompeleted, taskId];

  EditTaskState copyWith({
    bool? isFav,
    bool? isCompeleted,
    bool? startedEdit,
    int? taskId,
  }) {
    return EditTaskState(
      isFav: isFav ?? this.isFav,
      isCompeleted: isCompeleted ?? this.isCompeleted,
      startedEdit: startedEdit ?? this.startedEdit,
      taskId: taskId ?? this.taskId,
    );
  }
}

// class EditTaskInitialState extends EditTaskState {}

// class FavoritStatusChangedState extends EditTaskState {
//   final bool isFav;
//   const FavoritStatusChangedState({
//     required this.isFav,
//   });
//   @override
//   List<Object> get props => [isFav];
// }

// class CompeletionStatusChangedState extends EditTaskState {
//   final bool isCompeleted;
//   const CompeletionStatusChangedState({
//     required this.isCompeleted,
//   });

//   @override
//   List<Object> get props => [isCompeleted];
// }
