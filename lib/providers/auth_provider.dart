// lib/providers/auth_provider.dart

import 'package:e_commerce/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  User? _user;
  bool _isLoading = false;

  User? get user => _user;
  bool get isAuthenticated => _user != null;
  bool get isLoading => _isLoading;

  Future<void> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      _user = await _authService.loginWithEmail(email, password);
      notifyListeners();
    } catch (e) {
      // Handle error
      print('Login failed: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> register(String email, String password, String name) async {
    _isLoading = true;
    notifyListeners();

    try {
      _user = await _authService.registerWithEmail(email, password, name);
      notifyListeners();
    } catch (e) {
      // Handle error
      print('Registration failed: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();

    try {
      await _authService.logout();
      _user = null;
      notifyListeners();
    } catch (e) {
      // Handle error
      print('Logout failed: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setUser(User? user) {
    _user = user;
    notifyListeners();
  }
}
