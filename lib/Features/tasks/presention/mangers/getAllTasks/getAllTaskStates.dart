part of 'getAllTaskCubit.dart';

@immutable
abstract class GetAllTasksState {}

class GetAllTasksInitial extends GetAllTasksState {}

class GetAllTasksLoading extends GetAllTasksState {}

class GetAllTasksPaginationLoading extends GetAllTasksState {}

class GetAllTasksPaginationFailure extends GetAllTasksState {
  final String errMessage;

  GetAllTasksPaginationFailure(this.errMessage);
}

class GetAllTasksFailure extends GetAllTasksState {
  final String errMessage;

  GetAllTasksFailure(this.errMessage);
}

class GetAllTasksSuccess extends GetAllTasksState {
  final List<TaskEntity> tasks;

  GetAllTasksSuccess(this.tasks);
}
