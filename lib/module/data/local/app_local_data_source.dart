import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_login/module/external/constant/app_constant.dart';

abstract class AppLocalDataSource {
  Future<String?> getToken();
  Future<bool> setToken(String token);
}

class AppLocalDataSourceImpl extends AppLocalDataSource {
  @override
  Future<String?> getToken() async {
    final sharedPreferences = await SharedPreferences.getInstance();

    return sharedPreferences.getString(AppConstant.prefsToken);
  }

  @override
  Future<bool> setToken(String token) async {
    final sharedPreferences = await SharedPreferences.getInstance();

    return sharedPreferences.setString(AppConstant.prefsToken, token);
  }
}
