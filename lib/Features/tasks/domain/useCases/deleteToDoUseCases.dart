import 'package:power_of_task/Features/tasks/domain/entites/taskEntity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/use_cases/use_case.dart';
import '../repos/tasksRepo.dart';

class DeleteToDoUseCase extends UseCase<TaskEntity, int?> {
  final TasksRepo tasksRepo;

  DeleteToDoUseCase(this.tasksRepo);

  @override
  Future<Either<Failure, TaskEntity>> call([int? param]) async {
    return await tasksRepo.deleteToDo(
      param,
    );
  }
}
