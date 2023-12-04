class Task {
  int? id;
  String content;
  bool completed;
  String? title;

  Task(
      {this.id,
      required this.content,
      required this.completed,
      this.title});
}
