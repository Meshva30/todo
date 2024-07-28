import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'addtask.dart';
import 'controller/todo_controller.dart';
import 'editscreen.dart';
import 'model/todo_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TODO App',
      home: TaskListScreen(),
    );
  }
}

class TaskListScreen extends StatelessWidget {
  final TaskController taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: Icon(
          Icons.menu,
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          'TODO App',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Obx(() {
        if (taskController.tasks.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: taskController.tasks.length,
          itemBuilder: (context, index) {
            final task = taskController.tasks[index];
            return TaskCard(task: task);
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        shape: CircleBorder(),
        onPressed: () {
          Get.to(() => AddTaskScreen());
        },
        child: Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }
}

class TaskCard extends StatelessWidget {
  final Task task;

  TaskCard({required this.task});

  @override
  Widget build(BuildContext context) {
    final TaskController taskController = Get.find();

    return Card(
      color: getColorForPriority(task.priority),
      child: ListTile(
        title: Text(task.taskName),
        subtitle: Text(task.note),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return EditTaskDialog(task: task);
                  },
                );
              },
            ),
            Checkbox(
              value: task.isDone,
              onChanged: (bool? value) {
                task.isDone = value ?? false;
                taskController.updateTask(task);
              },
            ),
            IconButton(
              icon: Icon(Icons.delete,),
              onPressed: () {
                taskController.deleteTask(task.id!);
              },
            ),
          ],
        ),
      ),
    );
  }

  Color getColorForPriority(int priority) {
    switch (priority) {
      case 1:
        return Color(0xff6EACDA);
      case 2:
        return Color(0xff508D4E);
      case 3:
        return Color(0xffC8ACD6);
      default:
        return Colors.grey;
    }
  }
}
