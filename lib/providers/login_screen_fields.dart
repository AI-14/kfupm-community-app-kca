import 'package:flutter/material.dart';

class LoginScreenFieldsProvider extends ChangeNotifier {
  bool obscureTextPassword;
  bool isLoading;

  LoginScreenFieldsProvider(
      {this.obscureTextPassword = true, this.isLoading = false});

  void changeObscureTextPassword() {
    obscureTextPassword = !obscureTextPassword;
    notifyListeners();
  }

  void setIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
