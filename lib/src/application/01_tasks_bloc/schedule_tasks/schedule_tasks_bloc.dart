import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:todo_app/src/domain/01_tasks/i_tasks_repo.dart';
import 'package:todo_app/src/domain/01_tasks/task_entity.dart';

part 'schedule_tasks_event.dart';
part 'schedule_tasks_state.dart';

class ScheduleTasksBloc extends Bloc<ScheduleTasksEvent, ScheduleTasksState> {
  final ITasksRepo _tasksRepo;
  ScheduleTasksBloc(
    this._tasksRepo,
  ) : super(ScheduleTasksState.initial()) {
    on<GetScheduledTasksEvent>((event, emit) async {
      final List<ToDoTask> scheduledTasks =
          await _tasksRepo.getTasksByDate(date: event.date);

      emit(
        state.copyWith(
          scheduledTasks: scheduledTasks,
          selectedDate: event.date,
        ),
      );
    });
  }
}
