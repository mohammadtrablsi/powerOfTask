import 'package:power_of_task/Features/Auth/presentation/views/widgets/loginBody.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/functions/setup_service_locator.dart';
import '../../domain/useCases/makeRegisterUseCase.dart';
import '../manger/loginCubit.dart';
import '../../data/repos/loginRepoImp.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (BuildContext context) {
            return LoginCubit(
              LoginUseCase(
                getIt.get<LoginRepoImpl>(),
              ),
            );
          },
          child: const LoginBody(),
        ),
      ),
    );
  }
}
