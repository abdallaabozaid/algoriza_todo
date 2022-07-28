import 'package:todo_app/src/domain/00_core/value_fauilure.dart';

class InvalidTaskTitle extends ValueFailure<String> {
  InvalidTaskTitle({required String failedValue})
      : super(failedValue: failedValue);
}

class AddTaskFailure extends ValueFailure<String> {
  AddTaskFailure({required String failedValue})
      : super(failedValue: failedValue);
}

class ChooseTimeFailure extends ValueFailure<String> {
  ChooseTimeFailure({required String failedValue})
      : super(failedValue: failedValue);
}
