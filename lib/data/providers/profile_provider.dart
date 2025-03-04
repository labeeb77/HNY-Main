import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hny_main/core/constants/api_constants.dart';
import 'package:hny_main/core/global/profile.dart';
import 'package:hny_main/core/utils/app_alerts.dart';
import 'package:hny_main/data/models/request/add_profile_model.dart';
import 'package:hny_main/data/models/response/api_response_model.dart';
import 'package:hny_main/data/models/user_model/user_profile_model.dart';
import 'package:hny_main/data/providers/common_provider.dart';
import 'package:hny_main/service/api_service.dart';
import 'package:provider/provider.dart';

class ProfileProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;
  String? get error => _error;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  String? selectedGender;
  String? selectedNationality;
  String? selectedCitizenship;

  File? _selectedProfileImage;
  File? _selectedIdCardImagePath;
  File? _selectedDrivingLicenseImagePath;

  File? get selectedProfileImage => _selectedProfileImage;
  File? get selectedIdCardImagePath => _selectedIdCardImagePath;
  File? get selectedDrivingLicenseImagePath => _selectedDrivingLicenseImagePath;

  void changeLoadingState() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  void initialMethod() {
    if (globalUser != null) {
      firstNameController.text = globalUser?.strFirstName ?? "";
      lastNameController.text = globalUser?.strLastName ?? "";
      mobileController.text = globalUser?.strMobileNo ?? "";
      emailController.text = globalUser?.strEmail ?? "";
      selectedNationality = globalUser?.strNationality ?? "";

      selectedCitizenship = globalUser?.strGccIdUrl?.isNotEmpty == true
          ? 'GCC'
          : globalUser?.strPassportUrl?.isNotEmpty == true
              ? 'International'
              : globalUser?.strEmiratesIdUrl?.isNotEmpty == true
                  ? 'Emirati'
                  : null;
    }
    notifyListeners();
  }

  void setProfileImage(File? image) =>
      _updateValue(() => _selectedProfileImage = image);
  void setIdCardImagePath(File? image) =>
      _updateValue(() => _selectedIdCardImagePath = image);
  void setDrivingLicenseImagePath(File? image) =>
      _updateValue(() => _selectedDrivingLicenseImagePath = image);
  void setNationality(String value) =>
      _updateValue(() => selectedNationality = value);
  void setCitizenship(String value) =>
      _updateValue(() => selectedCitizenship = value);
  void setGender(String value) => _updateValue(() => selectedGender = value);

  String getIdTitleName() {
    switch (selectedCitizenship) {
      case "Emirati":
        return "Emirate";
      case "International":
        return "Passport";
      case "GCC":
        return "GCC";
      default:
        return "";
    }
  }

  Future<bool?> addProfileData(BuildContext context) async {
    String? profileUploadedUrl;
    String? idCardUploadedUrl;
    String? licenseUploadedUrl;

    try {
      changeLoadingState();

      profileUploadedUrl = await _uploadFile(context, _selectedProfileImage);
      licenseUploadedUrl =
          await _uploadFile(context, _selectedDrivingLicenseImagePath);
      idCardUploadedUrl = await _uploadFile(context, _selectedIdCardImagePath);

      if (globalUser == null) return false;
      final AddProfileModel data = AddProfileModel(
        id: currentUserId ?? "",
        strDateOfBirth: dobController.text,
        strEmail: emailController.text,
        strEmiratesIdUrl: selectedCitizenship == "Emirati"
            ? idCardUploadedUrl ?? globalUser?.strEmiratesIdUrl
            : "",
        strFcmToken: "",
        strFirstName: firstNameController.text,
        strGccIdUrl: selectedCitizenship == "GCC"
            ? idCardUploadedUrl ?? globalUser?.strGccIdUrl
            : "",
        strGender: selectedGender,
        strLastName: lastNameController.text,
        strLicenceUrl: licenseUploadedUrl ?? globalUser?.strLicenceUrl,
        strNationality: selectedNationality,
        strPassportUrl: selectedCitizenship == "International"
            ? idCardUploadedUrl ?? globalUser?.strPassportUrl
            : "",
        strProfileUrl: profileUploadedUrl ?? globalUser?.strProfileUrl,
      );

      final ApiResponseModel<dynamic> apiResponse =
          await ApiService(context).apiCall(
        endpoint: ApiConstants.updateCustomerUrl,
        method: 'POST',
        data: data,
      );

      if (apiResponse.success && apiResponse.data != null) {
        globalUser = null;
        currentUserId = '';
        notifyListeners();
        return true;
      } else {
        AppAlerts.showCustomSnackBar(apiResponse.error ?? "Alert",
            isSuccess: false);
      }
    } catch (e) {
      debugPrint('Error adding profile data: $e');
      AppAlerts.showCustomSnackBar("Failed to fetch the data",
          isSuccess: false);
    } finally {
      changeLoadingState();
    }
    return null;
  }

  Future getUserProfileDetails(BuildContext context) async {
    try {
      final ApiResponseModel<dynamic> apiResponse =
          await ApiService(context).apiCall(
        endpoint: ApiConstants.getProfileDetails,
        method: 'POST',
        sendToken: true,
        showErrorMessage: true,
      );

      if (apiResponse.success && apiResponse.data != null) {
        log(apiResponse.data.toString());
        globalUser = UserProfileModel.fromJson(apiResponse.data);
        log(globalUser!.strEmail.toString());
        notifyListeners();
        return true;
      } else {
        AppAlerts.showCustomSnackBar(apiResponse.error ?? "Alert",
            isSuccess: false);
      }
    } catch (e) {
      debugPrint('Error getting profile data: $e');
      AppAlerts.showCustomSnackBar("Failed to fetch the data",
          isSuccess: false);
    }
  }

  Future<String?> _uploadFile(BuildContext context, File? file) async {
    if (file == null || !context.mounted) return null;
    return await Provider.of<CommonProvider>(context, listen: false)
        .commonFileUploadApi(context, file.path);
  }

  void _updateValue(VoidCallback update) {
    update();
    notifyListeners();
  }
}
