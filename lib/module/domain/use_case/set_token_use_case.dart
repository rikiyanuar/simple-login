import 'package:dartz/dartz.dart';
import 'package:simple_login/module/domain/entity/failure.dart';
import 'package:simple_login/module/domain/repository/app_repository.dart';

import 'use_case.dart';

class SetTokenUseCase implements UseCase<bool, String> {
  final AppRepository repository;

  SetTokenUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> call(String token) {
    return repository.setToken(token);
  }
}
