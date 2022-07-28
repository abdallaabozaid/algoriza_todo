import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/src/application/01_tasks_bloc/edit_task/edit_task_bloc.dart';

import 'package:todo_app/src/application/01_tasks_bloc/schedule_tasks/schedule_tasks_bloc.dart';
import 'package:todo_app/src/domain/01_tasks/task_entity.dart';
import 'package:todo_app/src/infrastructure/01_tasks/local/local_tasks_repo.dart';
import 'package:todo_app/src/presentation/common_widgets/spacers/vertical_spacer.dart';
import 'package:todo_app/src/presentation/core_widgets/bloc_events.dart';
import 'package:todo_app/src/presentation/screens/00_common_widgets/task_check_box.dart';

class ScheduledTaskBuilder extends StatelessWidget {
  const ScheduledTaskBuilder({
    Key? key,
    required this.tasks,
  }) : super(key: key);
  final List<ToDoTask> tasks;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(bottom: 20.h),
      itemCount: tasks.length,
      itemBuilder: (context, index) => ScheduledTaskItem(
        task: tasks[index],
      ),
    );
  }
}

class ScheduledTaskItem extends StatelessWidget {
  const ScheduledTaskItem({
    Key? key,
    required this.task,
  }) : super(key: key);

  final ToDoTask task;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      margin: EdgeInsets.only(bottom: 16.w, right: 16.w, left: 16.w),
      width: double.infinity,
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22.r),
        color: task.priorityColor.color,
      ),
      child: BlocBuilder<EditTaskBloc, EditTaskState>(
        buildWhen: (previous, current) => current.taskId == task.id,
        builder: (context, state) {
          state.isCompeleted = state.startedEdit
              ? state.isCompeleted
              : task.compeletionStatus.isCompeleted;

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.startTime.value,
                    style: textTheme.bodySmall!.copyWith(color: Colors.white),
                  ),
                  VerticalSpacer(height: 6.h),
                  Text(
                    task.title.getOrCrash(),
                    style: textTheme.bodySmall!.copyWith(color: Colors.white),
                  ),
                ],
              ),
              TaskCheckBox(
                value: state.startedEdit
                    ? state.isCompeleted
                    : task.compeletionStatus.isCompeleted,
                onChanged: (value) {
                  AppBlocEvents.changeTaskCompeletionStatus(
                    context,
                    isCompleted: value!,
                    taskId: task.id,
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
