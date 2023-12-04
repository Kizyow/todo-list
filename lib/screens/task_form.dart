import 'package:flutter/material.dart';
import 'package:todo_list_v1/screens/task.dart';

class TaskForm extends StatefulWidget {
  const TaskForm({super.key});

  @override
  State<StatefulWidget> createState() => TaskFormState();
}

class TaskFormState extends State<TaskForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  bool completed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Task"),
      ),
      body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(hintText: "Task Title"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter your task title";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: contentController,
                decoration: const InputDecoration(hintText: "Task Content"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter your task content";
                  }
                  return null;
                },
              ),
              CheckboxListTile(
                value: completed,
                title: const Text("Completed:"),
                onChanged: (value) {
                  setState(() {
                    completed = value!;
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Task task = Task(title: titleController.text, content: contentController.text, completed: completed);
                      Navigator.pop(context, task);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('New task created successfully!'),
                      ));
                    }
                  },
                  child: const Text('Submit'),
                ),
              )
            ],
          )),
    );
  }
}
