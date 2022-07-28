import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/config/enums.dart';

import 'package:todo_app/src/domain/01_tasks/value_objects.dart';
import 'package:todo_app/src/presentation/common_widgets/spacers/vertical_spacer.dart';
import 'package:todo_app/src/presentation/core_widgets/bloc_events.dart';

class DropDownPicker extends StatelessWidget {
  const DropDownPicker({
    Key? key,
    required this.fieldTitle,
    required this.itemsList,
    required this.selectedValue,
    this.color,
  }) : super(key: key);
  final String fieldTitle;
  final List<MultpleTypes> itemsList;
  final Color? color;

  final MultpleTypes selectedValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          fieldTitle,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        VerticalSpacer(height: 8.h),
        Center(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 20.w),
            width: double.infinity,
            decoration: BoxDecoration(
              color: color ?? Colors.grey.shade200,
              borderRadius: BorderRadius.circular(22.r),
            ),
            child: DropdownButton<MultpleTypes>(
              value: selectedValue,
              onChanged: (value) {
                if (selectedValue.type is RepeatType) {
                  AppBlocEvents.changeTaskRepeat(
                    context,
                    type: value!.type as RepeatType,
                  );
                } else if (selectedValue.type is ReminderType) {
                  AppBlocEvents.changeTaskRemider(
                    context,
                    type: value!.type as ReminderType,
                  );
                } else {
                  AppBlocEvents.changeTaskPriority(
                    context,
                    type: value!.type as PriorityType,
                  );
                }
              },
              underline: Container(),
              dropdownColor: Colors.grey.shade400,
              icon: const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Colors.black,
              ),
              isExpanded: true,
              borderRadius: BorderRadius.circular(22.r),
              items: itemsList
                  .map((item) => DropdownMenuItem(
                        value: item,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            item.label,
                            style: color == null
                                ? Theme.of(context).textTheme.bodySmall!
                                : Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(color: Colors.white),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
