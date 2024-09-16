import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_project/models/task.dart';

class DatabaseService {
  // here we are using singleton pattern
  static Database? _db;
  static final DatabaseService instance = DatabaseService._constructor();

  final String _tasksTableName = "tasks";
  final String _tasksIdColumnName = "id";
  final String _tasksContentColumnName = "content";
  final String _tasksStatusColumnName = "status";

  DatabaseService._constructor();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    // getting database path for different platforms
    final databaseDirPath = await getDatabasesPath();
    // creating name for db  and joining the path
    final databasePath = join(databaseDirPath, "master_db.db");
    //await deleteDatabase(databasePath);
    // using sqfLite opening up db
    // currently we don't have scheme and the tables
    final database = await openDatabase(
      databasePath,
      version: 3,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE $_tasksTableName(
          $_tasksIdColumnName INTEGER PRIMARY KEY,
          $_tasksContentColumnName TEXT NOT NULL,
          $_tasksStatusColumnName INTEGER NOT NULL
          )
          ''');
      },
    );
    return database;
  }

  void addTask(String content) async {
    final db = await database;
    await db.insert(_tasksTableName, {
      _tasksContentColumnName: content,
      _tasksStatusColumnName: 0,
    });
  }

  Future<List<Task>> getTasks() async{
    final db = await database;
    final data = await db.query(_tasksTableName);
    List<Task> tasks = data.map((e) => Task(id: e["id"] as int, status: e["status"] as int, content: e["content"] as String)).toList();
    return tasks;
  }

  void updateTask(int id, int status) async{
    final db = await database;
    await db.update(
        _tasksTableName,
        {
          _tasksStatusColumnName: status,
        },
        where: 'id = ?',
      whereArgs: [
        id,
      ]
    );
  }
  
  void deleteTask(int id) async{
    final db = await database;
    await db.delete(_tasksTableName,
    where: 'id = ?',
      whereArgs: [
        id,
      ]
    );
  }
  
}
