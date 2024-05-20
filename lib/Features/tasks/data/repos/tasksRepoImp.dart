import 'package:dartz/dartz.dart';

import 'package:power_of_task/core/errors/failure.dart';

import 'package:dio/dio.dart';

import '../../domain/entites/taskEntity.dart';
import '../../domain/repos/tasksRepo.dart';
import '../dataSources/tasksLocalDataSource.dart';
import '../dataSources/tasksRemoteDataSource.dart';

class TasksRepoImpl extends TasksRepo {
  final TasksRemoteDataSource tasksRemoteDataSource;
  final TasksLocalDataSource tasksLocalDataSource;

  TasksRepoImpl(
      {required this.tasksRemoteDataSource,
      required this.tasksLocalDataSource});
  @override
  Future<Either<Failure, TaskEntity>> addToDo(
      {required Map<String, dynamic> data}) async {
    TaskEntity task;
    try {
      task = await tasksRemoteDataSource.addToDo(data);
      return right(task);
    } catch (e) {
      if (e is DioError) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TaskEntity>> updateToDo(
      {required Map<String, dynamic> data}) async {
    TaskEntity task;
    try {
      task = await tasksRemoteDataSource.addToDo(data);
      return right(task);
    } catch (e) {
      if (e is DioError) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TaskEntity>> deleteToDo(int? id) async {
    TaskEntity task;
    try {
      task = await tasksRemoteDataSource.deleteToDo(id);
      return right(task);
    } catch (e) {
      if (e is DioError) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TaskEntity>>> getAllTasks(
      {required Map<String, dynamic> page}) async {
    List<TaskEntity> taskList;
    try {
      taskList = tasksLocalDataSource.getAllTasks(
        pageNumber: page['pageNumber'],
      );
      if (taskList.isNotEmpty) {
        return right(taskList);
      }
      taskList = await tasksRemoteDataSource.getAllTasks(page);
      print('temooooooooooooooooooooooooooooooooooooo$taskList');
      return right(taskList);
    } catch (e) {
      if (e is DioError) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
