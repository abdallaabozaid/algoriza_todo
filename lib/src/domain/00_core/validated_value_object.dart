import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/src/domain/00_core/errors.dart';
import 'package:todo_app/src/domain/00_core/value_fauilure.dart';

abstract class ValidatedValueObject<T> extends Equatable {
  Either<ValueFailure<T>, T> get value;

  bool isValid() => value.isRight();

  T getOrCrash() {
    /* why get or crash the app >> cause this situation should never happen .
     coz you are making a gaurd that the value isnt a failure before using it */
    return value.fold(
      (failure) => throw UnexpectedValueError(failure),
      id,
      // id >> dart shortcut for >> (r)=>r; >> which means returning the right value .
    );
  }

  @override
  List<Object?> get props => [value];

  @override
  String toString() => 'Value($value)';
}
