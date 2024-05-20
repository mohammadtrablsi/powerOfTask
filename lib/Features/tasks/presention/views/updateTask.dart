import 'package:power_of_task/Features/tasks/data/repos/tasksRepoImp.dart';
import 'package:power_of_task/Features/tasks/domain/useCases/UpdateToDoUseCases.dart';
import 'package:power_of_task/Features/tasks/presention/views/widgets/updateTaskBody.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/functions/setup_service_locator.dart';
import '../mangers/updateTaskCubit/updateTaskCubit.dart';

class UpdateTask extends StatefulWidget {
  const UpdateTask({
    super.key,
    required this.title,
    required this.description,
    required this.initDate,
    required this.initTime,
    required this.index,
    required this.categoryId,
    required this.id,
  });

  final String title;
  final String description;
  final String initDate;
  final String initTime;
  final int index;
  final int categoryId;
  final int id;

  @override
  State<UpdateTask> createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late int categoryId;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.title);
    descriptionController = TextEditingController(text: widget.description);
    categoryId = widget.categoryId;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return UpdateTaskCubit(
          UpdateToDoUseCase(
            getIt.get<TasksRepoImpl>(),
          ),
        );
      },
      child: UpdateTaskBody(
        title: widget.title,
        description: widget.description,
        initDate: widget.initDate,
        initTime: widget.initTime,
        index: widget.index,
        categoryId: widget.categoryId,
        descriptionController: descriptionController,
        titleController: titleController,
        id: widget.id,
      ),
    );
  }
}
