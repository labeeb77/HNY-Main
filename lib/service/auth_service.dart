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

