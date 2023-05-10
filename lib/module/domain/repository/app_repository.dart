import 'package:dartz/dartz.dart';
import 'package:simple_login/module/domain/entity/login_body.dart';
import 'package:simple_login/module/domain/entity/login_entity.dart';
import 'package:simple_login/module/domain/entity/user_entity.dart';

import '../entity/failure.dart';

abstract class AppRepository {
  Future<Either<Failure, UserEntity>> getUser();
  Future<Either<Failure, LoginEntity>> login(LoginBody body);

  Future<Either<Failure, bool>> setToken(String token);
  Future<Either<Failure, String?>> getToken();
}
