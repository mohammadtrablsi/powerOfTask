import 'package:power_of_task/Features/Auth/domain/entites/LoginEntity.dart';

import 'package:dartz/dartz.dart';

import 'package:power_of_task/core/errors/failure.dart';

import 'package:dio/dio.dart';

import '../../domain/repos/loginRepo.dart';
import '../dataSources/loginRemoteDataSource.dart';

class LoginRepoImpl extends LoginRepo {
  final LoginRemoteDataSource loginRemoteDataSource;

  LoginRepoImpl({required this.loginRemoteDataSource});
  @override
  Future<Either<Failure, LoginEntity>> makeLogin(
      {required Map<String, dynamic> data}) async {
    LoginEntity entity;
    try {
      entity = await loginRemoteDataSource.makeLogin(request: data);
      return right(entity);
    } catch (e) {
      if (e is DioError) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
