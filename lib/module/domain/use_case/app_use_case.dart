import 'package:dartz/dartz.dart';
import 'package:simple_login/module/domain/entity/failure.dart';
import 'package:simple_login/module/domain/entity/login_body.dart';
import 'package:simple_login/module/domain/entity/login_entity.dart';
import 'package:simple_login/module/domain/entity/user_entity.dart';
import 'package:simple_login/module/domain/repository/app_repository.dart';
import 'package:simple_login/module/domain/use_case/get_token_use_case.dart';
import 'package:simple_login/module/domain/use_case/set_token_use_case.dart';

import 'get_user_use_case.dart';
import 'login_use_case.dart';
import 'use_case.dart';

abstract class AppUseCase {
  Future<Either<Failure, UserEntity>> getUser();
  Future<Either<Failure, LoginEntity>> login(LoginBody body);
  Future<Either<Failure, String?>> getToken();
  Future<Either<Failure, bool>> setToken(String token);
}

class AppUseCaseImpl extends AppUseCase {
  final AppRepository repository;

  AppUseCaseImpl({required this.repository});

  @override
  Future<Either<Failure, UserEntity>> getUser() {
    final response = GetUserUseCase(repository: repository);

    return response(NoParams());
  }

  @override
  Future<Either<Failure, LoginEntity>> login(LoginBody body) {
    final response = LoginUseCase(repository: repository);

    return response(body);
  }

  @override
  Future<Either<Failure, String?>> getToken() {
    final response = GetTokenUseCase(repository: repository);

    return response(NoParams());
  }

  @override
  Future<Either<Failure, bool>> setToken(String token) {
    final response = SetTokenUseCase(repository: repository);

    return response(token);
  }
}
