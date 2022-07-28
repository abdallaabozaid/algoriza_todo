import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/config/constants/text_const.dart';
import 'package:todo_app/config/enums.dart';
import 'package:todo_app/src/application/01_tasks_bloc/all_tasks/tasks_bloc.dart';
import 'package:todo_app/src/domain/01_tasks/task_entity.dart';
import 'package:todo_app/src/infrastructure/01_tasks/local/local_tasks_repo.dart';
import 'package:todo_app/src/presentation/core_widgets/bloc_events.dart';
import 'package:todo_app/src/presentation/screens/01_home_screen/widgets/task_item.dart';

import '../../../../application/01_tasks_bloc/add_task/add_task_bloc.dart';
import '../../../../application/01_tasks_bloc/edit_task/edit_task_bloc.dart';

class HomeTabBuilder extends StatelessWidget {
  HomeTabBuilder({Key? key, required this.homeTabType}) : super(key: key);
  final HomeTabType homeTabType;

  factory HomeTabBuilder.allTasks() {
    return HomeTabBuilder(
      homeTabType: HomeTabType.all,
    );
  }

  factory HomeTabBuilder.completedTasks() {
    return HomeTabBuilder(
      homeTabType: HomeTabType.compeleted,
    );
  }

  factory HomeTabBuilder.unCompletedTasks() {
    return HomeTabBuilder(
      homeTabType: HomeTabType.uncompleted,
    );
  }

  factory HomeTabBuilder.favoriteTasks() {
    return HomeTabBuilder(
      homeTabType: HomeTabType.favorite,
    );
  }

  List<ToDoTask> tasks = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditTaskBloc, EditTaskState>(
      builder: (context, state) {
        return BlocBuilder<TasksBloc, TasksState>(
          builder: (context, tasksBlockstate) {
            return BlocBuilder<AddTaskBloc, AddTaskState>(
              buildWhen: (previous, current) {
                // rebuild addTaskBloc only when the task is added successfully
                return current.addingSuccessOrFailureOption.fold(
                  () => false,
                  (a) => a.fold(
                    (failure) => false,
                    (sucess) {
                      return true;
                    },
                  ),
                );
              },
              builder: (context, addTaskBlocState) {
                switch (homeTabType) {
                  case HomeTabType.all:
                    tasks = tasksBlockstate.loadedTasks;
                    break;

                  case HomeTabType.compeleted:
                    tasks = tasksBlockstate.loadedTasks
                        .where((task) => task.compeletionStatus.isCompeleted)
                        .toList();

                    break;

                  case HomeTabType.uncompleted:
                    tasks = tasksBlockstate.loadedTasks
                        .where((task) => !task.compeletionStatus.isCompeleted)
                        .toList();

                    break;

                  case HomeTabType.favorite:
                    tasks = tasksBlockstate.loadedTasks
                        .where((task) => task.favoriteStatus.isFavorite)
                        .toList();

                    break;
                  default:
                }

                return tasks.isEmpty
                    ? _emptyTaskListText(context)
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: tasks.length,
                        padding: EdgeInsets.symmetric(
                            vertical: 30.h, horizontal: 22.w),
                        itemBuilder: (context, index) {
                          return TaskItem(
                            task: tasks[index],
                          );
                        });
              },
            );
          },
        );
      },
    );
  }

  Widget _emptyTaskListText(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 20.h,
        ),
        child: Text(
          emptyTaskListText,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
