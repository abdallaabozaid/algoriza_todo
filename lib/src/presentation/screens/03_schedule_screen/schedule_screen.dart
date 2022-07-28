import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/config/constants/text_const.dart';
import 'package:todo_app/src/application/01_tasks_bloc/schedule_tasks/schedule_tasks_bloc.dart';
import 'package:todo_app/src/presentation/screens/00_common_widgets/app_bar.dart';
import 'package:todo_app/src/presentation/screens/00_common_widgets/go_back_icon.dart';
import 'package:todo_app/src/presentation/screens/03_schedule_screen/widgets/custom_date_picker.dart';
import 'package:todo_app/src/presentation/screens/03_schedule_screen/widgets/date_info.dart';
import 'package:todo_app/src/presentation/screens/03_schedule_screen/widgets/scheduled_task_builder.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 100.h),
        child: const CommonAppBar(
          titleText: scheduleAppBarText,
          borderSideWidth: 1,
          leadingIcon: GoBackIcon(),
        ),
      ),
      body: BlocBuilder<ScheduleTasksBloc, ScheduleTasksState>(
        builder: (context, state) {
          print('rebuilt');
          return Column(
            children: [
              const CustomDatePicker(),
              const DateInfo(),
              Expanded(
                child: ScheduledTaskBuilder(tasks: state.scheduledTasks),
              ),
            ],
          );
        },
      ),
    );
  }
}
