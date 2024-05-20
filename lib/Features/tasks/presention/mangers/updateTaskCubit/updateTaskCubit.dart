import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:power_of_task/Features/tasks/domain/useCases/UpdateToDoUseCases.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../../../constants.dart';
import '../../../domain/entites/taskEntity.dart';

part 'updateTaskStates.dart';

class UpdateTaskCubit extends Cubit<UpdateTaskState> {
  UpdateTaskCubit(this.updateToDoUseCase) : super(UpdateTaskInitial());

  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  DateTime selectedDate = DateTime.now();
  DateTime? picked;
  TimeOfDay selectedTime = TimeOfDay.now();
  TimeOfDay? timePicked;

  List<TaskEntity> tasks = [];

  final UpdateToDoUseCase updateToDoUseCase;
  Future<void> updateToDo(
      Map<String, dynamic> data, BuildContext context, int index) async {
    checkTask(index);
    mangeStateOfPostData(data);
  }

  Future<void> mangeStateOfPostData(Map<String, dynamic> request) async {
    print("lllllllllllllllllllllllll${request['valueData']}  ${request['id']}");

    var headers = {'Content-Type': 'application/json'};
    var data = json.encode({'${request['keyData']}': request['valueData']});
    var dio = Dio();
    var response = await dio.request(
      "https://dummyjson.com/todos/${request['id']}",
      options: Options(
        method: 'PUT',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
      emit(UpdateTaskSuccess());
    } else {
      print(response.statusMessage);
      emit(UpdateTaskFailure(response.statusMessage!));
    }
  }

  void checkTask(index) {
    tasks[index].completed = !tasks[index].completed;
    emit(UpdateTaskInitial());
  }

  void changeCategory(Id, categoryId) {
    categoryId = Id;
    emit(UpdateTaskInitial());
  }

  void pickDate(context) async {
    picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      helpText: 'Select a date',
      cancelText: 'Cancel',
      confirmText: 'OK', // Optional confirm button text
      fieldLabelText: 'Date', // Optional field label text
      errorFormatText: 'Enter valid date', // Optional error format text
      errorInvalidText:
          'Enter date in valid range', // Optional error invalid text
      initialDatePickerMode: DatePickerMode.day, // Initial display mode
      // Customize the theme here
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: kPrimaryColor, // Header color
            hintColor: kPrimaryColor, // Selection color
            colorScheme: const ColorScheme.light(primary: kPrimaryColor),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked!;
      emit(UpdateTaskInitial());
    }
  }

  void pickTime(context) async {
    timePicked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(
            primarySwatch: Colors.lightBlue,
            hintColor: Colors.lightBlue,
          ),
          child: child!,
        );
      },
    );
    if (timePicked != null && timePicked != selectedTime) {
      selectedTime != timePicked;
      emit(UpdateTaskInitial());
    }
  }
}
