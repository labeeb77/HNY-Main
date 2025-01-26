import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hny_main/core/api/dio_api_client.dart';
import 'package:hny_main/core/constants/api_constants.dart';
import 'package:hny_main/data/models/response/api_response.dart';
import 'package:hny_main/data/models/auth/login_res_model.dart';
import 'package:hny_main/data/models/user_model/user_mode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final ApiClient _apiClient = ApiClient();

  Future<ApiResponse> login(String phoneNumber) async {
    try {
      final response = await _apiClient.dio.post(
        ApiConstants.login,
        data: {'strMobileNo': phoneNumber},
      );
      log(response.data.toString());

      return ApiResponse(
        success: response.data['success'] ?? false,
        message: response.data['message'],
        statusCode: response.statusCode,
        data: response.data['success'] == true
            ? LoginResModel.fromJson(response.data)
            : null,
      );
    } on DioException catch (e) {
      return ApiResponse.error(
          e.response?.data?['message'] ?? 'Network error occurred');
    } catch (e) {
      return ApiResponse.error('An unexpected error occurred');
    }
  }

  Future<ApiResponse> verifyOtp(String otp, String otpToken) async {
    try {
      final response = await _apiClient.dio.post(
        ApiConstants.otpVerify,
        data: {"strOTPToken": otpToken, "strOtp": otp},
      );

      return ApiResponse(
        success: response.data['success'] ?? false,
        message: response.data['message'],
        statusCode: response.statusCode,
        data: response.data['success'] == true
            ? UserModel.fromJson(response.data)
            : null,
      );
    } on DioException catch (e) {
      return ApiResponse.error(
          e.response?.data?['message'] ?? 'Network error occurred');
    } catch (e) {
      return ApiResponse.error('An unexpected error occurred');
    }
  }

  Future saveUserDatas(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', user.id ?? "");
    await prefs.setString('access_token', user.strToken ?? "");
  }

  Future clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
  }
}
