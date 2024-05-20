import 'package:bloc/bloc.dart';
import 'package:power_of_task/Features/tasks/domain/useCases/deleteToDoUseCases.dart';

import 'package:flutter/material.dart';

part 'deleteTaskStates.dart';

class DeleteTaskCubit extends Cubit<DeleteTaskState> {
  DeleteTaskCubit(this.deleteToDoUseCase) : super(DeleteTaskInitial());

  final DeleteToDoUseCase deleteToDoUseCase;
  Future<void> deleteToDo(int id, BuildContext context) async {
    mangeStateOfPostData(id);
  }

  Future<void> mangeStateOfPostData(int id) async {
    var result = await deleteToDoUseCase.call(id);
    print('resulttttttttttttttttttttttttttttttttttttttttt$result');
    result.fold((failure) {
      emit(DeleteTaskFailure(failure.message));
    }, (_) {
      emit(DeleteTaskSuccess());
    });
  }
}
