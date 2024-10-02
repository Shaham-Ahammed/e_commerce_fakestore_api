import 'dart:developer';

import 'package:e_commerce_fake_store_api/data/models/user_login.dart';
import 'package:e_commerce_fake_store_api/data/respositories/user_login_repo.dart';
import 'package:flutter/material.dart';

class UsersViewmodel extends ChangeNotifier {
  UserData? _userData;
  LoginToken? _loginToken;
  final UserLoginRepo _userService = UserLoginRepo();

  bool get fetchedUsers => _userData != null;
  UserData? get userData => _userData;
  bool get userLoggedIn => _loginToken != null;

  Future<void> fetchUsers() async {
    try {
      _userData = await _userService.fetchUsers();
      if (_userData != null) {
        log("users fetched successfully");
      } else {
        log("failed to fetch users");
      }
    } catch (e) {
      log("failed and catched to fetch users");
    } finally {
      notifyListeners();
    }
  }

  Future<void> loginUser(UserLogin user) async {
    try {
      _loginToken = await _userService.loginUser(user);
      if (_loginToken != null) {
        log("user logged in");
      }
    } catch (e) {
      log("user not logged in");
    }
  }
}
