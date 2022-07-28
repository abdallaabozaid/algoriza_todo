import 'package:dartz/dartz.dart';
import 'package:todo_app/src/domain/01_tasks/task_entity.dart';
import 'package:todo_app/src/domain/01_tasks/value_failures.dart';

abstract class ITasksRepo {
  Future<List<ToDoTask>> getAllTasks();

  Future<List<ToDoTask>> getTasksByDate({
    required DateTime date,
  });

  Future<Either<AddTaskFailure, Unit>> addTask({
    required ToDoTask addedTask,
  });

  Future<List<ToDoTask>> removeTask({
    required ToDoTask removedTask,
  });

  Future<void> changeTaskFavoriteStatus({
    required bool isFavorite,
    required int taskId,
  });

  Future<void> changeTaskCompeletionStatus({
    required bool isCompleted,
    required int taskId,
  });
}
