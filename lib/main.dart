import 'package:power_of_task/Features/tasks/domain/entites/taskEntity.dart';
import 'package:power_of_task/constants.dart';
import 'package:power_of_task/core/utils/app_router.dart';
import 'package:power_of_task/core/utils/simple_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:hive_flutter/adapters.dart';

import 'core/utils/functions/setup_service_locator.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskEntityAdapter());

  setupServiceLocator();
  await Hive.openBox<TaskEntity>(kTasksBox);

  Bloc.observer = SimpleBlocObserver();
  runApp(const PowerOfTask());
}

class PowerOfTask extends StatelessWidget {
  const PowerOfTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp.router(
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
      );
    });
  }
}
