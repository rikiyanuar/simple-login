import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:simple_login/module/domain/use_case/app_use_case.dart';
import 'package:simple_login/module/presentation/screen/login_screen.dart';
import 'package:simple_login/module/presentation/view_model/general_state.dart';
import 'package:simple_login/module/presentation/view_model/splash_view_model.dart';

import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashViewModel? _viewModel;

  @override
  void initState() {
    _viewModel = SplashViewModel(useCase: GetIt.I.get<AppUseCase>());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkToken();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _viewModel!,
      child: const Scaffold(
        body: Center(
          child: Text("Simaple Login"),
        ),
      ),
    );
  }

  _checkToken() async {
    final state = await _viewModel!.checkToken();

    if (!mounted) return;
    if (state is GeneralSuccessState) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    }
  }
}
