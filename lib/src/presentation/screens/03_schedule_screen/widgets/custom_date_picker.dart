import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:todo_app/config/theme/app_colors.dart';
import 'package:todo_app/src/application/01_tasks_bloc/schedule_tasks/schedule_tasks_bloc.dart';
import 'package:todo_app/src/presentation/core_widgets/bloc_events.dart';

class CustomDatePicker extends StatelessWidget {
  const CustomDatePicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScheduleTasksBloc, ScheduleTasksState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.black45, width: 1)),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 90.h,
                child: ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: ((context, index) {
                    final DateTime date = DateTime.now().add(
                      Duration(days: index),
                    );

                    return DateItem(
                      date: date,
                      selectedDate: BlocProvider.of<ScheduleTasksBloc>(context)
                          .state
                          .selectedDate,
                    );
                  }),
                ),
              )
            ]),
          ),
        );
      },
    );
  }
}

class DateItem extends StatelessWidget {
  const DateItem({
    Key? key,
    required this.date,
    required this.selectedDate,
  }) : super(key: key);
  final DateTime date;

  final DateTime selectedDate;

  bool get isSelected =>
      date.month == selectedDate.month &&
      date.day == selectedDate.day &&
      date.year == selectedDate.year;

  String get dayName => DateFormat('E').format(date);
  String get dayNumber => DateFormat('d').format(date);

  String get monthName => DateFormat('MMM').format(date);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () => AppBlocEvents.getScheduledTasksByDate(context, date: date),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22.r),
          color: isSelected ? AppColors.appMainColor : Colors.transparent,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              dayName,
              style: textTheme.bodySmall!
                  .copyWith(color: isSelected ? Colors.white : Colors.black),
            ),
            Text(
              dayNumber,
              style: textTheme.bodySmall!
                  .copyWith(color: isSelected ? Colors.white : Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
