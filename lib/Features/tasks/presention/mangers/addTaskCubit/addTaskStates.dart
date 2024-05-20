part of 'addTaskCubit.dart';

@immutable
abstract class AddTaskState {}

class AddTaskInitial extends AddTaskState {}

class AddTaskLoading extends AddTaskState {}

class AddTaskFailure extends AddTaskState {
  final String errMessage;

  AddTaskFailure(this.errMessage);
}

class AddTaskSuccess extends AddTaskState {}
class ChangeCategory extends AddTaskState {}
class ChooseTime extends AddTaskState {}
