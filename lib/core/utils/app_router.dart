import 'package:power_of_task/Features/tasks/presention/views/tasks.dart';
import 'package:power_of_task/Features/tasks/presention/views/updateTask.dart';
import 'package:go_router/go_router.dart';

import '../../Features/Auth/presentation/views/login.dart';

abstract class AppRouter {
  static const kTasksView = '/tasks';
  static const kUpdateTaskView = '/updateTask';

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const Login(),
      ),
      GoRoute(
        path: kTasksView,
        builder: (context, state) => const Tasks(),
      ),
      GoRoute(
        path: kUpdateTaskView,
        builder: (context, state) {
          final title = state.queryParams['title'];
          final description = state.queryParams['description'];
          final initDate = state.queryParams['initDate'];
          final initTime = state.queryParams['initTime'];
          final index = state.queryParams['index'];
          final categoryId = state.queryParams['categoryId'];
          final id = state.queryParams['id'];

          return UpdateTask(
            title: title!,
            description: description!,
            initDate: initDate!,
            initTime: initTime!,
            index: int.parse(index!),
            categoryId: int.parse(categoryId!),
            id: int.parse(id!),
          );
        },
      ),
    ],
  );
}
