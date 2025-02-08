import 'package:flutter/material.dart';
import 'package:hny_main/core/constants/api_constants.dart';
import 'package:hny_main/data/models/auth/login_res_model.dart';
import 'package:hny_main/data/models/response/api_response_model.dart';
import 'package:hny_main/data/models/user_model/user_mode.dart';
import 'package:hny_main/service/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final ApiService _apiService;

  AuthService(BuildContext context) : _apiService = ApiService(context);

  Future<ApiResponseModel> login(String phoneNumber) async {
    return await _apiService.apiCall(
      endpoint: ApiConstants.login,
      method: 'POST',
      data: {'strMobileNo': phoneNumber},
      sendToken: false
    );
  }

  Future<ApiResponseModel> verifyOtp(String otp, String otpToken) async {
    return await _apiService.apiCall(
      endpoint: ApiConstants.otpVerify,
      method: 'POST',
      data: {"strOTPToken": otpToken, "strOtp": otp},
      sendToken: false
    );
  }

  Future<void> saveUserData(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', user.id ?? "");
    await prefs.setString('access_token', user.strToken ?? "");
  }

  Future<void> clearAllLocalData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
  }
}

class AuthProvider extends ChangeNotifier {
  final AuthService _authService;
  UserModel? _user;
  bool _isLoading = false;
  String? _error;

  AuthProvider(BuildContext context) : _authService = AuthService(context);

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<dynamic> login(String phoneNumber) async {
    try {
      _setLoading(true);
      _clearError();
      
      final response = await _authService.login(phoneNumber);
      
      if (response.success && response.data != null) {
        final loginData = LoginResModel.fromJson(response.data);
        return loginData.strOtpToken;
      } else {
        _setError(response.error ?? 'Login failed');
        return false;
      }
    } catch (e) {
      _setError('An unexpected error occurred');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> verifyOtp(String otpInput, String otpToken) async {
    try {
      _setLoading(true);
      _clearError();

      final response = await _authService.verifyOtp(otpInput, otpToken);
      
      if (response.success && response.data != null) {
        _user = UserModel.fromJson(response.data);
        await _authService.saveUserData(_user!);
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