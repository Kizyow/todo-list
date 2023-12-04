import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sup;
import 'package:todo_list_v1/screens/task.dart';
import 'package:todo_list_v1/screens/task_form.dart';
import 'package:todo_list_v1/screens/tasks_details.dart';
import 'package:todo_list_v1/screens/tasks_provider.dart';

class TasksMaster extends StatefulWidget {
  const TasksMaster({super.key});

  @override
  State<StatefulWidget> createState() => _TaskMasterState();
}

class _TaskMasterState extends State<TasksMaster> {
  final _todoStream =
      sup.Supabase.instance.client.from('todo').stream(primaryKey: ['id']);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('ToDo List'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const TaskForm()))
                .then((value) {
              if (value != null) {
                Provider.of<TasksProvider>(context, listen: false).add(value);
              }
            });
          },
          child: const Icon(Icons.add),
        ),
        body: StreamBuilder<List<Map<String, dynamic>>>(
          stream: _todoStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final todo = snapshot.data!;

            return ListView.builder(
                itemCount: todo.length,
                itemBuilder: (context, index) {
                  var data = todo[index];
                  Task task = Task(
                      content: data['content'],
                      completed: data['completed'],
                      title: data['title'],
                      id: data['id']);
                  return TaskPreview(task: task);
                });
          },
        ));
  }
}

class TaskPreview extends StatelessWidget {
  const TaskPreview({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("${task.title}"),
      subtitle: Text(task.content),
      leading: Icon(
        task.completed ? Icons.check : Icons.close,
        size: 40.0,
        color: task.completed ? Colors.green[900] : Colors.red[900],
      ),
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => TaskDetails(task: task)));
      },
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(task.completed
                ? Icons.check_box
                : Icons.check_box_outline_blank),
            onPressed: () => Provider.of<TasksProvider>(context, listen: false)
                .toggleComplete(task),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              Provider.of<TasksProvider>(context, listen: false).remove(task);
            },
          ),
        ],
      ),
    );
  }
}
