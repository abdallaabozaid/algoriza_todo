import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/src/domain/01_tasks/task_entity.dart';

class TasksDatabase {
  static final instance = TasksDatabase._init();
  static const String tasksTable = 'tasksTable';
  static const String id = '_id';
  static const String title = 'taskTitle';
  static const String date = 'taskDate';
  static const String startTime = 'startTime';
  static const String endTime = 'endTime';
  static const String reminder = 'reminder';
  static const String repeat = 'repeat';
  static const String priority = 'priority';
  static const String favorite = 'favorite';
  static const String compeletion = 'compeletion';
  static const List<String> allFields = [
    id,
    title,
    date,
    startTime,
    endTime,
    reminder,
    repeat,
    priority,
    favorite,
    compeletion,
  ];

  TasksDatabase._init();

  static Database? _dataBase;

  Future<Database> get database async {
    if (_dataBase != null) {
      return _dataBase!;
    } else {
      _dataBase = await _initDb('tasks.db');
      return _dataBase!;
    }
  }

  Future<Database> _initDb(String filePath) async {
    final dbPath = await getDatabasesPath();

    final path = join(dbPath, filePath);
    final opedDbResults =
        await openDatabase(path, version: 1, onCreate: _onCreatDb);

    return opedDbResults;
  }

  FutureOr<void> _onCreatDb(Database db, int version) async {
    final String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final String textType = 'TEXT NOT NULL';
    final String integerType = 'INTEGER NOT NULL';
    final String boolType = 'BOOLEAN NOT NULL';

    await db.execute('''CREATE TABLE $tasksTable ( 
        $id $idType, 
        $title $textType, 
        $date $textType, 
        $startTime $textType,
        $endTime $textType,
        $reminder $integerType, 
        $repeat $integerType,
        $priority $integerType,
        $favorite $boolType,
        $compeletion $boolType
    ) ''');
  }

  Future<ToDoTask> saveTasktoDb({required ToDoTask task}) async {
    final dB = await instance.database;
    final id = await dB.insert(
      tasksTable,
      task.toMap(),
    );
    return task;
  }

  Future<ToDoTask?> readTask({required int taskId}) async {
    final dB = await instance.database;

    final maps = await dB.query(
      tasksTable,
      columns: allFields,
      where: '$id = ?',
      whereArgs: [taskId],
    );
    if (maps.isNotEmpty) {
      return ToDoTask.fromMap(maps.first);
    }
    return null;
  }

  Future<List<ToDoTask>> readAllNotes() async {
    final db = await instance.database;

    final result = await db.query(tasksTable);

    return result.map((json) => ToDoTask.fromMap(json)).toList();
  }

  Future<int> update(ToDoTask task) async {
    final dB = await instance.database;

    return await dB.update(
      tasksTable,
      task.toMap(),
      where: '$id = ?',
      whereArgs: [task.id],
    );
  }

  Future<int> delete(int taskId) async {
    final db = await instance.database;
    return await db.delete(
      tasksTable,
      where: '$id = ?',
      whereArgs: [taskId],
    );
  }

  Future<void> closeDb() async {
    final db = await instance.database;

    db.close();
  }
}
