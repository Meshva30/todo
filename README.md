# todo_database

Sure! Here's a step-by-step outline to guide you in creating a ToDo app with CRUD operations using the `sqflite` package in Flutter:

### Step 1: Project Setup
1. **Create a new Flutter project**:
   - Open your terminal or command prompt.
   - Run the following command to create a new Flutter project:
     ```bash
     flutter create todo_app
     ```
   - Navigate to the project directory:
     ```bash
     cd todo_app
     ```

2. **Add Dependencies**:
   - Open the `pubspec.yaml` file.
   - Add `sqflite` and `path` packages to your dependencies:
     ```yaml
     dependencies:
       flutter:
         sdk: flutter
       sqflite: ^2.0.0+4
       path: ^1.8.0
     ```
   - Save the file and run:
     ```bash
     flutter pub get
     ```

### Step 2: Setting Up the Database
1. **Create a Database Helper Class**:
   - Create a new file in the `lib` directory, e.g., `database_helper.dart`.
   - This class will handle all database operations (CRUD).

### Step 3: Creating Models
1. **Create a ToDo Model**:
   - Create a new file in the `lib` directory, e.g., `todo_model.dart`.
   - This model will represent the ToDo item.

### Step 4: CRUD Operations
1. **Insert a ToDo Item**:
   - Implement the method to add a new ToDo item to the database.

2. **Retrieve ToDo Items**:
   - Implement the method to fetch all ToDo items from the database.

3. **Update a ToDo Item**:
   - Implement the method to update an existing ToDo item.

4. **Delete a ToDo Item**:
   - Implement the method to delete a ToDo item from the database.

### Step 5: User Interface
1. **Create the UI for the ToDo App**:
   - Design the main screen where the list of ToDo items will be displayed.
   - Implement the UI to add a new ToDo item.
   - Implement the UI to edit and delete a ToDo item.

### Step 6: Connecting UI to Database
1. **Integrate Database Operations with UI**:
   - Fetch the ToDo items from the database and display them in the UI.
   - Add functionality to insert, update, and delete ToDo items through the UI.

### Step 7: Testing
1. **Test the App**:
   - Run your Flutter app on an emulator or a physical device.
   - Ensure that all CRUD operations work as expected.

### Summary of Steps:
1. **Project Setup**:
   - Create Flutter project.
   - Add `sqflite` and `path` dependencies.

2. **Database Setup**:
   - Create a database helper class.

3. **Model Creation**:
   - Create a ToDo model.

4. **Implement CRUD Operations**:
   - Insert, retrieve, update, and delete ToDo items.

5. **UI Development**:
   - Design the main UI.
   - Add, edit, and delete ToDo items.

6. **Integration**:
   - Connect UI with database operations.

7. **Testing**:
   - Test the application for proper functionality.

### Database Helper

Create a `database_helper.dart` file to manage the database operations:

```dart
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

```


### Video 
https://github.com/user-attachments/assets/363f792c-342a-4759-bd3b-c23975de3c71

