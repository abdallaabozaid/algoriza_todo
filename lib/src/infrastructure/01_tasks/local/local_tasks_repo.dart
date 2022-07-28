import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:todo_app/src/domain/01_tasks/i_tasks_repo.dart';
import 'package:todo_app/src/domain/01_tasks/task_entity.dart';
import 'package:todo_app/src/domain/01_tasks/value_failures.dart';
import 'package:todo_app/src/infrastructure/01_tasks/local/tasks_database.dart';

class LocalTasksRepo extends ITasksRepo {
  @override
  Future<List<ToDoTask>> getAllTasks() async {
    return await TasksDatabase.instance.readAllNotes();
  }

  @override
  Future<Either<AddTaskFailure, Unit>> addTask({
    required ToDoTask addedTask,
  }) async {
    try {
      await TasksDatabase.instance.saveTasktoDb(
          task: addedTask.copyWith(
        id: Random().nextInt(99999),
      ));

      return right(unit);
    } catch (e) {
      return left(AddTaskFailure(failedValue: 'Can\'t add task'));
    }
  }

  @override
  Future<void> changeTaskCompeletionStatus({
    required bool isCompleted,
    required int taskId,
  }) async {
    final updatedTask = await TasksDatabase.instance.readTask(taskId: taskId);
    updatedTask!.compeletionStatus.setCompeletionStatus(isCompleted);

    await TasksDatabase.instance.update(updatedTask);
  }

  @override
  Future<void> changeTaskFavoriteStatus({
    required bool isFavorite,
    required int taskId,
  }) async {
    final updatedTask = await TasksDatabase.instance.readTask(taskId: taskId);
    updatedTask!.favoriteStatus.setFavoriteStatus(isFavorite);
    await TasksDatabase.instance.update(updatedTask);
  }

  @override
  Future<List<ToDoTask>> removeTask({required ToDoTask removedTask}) async {
    TasksDatabase.instance.delete(removedTask.id);
    return await getAllTasks();
  }

  @override
  Future<List<ToDoTask>> getTasksByDate({
    required DateTime date,
  }) async {
    final savedTasks = await getAllTasks();

    final scheduledTasks = savedTasks
        .where(
          (element) =>
              element.date.date.day == date.day &&
              element.date.date.month == date.month &&
              element.date.date.year == date.year,
        )
        .toList();

    return scheduledTasks;
  }
}
