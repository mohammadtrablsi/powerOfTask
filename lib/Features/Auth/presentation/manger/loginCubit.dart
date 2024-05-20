import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/app_router.dart';
import '../../domain/useCases/makeRegisterUseCase.dart';

part 'loginStates.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.loginUseCase) : super(LoginInitial());
  bool isPassword = true;

  final LoginUseCase loginUseCase;
  Future<void> makeLogin(
      Map<String, dynamic> data, formstate, BuildContext context) async {
    if (checkValidationOfEnterData(formstate)) {
      mangeStateOfPostData(data).then((value) async {
        await Future.delayed(const Duration(seconds: 1));
        GoRouter.of(context).go(AppRouter.kTasksView);
      });
    }
  }

  Future<void> mangeStateOfPostData(Map<String, dynamic> data) async {
    emit(LoginLoading());
    var result = await loginUseCase.call(data);
    print('resulttttttttttttttttttttttttttttttttttttttttt$result');
    result.fold((failure) {
      emit(LoginFailure(failure.message));
    }, (_) {
      emit(LoginSuccess());
    });
  }

  bool checkValidationOfEnterData(formstate) {
    if (formstate!.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  void revPassword() {
    isPassword = !isPassword;
    emit(LoginInitial());
  }
}
