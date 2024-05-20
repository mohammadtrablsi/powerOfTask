

import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entites/LoginEntity.dart';

abstract class LoginRepo {
  Future<Either<Failure, LoginEntity>> makeLogin(
      {required Map<String, dynamic> data});
}
