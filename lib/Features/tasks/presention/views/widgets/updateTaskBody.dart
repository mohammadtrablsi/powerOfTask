import 'package:power_of_task/Features/tasks/presention/mangers/updateTaskCubit/updateTaskCubit.dart';
import 'package:power_of_task/Features/tasks/presention/views/widgets/categoryItem.dart';
import 'package:power_of_task/Features/tasks/presention/views/widgets/taskLastPart.dart';
import 'package:power_of_task/Features/tasks/presention/views/widgets/taskTextField.dart';
import 'package:power_of_task/core/utils/functions/appToast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../../constants.dart';

// ignore: must_be_immutable
class UpdateTaskBody extends StatelessWidget {
  UpdateTaskBody(
      {super.key,
      required this.title,
      required this.description,
      required this.initDate,
      required this.initTime,
      required this.index,
      required this.categoryId,
      required this.titleController,
      required this.descriptionController,
      required this.id});
  final String title;
  final String description;
  final String initDate;
  final String initTime;
  final int index;
  final int categoryId;
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final int id;
  List categoryList = [
    {'text': 'Learning', 'color': Colors.greenAccent},
    {'text': 'Learning', 'color': Colors.blueAccent},
    {'text': 'General', 'color': Colors.amberAccent}
  ];

  @override
  Widget build(BuildContext context) {
    UpdateTaskCubit updateTaskCubit = BlocProvider.of<UpdateTaskCubit>(context);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 2.h),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_outlined),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              TaskTextField(
                title: 'Title Task',
                controller: titleController,
                text: 'Add Task Name',
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                maxLines: null,
                LabelSize: 12.sp,
                isUpdateTaskPage: true,
                fontSize: 20.sp,
                minLines: 1,
              ),
              SizedBox(height: 2.h),
              TaskTextField(
                title: 'Description',
                controller: descriptionController,
                text: 'Add Description',
                floatingLabelBehavior: FloatingLabelBehavior.always,
                maxLines: null,
                LabelSize: 15.sp,
                isUpdateTaskPage: true,
                fontSize: 16.sp,
                minLines: 3,
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  Text(
                    "Category",
                    style:
                        TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 1.h),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(3, (index) {
                    return CategoryItem(
                      text: categoryList[index]['text'],
                      color: categoryList[index]['color'],
                      categoryId: categoryId,
                      Id: index,
                      onTap: () {
                        updateTaskCubit.changeCategory(index, categoryId);
                      },
                    );
                  })),
              SizedBox(height: 2.h),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Divider(),
                  TaskLastPart(
                    title: 'Date',
                    dateText: updateTaskCubit.picked != null
                        ? "${updateTaskCubit.picked!.year}-${updateTaskCubit.picked!.month}-${updateTaskCubit.picked!.day}"
                        : initDate ?? " ",
                    buttonColor: Colors.white,
                    buttonText: 'Cancel',
                    buttonTextColor: kPrimaryColor,
                    icon: Icons.date_range_outlined,
                    dateOnTap: () {
                      updateTaskCubit.pickDate(context);
                    },
                    horizontalButton: 12.w,
                    onPressedButton: () {
                      Navigator.pop(context);
                    },
                    isUpdateTaskPage: true,
                    canCreate: true,
                  ),
                  const Divider(),
                  TaskLastPart(
                    title: 'Time',
                    dateText: updateTaskCubit.timePicked != null
                        ? "${updateTaskCubit.timePicked!.hour}:${updateTaskCubit.timePicked!.minute}"
                        : initTime ?? "",
                    buttonColor: kPrimaryColor,
                    buttonText: 'Create',
                    buttonTextColor: Colors.white,
                    icon: Icons.watch_later_outlined,
                    dateOnTap: () {
                      updateTaskCubit.pickTime(context);
                    },
                    horizontalButton: 10.w,
                    onPressedButton: () {},
                    isUpdateTaskPage: true,
                    canCreate: true,
                  ),
                  const Divider(),
                  SizedBox(height: 2.h),
                  BlocListener<UpdateTaskCubit, UpdateTaskState>(
                    listener: (contexto, state) {
                      if (State is UpdateTaskSuccess) {
                        appToast(contexto, 'the task updated successfuly');
                      } else if (State is UpdateTaskFailure) {
                        appToast(contexto, 'the task updated Faliure');
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            updateTaskCubit.mangeStateOfPostData(
                              {
                                'id': id,
                                'keyData': 'toDo',
                                'valueData': descriptionController.text
                              },
                            );
                          },
                          child: const Text(
                            "update the task",
                            style: TextStyle(color: kPrimaryColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
