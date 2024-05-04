import 'package:flutter/material.dart';

class LoginController extends ChangeNotifier {
  String _username = '';
  String get username => _username;

  String _messageError = '';
  String get messageError => _messageError;
  var loginState = StateLogin.initial;

  void processLogin(String userName, String password) {
    loginState = StateLogin.loading;
    notifyListeners();
    if (userName == 'Gustav' && password == 'Gustav999') {
      loginState = StateLogin.success;
      _username = userName;
    } else {
      loginState = StateLogin.error;
      _messageError = 'Username and password is wrong';
    }
    notifyListeners();
  }
}

enum StateLogin { initial, loading, success, error }
