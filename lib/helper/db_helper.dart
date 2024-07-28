import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/todo_model.dart';

class DBHelper {
  static Database? _db;
  static const String DB_NAME = 'tasks.db';
  static const String TABLE_NAME = 'tasks';

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await initDB();
    return _db!;
  }

  initDB() async {
    String path = join(await getDatabasesPath(), DB_NAME);
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $TABLE_NAME (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            taskName TEXT NOT NULL,
            isDone INTEGER NOT NULL,
            note TEXT,
            priority INTEGER NOT NULL,
            likes INTEGER NOT NULL
          )
        ''');
      },
    );
  }

  Future<int> insertTask(Task task) async {
    var dbClient = await db;
    return await dbClient.insert(TABLE_NAME, task.toMap());
  }

  Future<int> updateTask(Task task) async {
    var dbClient = await db;
    return await dbClient.update(TABLE_NAME, task.toMap(),
        where: 'id = ?', whereArgs: [task.id]);
  }

  Future<int> deleteTask(int id) async {
    var dbClient = await db;
    return await dbClient.delete(TABLE_NAME,
        where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Task>> fetchTasks() async {
    var dbClient = await db;
    List<Map<String, dynamic>> maps = await dbClient.query(TABLE_NAME);
    return List.generate(maps.length, (i) {
      return Task.fromMap(maps[i]);
    });
  }
}
