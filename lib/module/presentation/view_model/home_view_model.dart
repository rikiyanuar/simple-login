import 'package:simple_login/module/domain/entity/failure.dart';
import 'package:simple_login/module/domain/entity/user_entity.dart';
import 'package:simple_login/module/domain/use_case/app_use_case.dart';
import 'package:simple_login/module/external/provider/app_provider.dart';

import 'general_state.dart';

class HomeViewModel extends AppChangeNotifier {
  final AppUseCase useCase;
  UserEntity? userEntity;

  bool isLoading = false;

  HomeViewModel({required this.useCase});

  Future<GeneralState> getUser() async {
    try {
      _setLoading(true);

      final response = await useCase.getUser();

      return response.fold(
        (l) {
          if (l is ServerFailure) {
            return GeneralServerErrorState();
          } else {
            return GeneralClientErrorState();
          }
        },
        (r) {
          userEntity = r;

          return GeneralSuccessState();
        },
      );
    } catch (e) {
      return GeneralClientErrorState();
    } finally {
      _setLoading(false);
    }
  }

  _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
