import 'package:power_of_task/Features/tasks/domain/useCases/UpdateToDoUseCases.dart';
import 'package:power_of_task/Features/tasks/domain/useCases/deleteToDoUseCases.dart';
import 'package:power_of_task/Features/tasks/domain/useCases/getAllTasks.dart';
import 'package:power_of_task/Features/tasks/presention/mangers/updateTaskCubit/updateTaskCubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/utils/functions/setup_service_locator.dart';
import '../../data/repos/tasksRepoImp.dart';
import '../mangers/deleteToDoUseCases.dart/deleteTaskCubit.dart';
import '../mangers/getAllTasks/getAllTaskCubit.dart';
import 'widgets/appBarPart.dart';
import 'widgets/newTaskPart.dart';
import 'widgets/tasksPart.dart';

class Tasks extends StatelessWidget {
  const Tasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarPart(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Column(
              children: [
                const NewTaskPart(),
                SizedBox(
                  height: 6.h,
                ),
                MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) {
                        return GetAllTasksCubit(
                          GetAllTasksUseCase(
                            getIt.get<TasksRepoImpl>(),
                          ),
                        )..getAllTasks();
                      },
                    ),
                    BlocProvider(
                      create: (context) {
                        return UpdateTaskCubit(
                          UpdateToDoUseCase(
                            getIt.get<TasksRepoImpl>(),
                          ),
                        );
                      },
                    ),
                    BlocProvider(
                      create: (context) {
                        return DeleteTaskCubit(
                          DeleteToDoUseCase(
                            getIt.get<TasksRepoImpl>(),
                          ),
                        );
                      },
                    ),
                  ],
                  child: const TasksPart(),
                ),
              ],
            ),
          ),
        ],
      ),
      // ),
    );
  }
}
