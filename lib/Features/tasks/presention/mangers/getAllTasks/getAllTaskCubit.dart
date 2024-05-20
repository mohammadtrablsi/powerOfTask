import 'package:bloc/bloc.dart';

import 'package:flutter/material.dart';

import '../../../domain/entites/taskEntity.dart';
import '../../../domain/useCases/getAllTasks.dart';

part 'getAllTaskStates.dart';

class GetAllTasksCubit extends Cubit<GetAllTasksState> {
  GetAllTasksCubit(this.getAllTasksUseCase) : super(GetAllTasksInitial());

  final GetAllTasksUseCase getAllTasksUseCase;
  Future<void> getAllTasks({Map<String, dynamic>? page}) async {
    page ??= {'limit': 10, 'pageNumber': 0};
    print('xxx');
    if (page['pageNumber'] == 0) {
      emit(GetAllTasksLoading());
    } else {
      emit(GetAllTasksPaginationLoading());
    }
    var result = await getAllTasksUseCase.call(page);
    result.fold((failure) {
      if (page!['pageNumber'] == 0) {
        emit(GetAllTasksFailure(failure.message));
      } else {
        emit(GetAllTasksPaginationFailure(failure.message));
      }
    }, (tasks) {
      emit(GetAllTasksSuccess(tasks));
    });
  }
}
