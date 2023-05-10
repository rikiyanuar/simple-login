import 'package:simple_login/module/domain/entity/login_body.dart';
import 'package:simple_login/module/domain/entity/login_entity.dart';
import 'package:simple_login/module/domain/entity/user_entity.dart';
import 'package:simple_login/module/external/constant/app_constant.dart';
import 'package:simple_login/module/external/service/service_helper.dart';

abstract class AppRemoteDataSource {
  Future<LoginEntity> login(LoginBody body);
  Future<UserEntity> getUser();
}

class AppRemoteDataSourceImpl extends AppRemoteDataSource {
  final String baseUrl;
  final ServiceHelper serviceHelper;

  AppRemoteDataSourceImpl({required this.baseUrl, required this.serviceHelper});

  @override
  Future<UserEntity> getUser() async {
    final response = await serviceHelper.get("$baseUrl/${AppConstant.user}");

    return UserEntity.fromJson(response.data);
  }

  @override
  Future<LoginEntity> login(LoginBody body) async {
    final response = await serviceHelper.post(
      "$baseUrl/${AppConstant.login}",
      data: body.toJson(),
    );

    return LoginEntity.fromJson(response.data);
  }
}
