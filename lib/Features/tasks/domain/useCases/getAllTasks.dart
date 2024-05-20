import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/use_cases/use_case.dart';
import '../entites/taskEntity.dart';
import '../repos/tasksRepo.dart';

class GetAllTasksUseCase
    extends UseCase<List<TaskEntity>, Map<String, dynamic>> {
  final TasksRepo tasksRepo;

  GetAllTasksUseCase(this.tasksRepo);

  @override
  Future<Either<Failure, List<TaskEntity>>> call(
      [Map<String, dynamic> param = const {}]) async {
    return await tasksRepo.getAllTasks(
      page: param,
    );
  }
}
