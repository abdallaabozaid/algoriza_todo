import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/config/constants/text_const.dart';
import 'package:todo_app/config/enums.dart';
import 'package:todo_app/src/application/01_tasks_bloc/add_task/add_task_bloc.dart';
import 'package:todo_app/src/domain/01_tasks/value_objects.dart';
import 'package:todo_app/src/infrastructure/02_notification/local/notification_api.dart';
import 'package:todo_app/src/presentation/common_widgets/buttons/primary_button.dart';
import 'package:todo_app/src/presentation/common_widgets/spacers/vertical_spacer.dart';
import 'package:todo_app/src/presentation/core_widgets/app_common_commands.dart';
import 'package:todo_app/src/presentation/core_widgets/bloc_events.dart';
import 'package:todo_app/src/presentation/screens/00_common_widgets/app_bar.dart';
import 'package:todo_app/src/presentation/screens/00_common_widgets/go_back_icon.dart';
import 'package:todo_app/src/presentation/screens/02_add_task_screen/widgets/drop_down_picker.dart';
import 'package:todo_app/src/presentation/screens/02_add_task_screen/widgets/repeat_priority_fields.dart';
import 'package:todo_app/src/presentation/screens/02_add_task_screen/widgets/time_pickers.dart';
import 'package:todo_app/src/presentation/screens/00_common_widgets/app_form_field.dart';
import 'package:todo_app/src/presentation/screens/02_add_task_screen/widgets/picker_field.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => AppCommonCommands.dismissKeyBoard(context),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, 100.h),
          child: const CommonAppBar(
            titleText: addTaskAppBarText,
            borderSideWidth: 1,
            leadingIcon: GoBackIcon(),
          ),
        ),
        body: BlocBuilder<AddTaskBloc, AddTaskState>(
          builder: (context, state) {
            return SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Form(
                autovalidateMode: state.showErrors
                    ? AutovalidateMode.always
                    : AutovalidateMode.disabled,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 28.w, vertical: 20.h),
                  child: Column(
                    children: [
                      // task title field

                      CommonTextField(
                        fieldTitle: titleText,
                        hintText: taskTitleHintText,
                        onChanged: _onChanged,
                        validator: _validator,
                      ),

                      // task Date field

                      PickerField(
                        fieldTitle: dateText,
                        fieldHintText: state.addedTask.date.value,
                        icon: Icons.keyboard_arrow_down_rounded,
                        onPressed: () => _selectDate(),
                        showError: false,
                      ),

                      // task start time and end time fields

                      const TimePickers(),
                      VerticalSpacer(height: 20.h),

                      // task Remind field

                      DropDownPicker(
                        fieldTitle: reminderLabelText,
                        itemsList: [
                          Reminder(reminderType: ReminderType.tenMins),
                          Reminder(reminderType: ReminderType.twentyMins),
                          Reminder(reminderType: ReminderType.oneHour)
                        ],
                        selectedValue: state.addedTask.reminder,
                      ),
                      VerticalSpacer(height: 20.h),

                      // task Repeat field and priority color field

                      const RepeatPriorityFields(),
                      VerticalSpacer(height: 20.h),

                      // create task button

                      PrimaryButton(
                        onPressed: () => AppBlocEvents.addTask(
                          context,
                        ),
                        label: createTaskText,
                      ),

                      addTaskBlocListener(),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _onChanged(String value) {
    AppBlocEvents.changeTaskTitle(context, title: value);
  }

  Widget addTaskBlocListener() {
    return BlocListener<AddTaskBloc, AddTaskState>(
      child: Container(),
      listener: (context, state) {
        state.addingSuccessOrFailureOption.fold(
          () => null,
          (addingSuccessOrFailure) => addingSuccessOrFailure.fold(
            (failure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Container(
                    child: Text(failure.failedValue),
                    color: Colors.red,
                  ),
                ),
              );
            },
            (success) {
              AppBlocEvents.getAllTasks(context);
              NotificationApi.showNotificaton(
                title: 'Success !',
                body: 'Task Scheduled Successfully .',
              );
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }

  String? _validator(String? value) {
    return BlocProvider.of<AddTaskBloc>(context)
        .state
        .addedTask
        .title
        .value
        .fold(
          (l) => 'Task title can\'t be empty ',
          (r) => null,
        );
  }

  Future<void> _selectDate() async {
    final taskDate =
        BlocProvider.of<AddTaskBloc>(context).state.addedTask.date.value;
    final parsedTaskDate = DateTime.parse(taskDate);
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: parsedTaskDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != parsedTaskDate) {
      AppBlocEvents.changeDate(context, date: picked);
    }
  }
}
