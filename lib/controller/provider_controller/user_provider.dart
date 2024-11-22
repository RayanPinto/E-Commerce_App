import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:amazon_rayan/model/userModel.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
      id: '',
      email: '',
      name: '',
      password: '',
      address: '',
      type: '',
      token: '',
      cart: []);

  User get user => _user;
  void setUser(String user) {
    final Map<String, dynamic> userJson = jsonDecode(user);
    _user = User.fromJson(user);
    notifyListeners();
  }

  void setUserFromModel(User user) {
    _user = user;
    notifyListeners();
  }
  
  
}
