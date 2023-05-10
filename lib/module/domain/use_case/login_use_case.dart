import 'package:dartz/dartz.dart';
import 'package:simple_login/module/domain/entity/failure.dart';
import 'package:simple_login/module/domain/entity/login_body.dart';
import 'package:simple_login/module/domain/entity/login_entity.dart';
import 'package:simple_login/module/domain/repository/app_repository.dart';

import 'use_case.dart';

class LoginUseCase implements UseCase<LoginEntity, LoginBody> {
  final AppRepository repository;

  LoginUseCase({required this.repository});

  @override
  Future<Either<Failure, LoginEntity>> call(LoginBody body) {
    return repository.login(body);
  }
}
