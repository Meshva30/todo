import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/todo_controller.dart';
import 'model/todo_model.dart';

class EditTaskDialog extends StatelessWidget {
  final Task task;
  final TextEditingController taskNameController;
  final TextEditingController noteController;
  final RxInt priority;

  EditTaskDialog({required this.task})
      : taskNameController = TextEditingController(text: task.taskName),
        noteController = TextEditingController(text: task.note),
        priority = task.priority.obs;

  @override
  Widget build(BuildContext context) {
    final TaskController taskController = Get.find();

    return AlertDialog(
      title: Text('Edit Task'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: taskNameController,
              decoration: InputDecoration(labelText: 'Task Name'),
            ),
            TextField(
              controller: noteController,
              decoration: InputDecoration(labelText: 'Note'),
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
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            task.taskName = taskNameController.text;
            task.note = noteController.text;
            task.priority = priority.value;
            taskController.updateTask(task);
            Navigator.pop(context);
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}
