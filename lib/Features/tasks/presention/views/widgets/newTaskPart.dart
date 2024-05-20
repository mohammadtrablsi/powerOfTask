import 'package:power_of_task/Features/Auth/presentation/views/widgets/authButton.dart';
import 'package:power_of_task/Features/tasks/presention/views/widgets/createNewTask.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/utils/functions/setup_service_locator.dart';
import '../../../data/repos/tasksRepoImp.dart';
import '../../../domain/useCases/AddToDoUseCases.dart';
import '../../mangers/addTaskCubit/addTaskCubit.dart';

class NewTaskPart extends StatelessWidget {
  const NewTaskPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          "My Tasks",
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w900),
        ),
        AuthButton(
            widget: Row(
              children: [
                const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                Text(
                  "New Task",
                  style: TextStyle(fontSize: 14.sp, color: Colors.white),
                )
              ],
            ),
            onpressed: () {
              showModalBottomSheet(
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(6.w),
                      topRight: Radius.circular(6.w),
                    ),
                  ),
                  builder: (context) {
                    return BlocProvider(
                      create: (BuildContext context) {
                        return AddTaskCubit(
                          AddToDoUseCase(
                            getIt.get<TasksRepoImpl>(),
                          ),
                        );
                      },
                      child: const CreateNewTask(),
                    );
                  },
                  context: context);
            },
            radius: 6.sp,
            paddinghorizontal: 4.w,
            paddingvertical: 1.h)
      ],
    );
  }
}
