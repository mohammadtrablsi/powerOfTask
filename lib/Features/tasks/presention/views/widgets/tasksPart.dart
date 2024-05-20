import 'package:power_of_task/Features/tasks/presention/mangers/getAllTasks/getAllTaskCubit.dart';
import 'package:power_of_task/Features/tasks/presention/views/widgets/taskItem.dart';
import 'package:power_of_task/core/utils/functions/appToast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/utils/app_router.dart';
import '../../../../../core/utils/functions/build_error_snack_bar.dart';
import '../../mangers/deleteToDoUseCases.dart/deleteTaskCubit.dart';
import '../../mangers/updateTaskCubit/updateTaskCubit.dart';

class TasksPart extends StatefulWidget {
  const TasksPart({super.key});

  @override
  State<TasksPart> createState() => _TasksPartState();
}

class _TasksPartState extends State<TasksPart> {
  late final ScrollController _scrollController;

  var nextPage = 1;

  var isLoading = false;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() async {
    var currentPositions = _scrollController.position.pixels;
    var maxScrollLength = _scrollController.position.maxScrollExtent;
    if (currentPositions >= 0.7 * maxScrollLength) {
      if (!isLoading) {
        isLoading = true;
        await BlocProvider.of<GetAllTasksCubit>(context)
            .getAllTasks(page: {'limit': 10, 'pageNumber': nextPage++});
        isLoading = false;
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UpdateTaskCubit updateTaskCubit = BlocProvider.of<UpdateTaskCubit>(context);
    DeleteTaskCubit deleteTaskCubit = BlocProvider.of<DeleteTaskCubit>(context);
    return BlocConsumer<GetAllTasksCubit, GetAllTasksState>(
      listener: (context, state) {
        if (state is GetAllTasksSuccess) {
          updateTaskCubit.tasks.addAll(state.tasks);
          print(
              'StaTEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE${state.tasks}');
        }

        if (state is GetAllTasksPaginationFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            buildErrorWidget(state.errMessage),
          );
        }
      },
      builder: (context, state) {
        if (state is GetAllTasksSuccess ||
            state is GetAllTasksPaginationLoading ||
            state is GetAllTasksPaginationFailure) {
          return SizedBox(
            height: 70.h,
            child: ListView.separated(
              controller: _scrollController,
              itemCount: updateTaskCubit.tasks.length,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return BlocListener<DeleteTaskCubit, DeleteTaskState>(
                  listener: (context, state) {
                    if (state is DeleteTaskSuccess) {
                      appToast(context, 'the task deleted successfuly');
                    } else if (state is DeleteTaskFailure) {
                      appToast(context, 'the task deleted Failure');
                    }
                  },
                  child: Dismissible(
                    key: UniqueKey(),
                    background: Container(
                      alignment: Alignment.centerRight,
                    ),
                    child: InkWell(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          topLeft: Radius.circular(20)),
                      onTap: () {
                        String title = 'title of task';
                        String description = updateTaskCubit.tasks[index].toDo;
                        String initDate = '19/5/2024';
                        String initTime = '5:14pm';
                        String indexo = index.toString();
                        String categoryId = 2.toString();
                        String id = updateTaskCubit.tasks[index].id.toString();
                        // print(id);

                        AppRouter.router.push(
                            '${AppRouter.kUpdateTaskView}?title=$title&&description=$description&&initDate=$initDate&&initTime=$initTime&&index=$indexo&&categoryId=$categoryId&&id=$id');
                      },
                      child: BlocBuilder<UpdateTaskCubit, UpdateTaskState>(
                        builder: (BuildContext context, UpdateTaskState state) {
                          return TaskItem(
                            title: 'title of task',
                            description: updateTaskCubit.tasks[index].toDo,
                            time: '5:14pm',
                            date: '19/5/2024',
                            colorNumber: 2,
                            isDone: updateTaskCubit.tasks[index].completed,
                            categoryId: 2,
                            onTap: () {
                              updateTaskCubit.updateToDo({
                                'id': updateTaskCubit.tasks[index].id,
                                'keyData': 'completed',
                                'valueData':
                                    updateTaskCubit.tasks[index].completed
                              }, context, index);
                            },
                          );
                        },
                      ),
                    ),
                    onDismissed: (direction) async {
                      deleteTaskCubit.deleteToDo(
                          updateTaskCubit.tasks[index].id, context);
                    },
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 2.h,
                ); // Customize the separator here
              },
            ),
          );
        } else if (state is GetAllTasksFailure) {
          return Text(state.errMessage);
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
