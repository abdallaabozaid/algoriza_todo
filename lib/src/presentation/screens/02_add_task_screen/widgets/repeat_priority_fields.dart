import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/src/presentation/common_widgets/spacers/horizontal_spacer.dart';
import 'package:todo_app/src/presentation/screens/02_add_task_screen/widgets/drop_down_picker.dart';

import '../../../../../config/constants/text_const.dart';
import '../../../../../config/enums.dart';
import '../../../../application/01_tasks_bloc/add_task/add_task_bloc.dart';
import '../../../../domain/01_tasks/value_objects.dart';

class RepeatPriorityFields extends StatelessWidget {
  const RepeatPriorityFields({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddTaskBloc, AddTaskState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: DropDownPicker(
                fieldTitle: repeatLabelText,
                itemsList: [
                  Repeat(repeatType: RepeatType.daily),
                  Repeat(repeatType: RepeatType.weakly),
                  Repeat(repeatType: RepeatType.monthly)
                ],
                selectedValue: state.addedTask.repeat,
              ),
            ),
            HorizontalSpacer(width: 12.w),
            Expanded(
              flex: 1,
              child: DropDownPicker(
                fieldTitle: priorityLabelText,
                color: state.addedTask.priorityColor.color,
                itemsList: [
                  PriorityColor(priority: PriorityType.critical),
                  PriorityColor(priority: PriorityType.high),
                  PriorityColor(priority: PriorityType.medium),
                  PriorityColor(priority: PriorityType.low),
                ],
                selectedValue: state.addedTask.priorityColor,
              ),
            ),
          ],
        );
      },
    );
  }
}
