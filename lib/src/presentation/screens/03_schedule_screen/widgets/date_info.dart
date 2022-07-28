import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/src/application/01_tasks_bloc/schedule_tasks/schedule_tasks_bloc.dart';

class DateInfo extends StatelessWidget {
  const DateInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocBuilder<ScheduleTasksBloc, ScheduleTasksState>(
      builder: (context, state) {
        final selectedDate =
            BlocProvider.of<ScheduleTasksBloc>(context).state.selectedDate;
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 22.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat('EEEE').format(selectedDate),
                style: textTheme.bodySmall!.copyWith(color: Colors.black),
              ),
              Text(
                DateFormat('dd MMMM, yyyy').format(selectedDate),
                style: textTheme.bodySmall!.copyWith(color: Colors.black),
              ),
            ],
          ),
        );
      },
    );
  }
}
