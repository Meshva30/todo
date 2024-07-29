import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/todo_controller.dart';
import '../model/todo_model.dart';

class AddTaskDialog extends StatelessWidget {
  final TaskController taskController = Get.find();
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final RxInt priority = 1.obs;


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Task', style: TextStyle(color: Colors.black)),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: taskNameController,
              decoration: InputDecoration(
                  labelText: 'Task Name',
                  labelStyle: TextStyle(color: Colors.black)),
            ),
            TextField(
              controller: noteController,
              decoration: InputDecoration(
                  labelText: 'Note',
                  labelStyle: TextStyle(color: Colors.black)),
            ),
            SizedBox(height: 20),
            Obx(() {
              return ElevatedButton(
                onPressed: () async {
                  int? selectedPriority = await showDialog<int>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Select Priority'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Priority options
                            ListTile(
                              title: Text('Low Priority'),
                              onTap: () {
                                Navigator.pop(context, 1);
                              },
                            ),
                            ListTile(
                              title: Text('Medium Priority'),
                              onTap: () {
                                Navigator.pop(context, 2);
                              },
                            ),
                            ListTile(
                              title: Text('High Priority'),
                              onTap: () {
                                Navigator.pop(context, 3);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );

                  if (selectedPriority != null) {
                    priority.value = selectedPriority;
                  }
                },
                child: Text('Select Priority (Current: ${priority.value})'),
              );
            }),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            final newTask = Task(
              taskName: taskNameController.text,
              note: noteController.text,
              priority: priority.value,
            );

            taskController.addTask(newTask);

            Get.back();
          },
          child: Text('Add Task'),
        ),
      ],
    );
  }
}

void showAddTaskDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AddTaskDialog();
    },
  );
}
