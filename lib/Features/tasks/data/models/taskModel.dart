import 'package:power_of_task/Features/tasks/domain/entites/taskEntity.dart';

class TaskModel extends TaskEntity {
  int id;
  String todo;
  bool completed;
  int? userId;

  TaskModel(
      {required this.id,
      required this.todo,
      required this.completed,
      this.userId})
      : super(id: id, completed: completed, toDo: todo);

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        id: json['id'],
        todo: json['todo'],
        completed: json['completed'],
        userId: json['userId'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['todo'] = this.todo;
    data['completed'] = this.completed;
    data['userId'] = this.userId;
    return data;
  }
}
