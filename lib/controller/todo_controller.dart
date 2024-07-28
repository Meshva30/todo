import 'package:get/get.dart';
import '../helper/db_helper.dart';
import '../model/todo_model.dart';

class TaskController extends GetxController {
  var tasks = <Task>[].obs;
  final DBHelper dbHelper = DBHelper();

  @override
  void onInit() {
    super.onInit();
    fetchTasks();
  }

  void fetchTasks() async {
    tasks.value = await dbHelper.fetchTasks();
  }

  void addTask(Task task) async {
    await dbHelper.insertTask(task);
    fetchTasks();
  }

  void updateTask(Task task) async {
    await dbHelper.updateTask(task);
    fetchTasks();
  }

  void deleteTask(int id) async {
    await dbHelper.deleteTask(id);
    fetchTasks();
  }
}
