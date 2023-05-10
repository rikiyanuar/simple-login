import 'package:simple_login/module/domain/use_case/app_use_case.dart';
import 'package:simple_login/module/external/provider/app_provider.dart';
import 'package:simple_login/module/presentation/view_model/general_state.dart';

class SplashViewModel extends AppChangeNotifier {
  final AppUseCase useCase;

  SplashViewModel({required this.useCase});

  Future<GeneralState> checkToken() async {
    try {
      final result = await useCase.getToken();

      return result.fold(
        (l) => GeneralErrorState(),
        (r) {
          if (r == null || r.isEmpty) {
            return GeneralErrorState();
          } else {
            return GeneralSuccessState();
          }
        },
      );
    } catch (e) {
      return GeneralErrorState();
    }
  }
}
