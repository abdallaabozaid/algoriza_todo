import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/config/router/app_router.dart';
import 'package:todo_app/config/theme/app_theme.dart';
import 'package:todo_app/src/application/01_tasks_bloc/add_task/add_task_bloc.dart';
import 'package:todo_app/src/application/01_tasks_bloc/all_tasks/tasks_bloc.dart';
import 'package:todo_app/src/application/01_tasks_bloc/edit_task/edit_task_bloc.dart';
import 'package:todo_app/src/application/01_tasks_bloc/schedule_tasks/schedule_tasks_bloc.dart';
import 'package:todo_app/src/infrastructure/01_tasks/local/local_tasks_repo.dart';
import 'package:todo_app/src/presentation/screens/01_home_screen/home_screen.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: false,
      builder: (context, child) {
        final LocalTasksRepo localTasksRepo = LocalTasksRepo();
        return MultiBlocProvider(
          providers: [
            BlocProvider<TasksBloc>(
              create: (context) => TasksBloc(
                localTasksRepo,
              )..add(GetAllTasksEvent()),
            ),
            BlocProvider<AddTaskBloc>(
              create: (context) => AddTaskBloc(localTasksRepo),
            ),
            BlocProvider<ScheduleTasksBloc>(
              create: (context) => ScheduleTasksBloc(localTasksRepo),
            ),
            BlocProvider<EditTaskBloc>(
              create: (context) {
                return EditTaskBloc(localTasksRepo);
              },
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Todo App',
            theme: AppTheme.lightTheme,
            onGenerateRoute: AppRouter.generateRoute,
            home: child,
          ),
        );
      },
      child: const HomeScreen(),
    );
  }
}
