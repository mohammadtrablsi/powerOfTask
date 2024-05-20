import 'package:bloc/bloc.dart';
import 'package:power_of_task/Features/tasks/domain/useCases/AddToDoUseCases.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../constants.dart';

part 'addTaskStates.dart';

class AddTaskCubit extends Cubit<AddTaskState> {
  AddTaskCubit(this.addToDoUseCase) : super(AddTaskInitial());
  bool isPassword = true;
  int categoryId = 1;
  bool canCreate = false;
  DateTime selectedDate = DateTime.now();
  DateTime? picked;
  TimeOfDay selectedTime = TimeOfDay.now();
  TimeOfDay? timePicked;

  final AddToDoUseCase addToDoUseCase;
  Future<void> addToDo(Map<String, dynamic> data, BuildContext context) async {
    mangeStateOfPostData(data).then((value) async {
      context.pop();
    });
  }

  Future<void> mangeStateOfPostData(Map<String, dynamic> data) async {
    emit(AddTaskLoading());
    var result = await addToDoUseCase.call(data);
    print('resulttttttttttttttttttttttttttttttttttttttttt$result');
    result.fold((failure) {
      emit(AddTaskFailure(failure.message));
    }, (_) {
      emit(AddTaskSuccess());
    });
  }

  void changeCategory(int id) {
    categoryId = id;
    emit(ChangeCategory());
  }

  cleanFromValue(
    TextEditingController titleController,
    TextEditingController descriptionController,
  ) {
    titleController.clear();
    descriptionController.clear();
    categoryId = 1;
    picked = null;
    timePicked = null;
    canCreate = false;
  }

  canCreateTask(
    TextEditingController titleController,
    TextEditingController descriptionController,
  ) {
    if (descriptionController.text.isNotEmpty &&
        titleController.text.isNotEmpty &&
        picked != null &&
        timePicked != null) {
      canCreate = true;
    } else {
      canCreate = false;
    }
  }

  Future<int?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = await prefs.getInt('userId');
    return userId;
  }

  void pickDate(TextEditingController titleController,
      TextEditingController descriptionController, context) async {
    picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      helpText: 'Select a date',
      cancelText: 'Cancel',
      confirmText: 'OK',
      fieldLabelText: 'Date',
      errorFormatText: 'Enter valid date',
      errorInvalidText: 'Enter date in valid range',
      initialDatePickerMode: DatePickerMode.day,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: kPrimaryColor,
            hintColor: kPrimaryColor,
            colorScheme: const ColorScheme.light(primary: kPrimaryColor),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      selectedDate = picked!;
      emit(ChooseTime());
    }
    canCreateTask(titleController, descriptionController);
  }

  void pickTime(
    TextEditingController titleController,
    TextEditingController descriptionController,
    context,
  ) async {
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
    if (timePicked != null) {
      selectedTime != timePicked;
      emit(ChooseTime());
    }
    canCreateTask(titleController, descriptionController);
  }
}
