part of 'add_task_bloc.dart';

class AddTaskState extends Equatable {
  const AddTaskState({
    required this.showErrors,
    required this.isLoading,
    required this.addedTask,
    required this.addingSuccessOrFailureOption,
    required this.timeFailure,
  });

  factory AddTaskState.initial() {
    return AddTaskState(
      showErrors: false,
      isLoading: false,
      addedTask: ToDoTask(
        id: Random().nextInt(1000000000),
        title: TaskTitle(''),
        priorityColor: PriorityColor(priority: PriorityType.critical),
        date: TaskDate(date: DateTime.now()),
        startTime: TaskStartTime.fromDateTime(date: DateTime.now()),
        endTime: TaskEndTime.fromDateTime(
          date: DateTime.now(),
        ),
        reminder: Reminder(reminderType: ReminderType.tenMins),
        repeat: Repeat(repeatType: RepeatType.daily),
        compeletionStatus: CompeletionStatus(false),
        favoriteStatus: FavoriteStatus(false),
      ),
      addingSuccessOrFailureOption: none(),
      timeFailure: none(),
    );
  }

  final bool showErrors;
  final bool isLoading;
  final ToDoTask addedTask;
  final Option<ChooseTimeFailure> timeFailure;

  final Option<Either<AddTaskFailure, Unit>> addingSuccessOrFailureOption;

  @override
  List<Object> get props => [showErrors, isLoading, addedTask];

  AddTaskState copyWith({
    bool? showErrors,
    bool? isLoading,
    ToDoTask? addedTask,
    Option<ChooseTimeFailure>? timeFailure,
    Option<Either<AddTaskFailure, Unit>>? addingSuccessOrFailureOption,
  }) {
    return AddTaskState(
      showErrors: showErrors ?? this.showErrors,
      isLoading: isLoading ?? this.isLoading,
      addedTask: addedTask ?? this.addedTask,
      timeFailure: timeFailure ?? this.timeFailure,
      addingSuccessOrFailureOption:
          addingSuccessOrFailureOption ?? this.addingSuccessOrFailureOption,
    );
  }
}
