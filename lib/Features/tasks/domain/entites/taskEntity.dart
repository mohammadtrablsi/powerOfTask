import 'package:hive/hive.dart';

part 'taskEntity.g.dart';

@HiveType(typeId: 0)
class TaskEntity {
  @HiveField(0)
  final int id;

  @HiveField(1)
  bool completed;

  @HiveField(2)
  final String toDo;

  TaskEntity({required this.id, required this.completed, required this.toDo});
}
