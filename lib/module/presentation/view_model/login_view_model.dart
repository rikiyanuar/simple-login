import 'package:simple_login/module/domain/entity/failure.dart';
import 'package:simple_login/module/domain/entity/login_body.dart';
import 'package:simple_login/module/domain/use_case/app_use_case.dart';
import 'package:simple_login/module/external/provider/app_provider.dart';
import 'package:simple_login/module/presentation/view_model/general_state.dart';

class LoginViewModel extends AppChangeNotifier {
  final AppUseCase useCase;

  bool isLoading = false;

  LoginViewModel({required this.useCase});

  Future<GeneralState> login(LoginBody body) async {
    try {
      _setLoading(true);

      final response = await useCase.login(body);

      return response.fold(
        (l) {
          if (l is ServerFailure) {
            return GeneralServerErrorState();
          } else {
            return GeneralClientErrorState();
          }
        },
        (r) => _setToken(r.token),
      );
    } catch (e) {
      return GeneralClientErrorState();
    } finally {
      _setLoading(false);
    }
  }

  Future<GeneralState> _setToken(String token) async {
    try {
      _setLoading(true);

      final result = await useCase.setToken(token);

      return result.fold(
          (l) => GeneralErrorState(), (r) => GeneralSuccessState());
    } catch (e) {
      return GeneralErrorState();
    } finally {
      _setLoading(false);
    }
  }

  _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
