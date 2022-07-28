import 'package:todo_app/src/domain/01_tasks/value_objects.dart';

abstract class ValueFailure<T> {
  final String failedValue;
  ValueFailure({
    required this.failedValue,
  });
}
