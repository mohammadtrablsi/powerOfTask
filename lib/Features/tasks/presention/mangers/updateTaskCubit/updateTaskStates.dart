part of 'updateTaskCubit.dart';

@immutable
abstract class UpdateTaskState {}

class UpdateTaskInitial extends UpdateTaskState {}



class UpdateTaskFailure extends UpdateTaskState {
  final String errMessage;

  UpdateTaskFailure(this.errMessage);
}

class UpdateTaskSuccess extends UpdateTaskState {}

