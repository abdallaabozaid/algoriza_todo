import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/config/constants/text_const.dart';
import 'package:todo_app/src/presentation/core_widgets/bloc_events.dart';
import 'package:todo_app/src/presentation/screens/00_common_widgets/confirmation_dialog.dart';
import 'package:todo_app/src/presentation/screens/00_common_widgets/task_check_box.dart';

import '../../../../application/01_tasks_bloc/edit_task/edit_task_bloc.dart';
import '../../../../domain/01_tasks/task_entity.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({
    Key? key,
    required this.task,
  }) : super(key: key);

  final ToDoTask task;
  String get taskTitle => task.title.getOrCrash();
  bool get isCompeleted => task.compeletionStatus.isCompeleted;
  bool get isFavorite => task.favoriteStatus.isFavorite;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: BlocConsumer<EditTaskBloc, EditTaskState>(
        listener: (context, state) {
          _geAllTasks(context);
        },
        buildWhen: (previous, current) => current.taskId == task.id,
        builder: (context, state) {
          state.isFav = state.startedEdit ? state.isFav : isFavorite;
          state.isCompeleted = state.startedEdit
              ? state.isCompeleted
              : task.compeletionStatus.isCompeleted;

          return Row(
            children: [
              // Task Compeletion status Icon

              TaskCheckBox(
                color: task.priorityColor.color,
                value: state.isCompeleted,
                onChanged: (value) {
                  AppBlocEvents.changeTaskCompeletionStatus(
                    context,
                    isCompleted: value!,
                    taskId: task.id,
                  );
                },
              ),

              // Task Tilte

              Text(
                taskTitle,
                style: themeData.textTheme.bodyMedium,
              ),
              const Spacer(),

              // Remove Task Icon
              IconButton(
                onPressed: () => _deletConfirmation(context),
                icon: const Icon(Icons.delete_outlined),
              ),

              // Favorite Task Icon

              IconButton(
                onPressed: () {
                  AppBlocEvents.changeTaskFavStatus(
                    context,
                    isFavorite: state.isFav,
                    taskId: task.id,
                  );
                  _geAllTasks(context);
                  print('got');
                },
                icon: Icon(
                  state.isFav ? Icons.favorite : Icons.favorite_border,
                  color: Colors.red,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _deletConfirmation(BuildContext context) async {
    await showDialog<bool>(
      context: context,
      builder: (context) => ConfirmationDialog(
        title: removeConfirmationTitleText,
        content: removeConfirmationContentText,
        confirmLabel: removeConfirmationButtonText,
        onConfirm: () {
          _deleteTask(context);
          Navigator.pop(context);
        },
        onCancel: () => Navigator.pop(context),
      ),
    );
  }

  void _deleteTask(BuildContext context) {
    AppBlocEvents.removeTask(context, removedTask: task);
  }

  void _geAllTasks(BuildContext context) {
    AppBlocEvents.getAllTasks(context);
  }
}
