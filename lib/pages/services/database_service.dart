import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  // here we are using singleton pattern
  static final DatabaseService instance = DatabaseService._constructor();

  final String _taskTableName = "tasks";

  DatabaseService._constructor();

  Future<Database> getDatabase() async {
    // getting database path for different platforms
    final databaseDirPath = await getDatabasesPath();
    // creating name for db  and joining the path
    final databasePath = join(databaseDirPath, "master_db.db");
    // using sqflite opening up db
    // currently we don't have scheme and the tables
    final database = await openDatabase(
        databasePath,
      onCreate: (db, version) {
          db.execute('''
          CREATE TABLE $_taskTableName
          $_taskTableName INTEGER PRIMARY KEY,
          ''')
      },
    );
  }
}
