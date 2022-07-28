import 'package:todo_app/src/domain/00_core/value_fauilure.dart';

class UnexpectedValueError extends Error {
  final ValueFailure valueFailure;
  UnexpectedValueError(
    this.valueFailure,
  );

  @override
  String toString() {
    const String explanation =
        'Encoutered an Unexpected ValueError at unrecoverable point . Terminating .';
    return Error.safeToString('$explanation Failure was $valueFailure ');
  }
}
