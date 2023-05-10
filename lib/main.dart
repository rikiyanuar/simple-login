import 'package:flutter/material.dart';

import 'module/external/injector/injector.dart';
import 'module/presentation/screen/splash_screen.dart';

void main() {
  initInjector();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Login',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const SplashScreen(),
    );
  }
}
