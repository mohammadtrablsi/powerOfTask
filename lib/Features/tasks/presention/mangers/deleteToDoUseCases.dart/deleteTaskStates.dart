part of 'deleteTaskCubit.dart';

@immutable
abstract class DeleteTaskState {}

class DeleteTaskInitial extends DeleteTaskState {}

class DeleteTaskFailure extends DeleteTaskState {
  final String errMessage;

  DeleteTaskFailure(this.errMessage);
}

class DeleteTaskSuccess extends DeleteTaskState {}
