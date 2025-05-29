import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hny_main/core/constants/api_constants.dart';
import 'package:hny_main/core/global/profile.dart';
import 'package:hny_main/core/utils/app_alerts.dart';
import 'package:hny_main/core/utils/date_formatter.dart';
import 'package:hny_main/data/models/request/add_profile_model.dart';
import 'package:hny_main/data/models/response/api_response_model.dart';
import 'package:hny_main/data/models/user_model/user_profile_model.dart';
import 'package:hny_main/data/providers/common_provider.dart';
import 'package:hny_main/service/api_service.dart';
import 'package:intl/intl.dart';
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
  String? selectedDateOfBirthInISO;
  String? selectedCitizenshipType;

  File? _selectedProfileImage;
  // We'll keep these properties but won't use them in the add profile flow
  File? _selectedGCCIdCardImagePath;
  File? _selectedDrivingLicenseImagePath;
  File? _selectedPassportImagePath;
  File? _selectedEmiratesIdCardImagePath;
  File? _selectedVisaCardImagePath;

  File? get selectedProfileImage => _selectedProfileImage;
  File? get selectedVisaCardImagePath => _selectedVisaCardImagePath;
  File? get selectedGCCIdCardImagePath => _selectedGCCIdCardImagePath;
  File? get selectedDrivingLicenseImagePath => _selectedDrivingLicenseImagePath;
  File? get selectedEmirateIdCardImagePath => _selectedEmiratesIdCardImagePath;

  File? get selectedPassportImagePath => _selectedPassportImagePath;

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
      selectedCitizenshipType = globalUser?.strCitizenType;
      dobController.text =
          DateFormatter.formatDateOfBirth(globalUser?.dateOfBirth) ?? "";
      selectedGender = globalUser?.gender ?? "";

      // Parse date of birth if available
    }
    notifyListeners();
  }

  void setProfileImage(File? image) =>
      _updateValue(() => _selectedProfileImage = image);
  void setGCCIdCardImagePath(File? image) =>
      _updateValue(() => _selectedGCCIdCardImagePath = image);
  void setDrivingLicenseImagePath(File? image) =>
      _updateValue(() => _selectedDrivingLicenseImagePath = image);
  void setNationality(String value) =>
      _updateValue(() => selectedNationality = value);
  void setGender(String value) => _updateValue(() => selectedGender = value);
  void setCitizenshipType(String value) =>
      _updateValue(() => selectedCitizenshipType = value);

  void setPassportImagePath(File? image) =>
      _updateValue(() => _selectedPassportImagePath = image);
  void setEmiratesIdCardImagePath(File? image) =>
      _updateValue(() => _selectedEmiratesIdCardImagePath = image);
  void setVisaCardImagePath(File? image) =>
      _updateValue(() => _selectedVisaCardImagePath = image);

  Future<bool> addProfileData(BuildContext context) async {
    String? profileUploadedUrl;

    try {
      changeLoadingState();

      // Only upload profile image in the add flow
      if (_selectedProfileImage != null) {
        profileUploadedUrl = await _uploadFile(context, _selectedProfileImage);
        if (profileUploadedUrl == null) {
          throw Exception("Failed to upload profile image");
        }
      }

      if (globalUser == null) {
        throw Exception("User data not available");
      }

      final AddProfileModel data = AddProfileModel(
        strDateOfBirth: selectedDateOfBirthInISO,
        strEmail: emailController.text,
        strEmiratesIdUrl: globalUser?.strEmiratesIdUrl ?? "",
        strFcmToken: "",
        strFirstName: firstNameController.text,
        strGccIdUrl: globalUser?.strGccIdUrl ?? "",
        strGender: selectedGender,
        strLastName: lastNameController.text,
        strLicenceUrl: globalUser?.strLicenceUrl ?? "",
        strNationality: selectedNationality,
        strPassportUrl: globalUser?.strPassportUrl ?? "",
        strProfileUrl: profileUploadedUrl ?? globalUser?.strProfileUrl ?? "",
        strCitizenType: selectedCitizenshipType ?? "",
      );

      log("strDateOfBirth: ${data.strDateOfBirth}");
      log("strEmail: ${data.strEmail}");
      log("strEmiratesIdUrl: ${data.strEmiratesIdUrl}");
      log("strFcmToken: ${data.strFcmToken}");
      log("strFirstName: ${data.strFirstName}");
      log("strGCCIdUrl: ${data.strGccIdUrl}");
      log("strGender: ${data.strGender}");
      log("strLastName: ${data.strLastName}");
      log("strLicenceUrl: ${data.strLicenceUrl}");
      log("strNationality: ${data.strNationality}");
      log("strCitizenType: ${data.strCitizenType}");
      log("strPassportUrl: ${data.strPassportUrl}");
      log("strProfileUrl: ${data.strProfileUrl}");
      final ApiResponseModel<dynamic> apiResponse =
          await ApiService(context).apiCall(
        endpoint: ApiConstants.updateCustomerUrl,
        method: 'POST',
        data: data,
      );

      if (apiResponse.success && apiResponse.data != null) {
        log('api response: ${apiResponse.data}');

        // Update the global user data after successful save
        await getUserProfileDetails(context);

        return true;
      } else {
        _error = apiResponse.error ?? "Unknown error occurred";
        AppAlerts.showCustomSnackBar(_error!, isSuccess: false);
        return false;
      }
    } catch (e) {
      debugPrint('Error adding profile data: $e');
      _error = "Failed to save profile data: ${e.toString()}";
      AppAlerts.showCustomSnackBar(_error!, isSuccess: false);
      return false;
    } finally {
      changeLoadingState();
    }
  }

  Future<bool> updateDocumentUrl(
    BuildContext context, {
    required File? documentFile,
    required String documentType,
  }) async {
    String? documentUrl;

    try {
      changeLoadingState();

      // Upload document image
      if (documentFile != null) {
        log("Reach");
        documentUrl = await _uploadFile(context, documentFile);
        if (documentUrl == null) {
          throw Exception("Failed to upload $documentType");
        }
      } else {
        // If no file is provided, nothing to update
        changeLoadingState();
        return false;
      }

      if (globalUser == null) {
        throw Exception("User data not available");
      }

      // Create a payload with just the ID and the specific document URL field
      final Map<String, dynamic> data = {};
      log("updateDocumentRequest Body : $data");

      // Set the correct field based on document type
      switch (documentType) {
        case 'GCC ID':
          data['strGCCIdUrl'] = documentUrl;
          break;
        case 'License':
          data['strLicenceUrl'] = documentUrl;
          break;
        case 'Passport':
          data['strPassportUrl'] = documentUrl;
          break;
        case 'Emirates ID':
          data['strEmiratesIdUrl'] = documentUrl;
          break;
        case 'Visa Card':
          data['strVisaUrl'] = documentUrl;
          break;
        default:
          throw Exception("Invalid document type");
      }

      final ApiResponseModel<dynamic> apiResponse = await ApiService(context)
          .apiCall(
              endpoint: ApiConstants.updateCustomerUrl,
              method: 'POST',
              data: data,
              sendToken: true);

      if (apiResponse.success && apiResponse.data != null) {
        log('$documentType update response: ${apiResponse.data}');

        // Update the global user data after successful save
        await getUserProfileDetails(context);

        return true;
      } else {
        _error = apiResponse.error ?? "Unknown error occurred";
        AppAlerts.showCustomSnackBar(_error!, isSuccess: false);
        return false;
      }
    } catch (e) {
      debugPrint('Error updating $documentType: $e');
      _error = "Failed to save $documentType: ${e.toString()}";
      AppAlerts.showCustomSnackBar(_error!, isSuccess: false);
      return false;
    } finally {
      changeLoadingState();
    }
  }

  Future<bool> getUserProfileDetails(BuildContext context) async {
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
        _error = apiResponse.error ?? "Failed to get profile details";
        AppAlerts.showCustomSnackBar(_error!, isSuccess: false);
        return false;
      }
    } catch (e) {
      debugPrint('Error getting profile data: $e');
      _error = "Failed to fetch profile data: ${e.toString()}";
      AppAlerts.showCustomSnackBar(_error!, isSuccess: false);
      return false;
    }
  }

  Future<String?> _uploadFile(BuildContext context, File? file) async {
    if (file == null || !context.mounted) return null;

    try {
      return await Provider.of<CommonProvider>(context, listen: false)
          .commonFileUploadApi(context, file.path);
    } catch (e) {
      debugPrint('Error uploading file: $e');
      return null;
    }
  }

  void _updateValue(VoidCallback update) {
    update();
    notifyListeners();
  }
}
