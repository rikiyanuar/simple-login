import 'package:flutter/material.dart';

class AppChangeNotifier extends ChangeNotifier {
  bool _isDisposed = false;

  @override
  void notifyListeners() {
    if (!_isDisposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _isDisposed = true;
  }
}
