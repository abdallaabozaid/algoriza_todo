import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:todo_app/config/constants/route_const.dart';
import 'package:todo_app/src/application/01_tasks_bloc/add_task/add_task_bloc.dart';
import 'package:todo_app/src/application/01_tasks_bloc/schedule_tasks/schedule_tasks_bloc.dart';
import 'package:todo_app/src/infrastructure/01_tasks/local/local_tasks_repo.dart';
import 'package:todo_app/src/presentation/screens/01_home_screen/home_screen.dart';
import 'package:todo_app/src/presentation/screens/02_add_task_screen/add_task_screen.dart';
import 'package:todo_app/src/presentation/screens/03_schedule_screen/schedule_screen.dart';

class AppRouter {
  static Route? generateRoute(
    RouteSettings settings,
  ) {
    switch (settings.name) {
      case homeScreen:
        return _navigateTo(
          nextPageWidget: const HomeScreen(),
          transitionType: PageTransitionType.leftToRight,
        );

      case addTaskScreen:
        return _navigateTo(
          nextPageWidget: const AddTaskScreen(),
          transitionType: PageTransitionType.bottomToTop,
        );

      case scheduleScreen:
        return _navigateTo(
          nextPageWidget: Builder(builder: (context) {
            BlocProvider.of<ScheduleTasksBloc>(context).add(
              GetScheduledTasksEvent(
                date: DateTime.now(),
              ),
            );
            return const ScheduleScreen();
          }),
          transitionType: PageTransitionType.leftToRight,
        );

      default:
    }
    return null;
  }

  static PageTransition _navigateTo({
    required Widget nextPageWidget,
    Widget? lastPageWidget,
    required PageTransitionType transitionType,
  }) {
    return PageTransition(
      type: transitionType,
      child: nextPageWidget,
      childCurrent: lastPageWidget,
    );
  }
}
