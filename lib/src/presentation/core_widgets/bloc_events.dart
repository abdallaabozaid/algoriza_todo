import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/config/enums.dart';
import 'package:todo_app/src/application/01_tasks_bloc/add_task/add_task_bloc.dart';
import 'package:todo_app/src/application/01_tasks_bloc/all_tasks/tasks_bloc.dart';
import 'package:todo_app/src/application/01_tasks_bloc/edit_task/edit_task_bloc.dart';
import 'package:todo_app/src/application/01_tasks_bloc/schedule_tasks/schedule_tasks_bloc.dart';
import 'package:todo_app/src/domain/01_tasks/task_entity.dart';

class AppBlocEvents {
  static void getAllTasks(BuildContext ctx) {
    BlocProvider.of<TasksBloc>(ctx).add(
      GetAllTasksEvent(),
    );
  }

  static void getScheduledTasksByDate(BuildContext ctx,
      {required DateTime date}) {
    BlocProvider.of<ScheduleTasksBloc>(ctx).add(
      GetScheduledTasksEvent(date: date),
    );
  }

  static void removeTask(
    BuildContext ctx, {
    required ToDoTask removedTask,
  }) {
    BlocProvider.of<TasksBloc>(ctx).add(
      RemoveTaskEvent(removedTask: removedTask),
    );
  }

  static void addTask(
    BuildContext ctx,
  ) {
    BlocProvider.of<AddTaskBloc>(ctx).add(
      const AdddTaskEvent(),
    );
  }

  static void changeTaskTitle(BuildContext ctx, {required String title}) {
    BlocProvider.of<AddTaskBloc>(ctx).add(
      TaskTitleChangedEvent(title),
    );
  }

  static void changeDate(BuildContext ctx, {required DateTime date}) {
    BlocProvider.of<AddTaskBloc>(ctx).add(
      DateChangedEvent(date),
    );
  }

  static void changeTaskStartTime(BuildContext ctx, {required TimeOfDay time}) {
    BlocProvider.of<AddTaskBloc>(ctx).add(
      StartTimeChangedEvent(time),
    );
  }

  static void changeTaskEndTime(BuildContext ctx, {required TimeOfDay time}) {
    BlocProvider.of<AddTaskBloc>(ctx).add(
      EndTimeChangedEvent(time),
    );
  }

  static void changeTaskRemider(BuildContext ctx,
      {required ReminderType type}) {
    BlocProvider.of<AddTaskBloc>(ctx).add(
      RemindChangedEvent(type),
    );
  }

  static void changeTaskRepeat(BuildContext ctx, {required RepeatType type}) {
    BlocProvider.of<AddTaskBloc>(ctx).add(
      RepeatChangedEvent(type),
    );
  }

  static void changeTaskPriority(BuildContext ctx,
      {required PriorityType type}) {
    BlocProvider.of<AddTaskBloc>(ctx).add(
      PriorityChangedEvent(type),
    );
  }

  static void changeTaskFavStatus(
    BuildContext ctx, {
    required bool isFavorite,
    required int taskId,
  }) {
    BlocProvider.of<EditTaskBloc>(ctx).add(
      ChangeTaskFavoriteStatusEvent(isFavorite: isFavorite, taskId: taskId),
    );
  }

  static void changeTaskCompeletionStatus(
    BuildContext ctx, {
    required bool isCompleted,
    required int taskId,
  }) {
    BlocProvider.of<EditTaskBloc>(ctx).add(
      ChangeTaskCompeletionStatusEvent(
        isCompleted: isCompleted,
        taskId: taskId,
      ),
    );
  }

  static void setTaskFavAndCompeleteStatus(
    BuildContext ctx, {
    required bool isFavorite,
    required bool isCompeleted,
  }) {
    BlocProvider.of<EditTaskBloc>(ctx).add(
      SetFavAndCompeletionStateEvent(
        isFavorite: isFavorite,
        isCompleted: isCompeleted,
      ),
    );
  }
}
