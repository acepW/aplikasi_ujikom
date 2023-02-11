import 'package:aplikasi_ujikom/auth_method.dart';
import 'package:aplikasi_ujikom/model/user_model.dart';

import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  late UserModel _user;
  final AuthMethods _authMethods = AuthMethods();

  UserModel get getUser => _user;

  Future<void> refreshUser() async {
    UserModel user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
