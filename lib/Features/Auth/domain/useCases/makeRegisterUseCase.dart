import 'package:power_of_task/Features/Auth/domain/repos/loginRepo.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/use_cases/use_case.dart';
import '../entites/LoginEntity.dart';

class LoginUseCase extends UseCase<LoginEntity, Map<String, dynamic>> {
  final LoginRepo loginRepo;

  LoginUseCase(this.loginRepo);

  @override
  Future<Either<Failure, LoginEntity>> call(
      [Map<String, dynamic> param = const {}]) async {
    return await loginRepo.makeLogin(data: param);
  }
}
