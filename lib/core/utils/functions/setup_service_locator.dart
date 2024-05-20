import 'package:power_of_task/Features/tasks/data/repos/tasksRepoImp.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../../Features/Auth/data/dataSources/loginRemoteDataSource.dart';
import '../../../Features/Auth/data/repos/loginRepoImp.dart';
import '../../../Features/tasks/data/dataSources/tasksLocalDataSource.dart';
import '../../../Features/tasks/data/dataSources/tasksRemoteDataSource.dart';
import '../api_service.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<ApiService>(
    ApiService(
      Dio(),
    ),
  );

  getIt.registerSingleton<LoginRepoImpl>(
    LoginRepoImpl(
      loginRemoteDataSource: LoginRemoteDataSourceImpl(
        getIt.get<ApiService>(),
      ),
    ),
  );

  getIt.registerSingleton<TasksRepoImpl>(
    TasksRepoImpl(
      tasksRemoteDataSource: TasksRemoteDataSourceImpl(
        getIt.get<ApiService>(),
      ),
      tasksLocalDataSource: TasksLocalDataSourceImpl(),
    ),
  );
}
