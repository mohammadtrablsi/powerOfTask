part of 'loginCubit.dart';


abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginFailure extends LoginState {
  final String errMessage;

  LoginFailure(this.errMessage);
}

// class ShowPassword extends LoginState {
// }

class LoginSuccess extends LoginState {}
