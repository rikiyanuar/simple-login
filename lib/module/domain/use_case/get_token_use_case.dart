import 'package:dartz/dartz.dart';
import 'package:simple_login/module/domain/entity/failure.dart';
import 'package:simple_login/module/domain/repository/app_repository.dart';

import 'use_case.dart';

class GetTokenUseCase implements UseCase<String?, NoParams> {
  final AppRepository repository;

  GetTokenUseCase({required this.repository});

  @override
  Future<Either<Failure, String?>> call(NoParams params) {
    return repository.getToken();
  }
}
