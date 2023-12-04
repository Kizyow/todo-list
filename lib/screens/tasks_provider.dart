import 'package:flutter/cupertino.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_list_v1/screens/task.dart';

class TasksProvider extends ChangeNotifier {
  void toggleComplete(Task task) async {
    await Supabase.instance.client.from('todo').update({
      'completed': !task.completed,
    }).eq('id', task.id);
    notifyListeners();
  }

  void add(Task task) async {
    await Supabase.instance.client.from('todo').insert({
      'title': task.title,
      'content': task.content,
      'completed': task.completed,
    });
  }

  Future<void> remove(Task task) async {
    await Supabase.instance.client.from('todo').delete().eq('id', task.id);
    notifyListeners();
  }

  void removeAll() async {
    await Supabase.instance.client.from('todo').delete().neq('id', 0);
    notifyListeners();
  }
}
