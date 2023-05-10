import 'package:get_it/get_it.dart';
import 'package:simple_login/module/data/local/app_local_data_source.dart';
import 'package:simple_login/module/data/remote/app_remote_data_source.dart';
import 'package:simple_login/module/data/repository/app_repository_impl.dart';
import 'package:simple_login/module/domain/repository/app_repository.dart';
import 'package:simple_login/module/domain/use_case/app_use_case.dart';
import 'package:simple_login/module/external/constant/app_constant.dart';
import 'package:simple_login/module/external/service/dio_client.dart';
import 'package:simple_login/module/external/service/service_helper.dart';

final instance = GetIt.instance;

initInjector() {
  instance.registerLazySingleton<DioClient>(
    () => DioClient(),
  );
  instance.registerLazySingleton<ServiceHelper>(
    () => ServiceHelperImpl(
      dio: GetIt.I.get<DioClient>().dio,
    ),
  );
  instance.registerLazySingleton<AppRemoteDataSource>(
    () => AppRemoteDataSourceImpl(
      serviceHelper: GetIt.I.get<ServiceHelper>(),
      baseUrl: AppConstant.baseUrl,
    ),
  );
  instance.registerLazySingleton<AppLocalDataSource>(
    () => AppLocalDataSourceImpl(),
  );
  instance.registerLazySingleton<AppRepository>(
    () => AppRepositoryImpl(
      remoteDataSource: GetIt.I.get<AppRemoteDataSource>(),
      localDataSource: GetIt.I.get<AppLocalDataSource>(),
    ),
  );
  instance.registerLazySingleton<AppUseCase>(
    () => AppUseCaseImpl(
      repository: GetIt.I.get<AppRepository>(),
    ),
  );
}
