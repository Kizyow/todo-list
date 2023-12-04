import 'package:flutter/material.dart';
import 'package:todo_list_v1/screens/task.dart';

class TaskDetails extends StatefulWidget {
  final Task task;

  const TaskDetails({super.key, required this.task});

  @override
  State<StatefulWidget> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Task Details"),
      ),
      body: Form(
          child: Column(
        children: [
          TextFormField(
              initialValue: widget.task.title,
              decoration: const InputDecoration(hintText: "Task Title")),
          TextFormField(
              initialValue: widget.task.content,
              decoration: const InputDecoration(hintText: "Task Content")),
          CheckboxListTile(
            value: widget.task.completed,
            title: const Text("Completed:"),
            onChanged: (value) {},
          )
        ],
      )),
    );
  }
}
