import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:todo_app/config/constants/text_const.dart';
import 'package:todo_app/src/domain/00_core/value_fauilure.dart';
import 'package:todo_app/src/domain/00_core/value_validators.dart';
import 'package:todo_app/src/domain/01_tasks/value_failures.dart';
import 'package:todo_app/src/presentation/common_widgets/spacers/horizontal_spacer.dart';
import 'package:todo_app/src/presentation/core_widgets/bloc_events.dart';
import 'package:todo_app/src/presentation/screens/00_common_widgets/error_text.dart';
import 'package:todo_app/src/presentation/screens/02_add_task_screen/widgets/picker_field.dart';

import '../../../../application/01_tasks_bloc/add_task/add_task_bloc.dart';

class TimePickers extends StatelessWidget {
  const TimePickers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddTaskBloc, AddTaskState>(
      builder: (context, state) {
        late final ChooseTimeFailure timeFailure;
        final bool showTimeErrors = state.timeFailure.fold(
          () => false,
          (f) {
            timeFailure = f;
            return true;
          },
        );
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: PickerField(
                    fieldTitle: startTimeText,
                    fieldHintText: state.addedTask.startTime.value,
                    icon: Icons.access_time_rounded,
                    onPressed: () => _selectStartTime(context),
                    showError: showTimeErrors,
                    height: 60,
                  ),
                ),
                HorizontalSpacer(width: 12.w),
                Expanded(
                  flex: 1,
                  child: PickerField(
                    fieldTitle: endTimeText,
                    fieldHintText: state.addedTask.endTime.value,
                    icon: Icons.access_time_rounded,
                    onPressed: () => _selectEndTime(context),
                    showError: showTimeErrors,
                    height: 60,
                  ),
                ),
              ],
            ),
            if (showTimeErrors) ErrorText(failure: timeFailure),
          ],
        );
      },
    );
  }

  Future<void> _selectStartTime(BuildContext context) async {
    final taskStartTimeOfDay = BlocProvider.of<AddTaskBloc>(context)
        .state
        .addedTask
        .startTime
        .timeOfDay;

    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: taskStartTimeOfDay,
    );

    if (picked != null && picked != taskStartTimeOfDay) {
      AppBlocEvents.changeTaskStartTime(context, time: picked);
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final taskEndTimeOfDay =
        BlocProvider.of<AddTaskBloc>(context).state.addedTask.endTime.timeOfDay;

    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: taskEndTimeOfDay,
    );

    if (picked != null && picked != taskEndTimeOfDay) {
      AppBlocEvents.changeTaskEndTime(context, time: picked);
    }
  }
}
