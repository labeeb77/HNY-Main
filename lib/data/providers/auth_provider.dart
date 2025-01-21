
import 'package:flutter/material.dart';
import 'package:hny_main/data/models/response/user_model/user_mode.dart';
import 'package:hny_main/data/repositories/auth/auth_repo.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();

  UserModel? _user;
  bool _isLoading = false;
  String? _error;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future login(String phoneNumber) async {
    try {
      _setLoading(true);
      _clearError();

      final response = await _authRepository.login(phoneNumber);

      if (response.success && response.data != null) {
        return response.data.strOtpToken;
      } else {
        _setError(response.message ?? 'Login failed');
        return false;
      }
    } catch (e) {
      _setError('An unexpected error occurred $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future verifyOtp(String otpInput, String otpToken) async {
    try {
      _setLoading(true);
      _clearError();

      final response = await _authRepository.verifyOtp(otpInput, otpToken);

      if (response.success && response.data != null) {
        _user = response.data;
        await _authRepository.saveUserDatas(_user!);
        return true;
      } else {
        _setError(response.message ?? 'Login failed');
        return false;
      }
    } catch (e) {
      _setError('An unexpected error occurred');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future logout() async {
    try {
      _setLoading(true);
      _clearError();

      // Clear locally saved user data
      await _authRepository.clearToken();

      // Reset user state
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
