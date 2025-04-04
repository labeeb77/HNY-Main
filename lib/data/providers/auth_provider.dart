import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hny_main/core/global/profile.dart';
import 'package:hny_main/core/routes/app_routes.dart';
import 'package:hny_main/core/utils/app_colors.dart';
import 'package:hny_main/data/models/auth/login_res_model.dart';
import 'package:hny_main/data/models/user_model/user_mode.dart';
import 'package:hny_main/data/models/user_model/user_profile_model.dart';
import 'package:hny_main/data/providers/profile_provider.dart';
import 'package:hny_main/service/auth_service.dart';
import 'package:provider/provider.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService;
  UserModel? _user;
  bool _isLoading = false;
  String? _error;

  AuthProvider(BuildContext context) : _authService = AuthService(context);

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;


  String _countryCode = '971'; // Default to UAE
  
  String get countryCode => _countryCode;
  
  void setCountryCode(String code) {
    _countryCode = code;
    notifyListeners();
  }

  Future<String?> login(String phoneNumber) async {
    try {
      _setLoading(true);
      _clearError();
      final fullPhoneNumber = '$_countryCode$phoneNumber';
      final response = await _authService.login(fullPhoneNumber);
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
      notifyListeners();
      _clearError();
      final response = await _authService.verifyOtp(otpInput, otpToken);
      if (response.success && response.data != null) {
        log('OTP verified successfully ${response.data} ${response.success}');
        _user = UserModel.fromJson(response.data);

        await _authService.saveUserData(_user!).then((_) async {
          await Provider.of<ProfileProvider>(context, listen: false)
              .getUserProfileDetails(context);
          if (_user?.strEmail.isEmpty || _user?.strFirstName == null) {
            Navigator.of(context)
                .pushReplacementNamed(AppRoutes.manageProfile, arguments: 'Add');
          } else {
            Navigator.of(context).pushReplacementNamed(AppRoutes.bottomNav);
          }
        });
        return true;
      } else {
        Fluttertoast.showToast(
          msg: response.error.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        _setError(response.error ?? 'OTP verification failed');
        return false;
      }
    } catch (e) {
      _setError('An unexpected error occurred');
      return false;
    } finally {
      _setLoading(false);
            notifyListeners();

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
