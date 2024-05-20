import 'package:power_of_task/Features/tasks/presention/mangers/addTaskCubit/addTaskCubit.dart';
import 'package:power_of_task/Features/tasks/presention/views/widgets/categoryItem.dart';
import 'package:power_of_task/Features/tasks/presention/views/widgets/taskLastPart.dart';
import 'package:power_of_task/Features/tasks/presention/views/widgets/taskTextField.dart';
import 'package:power_of_task/constants.dart';
import 'package:power_of_task/core/utils/functions/appToast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class CreateNewTask extends StatefulWidget {
  const CreateNewTask({super.key});

  @override
  State<CreateNewTask> createState() => _CreateNewTaskState();
}

class _CreateNewTaskState extends State<CreateNewTask> {
  TextEditingController? titleController;
  TextEditingController? descriptionController;
  List categoryList = [
    {'text': 'Learning', 'color': Colors.greenAccent},
    {'text': 'Learning', 'color': Colors.blueAccent},
    {'text': 'General', 'color': Colors.amberAccent}
  ];
  @override
  void initState() {
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final addTaskCubit = context.read<AddTaskCubit>();
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom / 2),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              "New Task Todo",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
            ),
            Container(
              width: 70.w,
              height: 0.1.h,
              color: Colors.grey,
            ),
            SizedBox(
              height: 2.h,
            ),
            TaskTextField(
              onChange: (value) {
                addTaskCubit.canCreateTask(
                    titleController!, descriptionController!);
              },
              title: 'Title Task',
              controller: titleController,
              text: 'Add Task Name',
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              maxLines: 1,
              LabelSize: 12.sp,
              isUpdateTaskPage: false,
            ),
            SizedBox(
              height: 2.h,
            ),
            TaskTextField(
              onChange: (value) {
                addTaskCubit.canCreateTask(
                    titleController!, descriptionController!);
              },
              title: 'Description',
              controller: descriptionController,
              text: 'Add Description',
              floatingLabelBehavior: FloatingLabelBehavior.always,
              maxLines: 5,
              LabelSize: 15.sp,
              isUpdateTaskPage: false,
            ),
            SizedBox(
              height: 2.h,
            ),
            Row(
              children: [
                Text(
                  "Category",
                  style:
                      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 1.h,
            ),
            BlocBuilder<AddTaskCubit, AddTaskState>(
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(3, (index) {
                    return CategoryItem(
                      text: categoryList[index]['text'],
                      color: categoryList[index]['color'],
                      categoryId: addTaskCubit.categoryId,
                      Id: index,
                      onTap: () {
                        addTaskCubit.changeCategory(index);
                      },
                    );
                  }),
                );
              },
            ),

            SizedBox(
              height: 2.h,
            ),
            //
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlocBuilder<AddTaskCubit, AddTaskState>(
                  builder: (context, state) {
                    return TaskLastPart(
                      title: 'Date',
                      dateText: addTaskCubit.picked != null
                          ? "${addTaskCubit.picked!.year}-${addTaskCubit.picked!.month}-${addTaskCubit.picked!.day}"
                          : "dd/mm/yy",
                      buttonColor: Colors.white,
                      buttonText: 'Cancel',
                      buttonTextColor: kPrimaryColor,
                      icon: Icons.date_range_outlined,
                      dateOnTap: () {
                        addTaskCubit.pickDate(
                            titleController!, descriptionController!, context);
                      },
                      horizontalButton: 12.w,
                      onPressedButton: () {
                        addTaskCubit.cleanFromValue(
                            titleController!, descriptionController!);
                      },
                      isUpdateTaskPage: false,
                      canCreate: true,
                    );
                  },
                ),
                BlocListener<AddTaskCubit, AddTaskState>(
                  listener: (context, state) {
                    if (state is AddTaskSuccess) {
                      appToast(context, 'your task added');
                    } else if (state is AddTaskFailure) {
                      appToast(context, 'there are some problem');
                    }
                  },
                  child: BlocBuilder<AddTaskCubit, AddTaskState>(
                    builder: (context, state) {
                      return TaskLastPart(
                        title: 'Time',
                        dateText: addTaskCubit.timePicked != null
                            ? "${addTaskCubit.timePicked!.hour}:${addTaskCubit.timePicked!.minute}"
                            : "hh:mm",
                        buttonColor: addTaskCubit.canCreate
                            ? kPrimaryColor
                            : Colors.grey,
                        buttonText: 'Create',
                        buttonTextColor: Colors.white,
                        icon: Icons.watch_later_outlined,
                        dateOnTap: () {
                          addTaskCubit.pickTime(titleController!,
                              descriptionController!, context);
                        },
                        horizontalButton: 10.w,
                        onPressedButton: () {
                          addTaskCubit.addToDo({
                            'todo': descriptionController!.text,
                            'completed': false,
                            'userId': 5, //addTaskCubit.getUserId
                          }, context);
                          addTaskCubit.cleanFromValue(
                              titleController!, descriptionController!);
                        },
                        isUpdateTaskPage: false,
                        canCreate: addTaskCubit.canCreate,
                      );
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
