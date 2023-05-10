import 'package:simple_login/module/data/local/app_local_data_source.dart';
import 'package:simple_login/module/data/remote/app_remote_data_source.dart';
import 'package:simple_login/module/domain/entity/user_entity.dart';
import 'package:simple_login/module/domain/entity/login_entity.dart';
import 'package:simple_login/module/domain/entity/login_body.dart';
import 'package:simple_login/module/domain/entity/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:simple_login/module/domain/repository/app_repository.dart';
import 'package:simple_login/module/external/service/service_exception.dart';

class AppRepositoryImpl extends AppRepository {
  final AppRemoteDataSource remoteDataSource;
  final AppLocalDataSource localDataSource;

  AppRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, UserEntity>> getUser() async {
    try {
      final response = await remoteDataSource.getUser();

      return Right(response);
    } on ServerErrorException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on ClientErrorException catch (e) {
      return Left(ClientFailure(message: e.message));
    } catch (e) {
      return Left(ClientFailure());
    }
  }

  @override
  Future<Either<Failure, LoginEntity>> login(LoginBody body) async {
    try {
      final response = await remoteDataSource.login(body);

      return Right(response);
    } on ServerErrorException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on ClientErrorException catch (e) {
      return Left(ClientFailure(message: e.message));
    } catch (e) {
      return Left(ClientFailure());
    }
  }

  @override
  Future<Either<Failure, String?>> getToken() async {
    try {
      final response = await localDataSource.getToken();

      return Right(response);
    } catch (e) {
      return Left(ClientFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> setToken(String token) async {
    try {
      final response = await localDataSource.setToken(token);

      return Right(response);
    } catch (e) {
      return Left(ClientFailure());
    }
  }
}
