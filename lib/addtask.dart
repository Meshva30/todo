
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/todo_controller.dart';
import 'model/todo_model.dart';

class AddTaskScreen extends StatelessWidget {
  // Controllers for task details and state management
  final TaskController taskController = Get.find();
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final RxInt priority = 1.obs; // Observable for priority

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Task')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Input field for task name
            TextField(
              controller: taskNameController,
              decoration: InputDecoration(labelText: 'Task Name'),
            ),
            // Input field for task note
            TextField(
              controller: noteController,
              decoration: InputDecoration(labelText: 'Note'),
            ),
            SizedBox(height: 20),
            // Priority selection button
            Obx(() {
              return ElevatedButton(
                onPressed: () async {
                  // Show a dialog to select priority
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
                  // Update priority if a valid option is selected
                  if (selectedPriority != null) {
                    priority.value = selectedPriority;
                  }
                },
                child: Text('Select Priority (Current: ${priority.value})'),
              );
            }),
            SizedBox(height: 20),
            // Add Task button
            ElevatedButton(
              onPressed: () {
                // Create a new task with the entered details
                final newTask = Task(
                  taskName: taskNameController.text,
                  note: noteController.text,
                  priority: priority.value,
                );
                // Add the new task to the list
                taskController.addTask(newTask);
                // Go back to the previous screen
                Get.back();
              },
              child: Text('Add Task'),
            ),
          ],
        ),
      ),
    );
  }
}
