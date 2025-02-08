import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hny_main/core/global/profile.dart';
import 'package:hny_main/core/routes/app_routes.dart';
import 'package:hny_main/data/models/auth/login_res_model.dart';
import 'package:hny_main/data/models/user_model/user_mode.dart';
import 'package:hny_main/service/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService;
  UserModel? _user;
  bool _isLoading = false;
  String? _error;

  AuthProvider(BuildContext context) : _authService = AuthService(context);

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<String?> login(String phoneNumber) async {
    try {
      _setLoading(true);
      _clearError();
      final response = await _authService.login(phoneNumber);
      if (response.success && response.data != null) {
        final loginData = LoginResModel.fromJson(response.data);
        return loginData.strOtpToken;
      } else {
        _setError(response.error ?? 'Login failed');
        return null;
      }
    } catch (e) {
      _setError('An unexpected error occurred');
      return null;
    } finally {
      _setLoading(false);
    }
  }

  void logCurrentUser() {
    log(_user?.strToken ?? "User token is null");
  }

  Future<bool> verifyOtp(
      String otpInput, String otpToken, BuildContext context) async {
    try {
      _setLoading(true);
      _clearError();
      final response = await _authService.verifyOtp(otpInput, otpToken);
      if (response.success && response.data != null) {
        _user = UserModel.fromJson(response.data);
        globalUser = UserModel.fromJson(response.data);
        await _authService.saveUserData(_user!).then((_) {
          if (_user?.strEmail.isEmpty || _user?.strFirstName == null) {
            Navigator.of(context).pushReplacementNamed(AppRoutes.addProfile);
          } else {
            Navigator.of(context).pushReplacementNamed(AppRoutes.bottomNav);
          }
        });
        return true;
      } else {
        _setError(response.error ?? 'OTP verification failed');
        return false;
      }
    } catch (e) {
      _setError('An unexpected error occurred');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> logout() async {
    try {
      _setLoading(true);
      _clearError();
      await _authService.clearAllLocalData();
      _user = null;
      notifyListeners();
    } catch (e) {
      _setError('An error occurred while logging out');
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? value) {
    _error = value;
    notifyListeners();
  }

  void _clearError() {
    _error = null;
  }
}
