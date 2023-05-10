import 'package:dartz/dartz.dart';
import 'package:simple_login/module/domain/entity/failure.dart';
import 'package:simple_login/module/domain/entity/user_entity.dart';
import 'package:simple_login/module/domain/repository/app_repository.dart';

import 'use_case.dart';

class GetUserUseCase implements UseCase<UserEntity, NoParams> {
  final AppRepository repository;

  GetUserUseCase({required this.repository});

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) {
    return repository.getUser();
  }
}
