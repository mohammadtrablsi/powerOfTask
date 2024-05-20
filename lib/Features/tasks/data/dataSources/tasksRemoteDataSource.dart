import 'package:power_of_task/Features/tasks/data/models/taskModel.dart';
import 'package:power_of_task/constants.dart';
import 'package:power_of_task/core/utils/api_service.dart';
import 'package:power_of_task/core/utils/functions/save_tasks.dart';

import '../../domain/entites/taskEntity.dart';

abstract class TasksRemoteDataSource {
  Future<TaskEntity> addToDo(Map<String, dynamic> request);
  Future<List<TaskEntity>> getAllTasks(Map<String, dynamic> page);
  Future<TaskEntity> updateToDo(Map<String, dynamic> request);
  Future<TaskEntity> deleteToDo(int? id);
}

class TasksRemoteDataSourceImpl extends TasksRemoteDataSource {
  final ApiService apiService;

  TasksRemoteDataSourceImpl(this.apiService);
  @override
  Future<TaskEntity> addToDo(Map<String, dynamic> request) async {
    var data = await apiService.post(
        data: request, endPoint: 'https://dummyjson.com/todos/add');
    TaskEntity task = TaskModel.fromJson(data);
    print("iddddddddddddddddddddddddddddddddddd${task.toDo}");
    // saveTasksData([task], kTasksBox);
    return task;
  }

  @override
  Future<List<TaskEntity>> getAllTasks(Map<String, dynamic> page) async {
    var data = await apiService.get(
        endPoint:
            'https://dummyjson.com/todos?limit=${page['limit']}&skip=${page['pageNumber'] * 10}');
    print('dataaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa1$data');
    List<TaskEntity> tasks = getTasksList(data);
    saveTasksData(tasks, kTasksBox);
    return tasks;
  }

  @override
  Future<TaskEntity> updateToDo(Map<String, dynamic> request) async {
    print('reqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq$request');
    var data = await apiService.put(
        data: {'completed': false}, endPoint: 'https://dummyjson.com/todos/1');
    TaskEntity task = TaskModel.fromJson(data);
    return task;
  }

  @override
  Future<TaskEntity> deleteToDo(int? id) async {
    var data =
        await apiService.delete(endPoint: 'https://dummyjson.com/todos/$id');
    TaskEntity task = TaskModel.fromJson(data);
    print("iddddddddddddddddddddddddddddddddddd${task.toDo}");
    return task;
  }

  List<TaskEntity> getTasksList(Map<String, dynamic> data) {
    List<TaskEntity> tasks = [];
    for (var taskMap in data['todos']) {
      tasks.add(TaskModel.fromJson(taskMap));
    }
    return tasks;
  }
}
