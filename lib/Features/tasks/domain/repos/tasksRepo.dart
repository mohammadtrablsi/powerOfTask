import 'package:power_of_task/core/errors/failure.dart';
import 'package:dartz/dartz.dart';

import '../entites/taskEntity.dart';

abstract class TasksRepo {
  Future<Either<Failure, TaskEntity>> addToDo(
      {required Map<String, dynamic> data});
  Future<Either<Failure, TaskEntity>> updateToDo(
      {required Map<String, dynamic> data});
  Future<Either<Failure, List<TaskEntity>>> getAllTasks(
      {required Map<String, dynamic> page});
  Future<Either<Failure, TaskEntity>> deleteToDo(int? id);
}
