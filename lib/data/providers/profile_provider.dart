import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hny_main/core/constants/api_constants.dart';
import 'package:hny_main/core/global/profile.dart';
import 'package:hny_main/core/utils/app_alerts.dart';
import 'package:hny_main/data/models/request/add_profile_model.dart';
import 'package:hny_main/data/models/response/api_response_model.dart';
import 'package:hny_main/data/providers/common_provider.dart';
import 'package:hny_main/service/api_service.dart';
import 'package:provider/provider.dart';

class ProfileProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _error;
  bool get isLoading => _isLoading;
  String? get error => _error;
  changeLoadingStat() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  String? selectedGender;
  String? selectedNationality = 'India';
  String? selectedCitizenship = 'Emirati';
  File? get selectedProfileImage => _selectedProfileImage;
  File? _selectedProfileImage;

  setProfileImage(File? image) {
    _selectedProfileImage = image;
    notifyListeners();
  }

  File? get selectedIdCardImagePath => _selectedIdCardImagePath;
  File? _selectedIdCardImagePath;

  setIdCardImagePath(File? image) {
    _selectedIdCardImagePath = image;
    notifyListeners();
  }

  File? get selectedDrivingLicenseImagePath => _selectedDrivingLicenseImagePath;
  File? _selectedDrivingLicenseImagePath;

  setDrivingLicenseImagePath(File? image) {
    _selectedDrivingLicenseImagePath = image;
    notifyListeners();
  }

  getIdTitleName() {
    switch (selectedCitizenship) {
      case "Emirati":
        return "Emirate";
      case "International":
        return "Passport";
      case "GCC":
        return "GCC";
      default:
    }
  }

  Future addProfileData(BuildContext context) async {
    try {
      changeLoadingStat();
// String? fcmToken = await FirebaseMessaging.instance.getToken();
      log(_selectedProfileImage?.path.toString() ?? "ld");
      String profileUploadedUrl =
          await Provider.of<CommonProvider>(context, listen: false)
              .commonFileUploadApi(context, _selectedProfileImage?.path);

// AddProfileModel data = AddProfileModel(id:currentUserId,strDateOfBirth:dobController.text,strEmail: emailController.text,strEmiratesIdUrl: ,strFcmToken: fcmToken??"",strFirstName:firstNameController.text ,strGccIdUrl: ,strGender:selectedGender,strLastName: lastNameController.text,strLicenceUrl: ,strNationality: selectedNationality,strPassportUrl: ,strProfileUrl: sele )

      ApiResponseModel<dynamic> apiResponse = await ApiService(context).apiCall(
          endpoint: ApiConstants.updateCustomerUrl,
          method: 'POST',
         
          );
      log(apiResponse.data.toString(), name: "Data");

      if (apiResponse.success && apiResponse.data != null) {
      } else {
        AppAlerts.showCustomSnackBar(apiResponse.error ?? "Alert",
            isSuccess: false);
      }
    } catch (e) {
      debugPrint('Error fetching car data: $e');
      AppAlerts.showCustomSnackBar("Failed to fetch the data",
          isSuccess: false);
      return null;
    } finally {
      changeLoadingStat();
    }
  }
}
