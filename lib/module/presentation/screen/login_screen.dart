import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:simple_login/module/domain/entity/login_body.dart';
import 'package:simple_login/module/domain/use_case/app_use_case.dart';
import 'package:simple_login/module/presentation/view_model/general_state.dart';
import 'package:simple_login/module/presentation/view_model/login_view_model.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginViewModel? _viewModel;
  final _emailInput = TextEditingController(text: "eve.holt@reqres.in");
  final _passInput = TextEditingController(text: "cityslicka");

  @override
  void initState() {
    _viewModel = LoginViewModel(useCase: GetIt.I.get<AppUseCase>());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _viewModel,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            TextField(
              controller: _emailInput,
              decoration: const InputDecoration(hintText: "Email"),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passInput,
              decoration: const InputDecoration(hintText: "Password"),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
                onPressed: () => _login(), child: const Text("LOGIN"))
          ]),
        ),
      ),
    );
  }

  _login() async {
    final state = await _viewModel!.login(LoginBody.fromJson(
      {"email": _emailInput.text, "password": _passInput.text},
    ));

    if (!mounted) return;
    if (state is GeneralSuccessState) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    }
  }
}
