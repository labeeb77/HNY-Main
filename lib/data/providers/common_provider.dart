import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hny_main/core/constants/api_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommonProvider with ChangeNotifier {
  Dio dio = Dio();

  bool _isLoading = false;
  String? _error;
  bool get isLoading => _isLoading;
  String? get error => _error;
  changeLoadingStat() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  Future commonFileUploadApi(BuildContext context, _imagePath) async {
    changeLoadingStat();
    try {
      String uploadUrl =
          ApiConstants.fileUploadApiUrl; // Replace with your API endpoint
      FormData formData = FormData.fromMap({
        "arrFiles": await MultipartFile.fromFile(_imagePath),
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();

      Options options = Options(
        headers: {'Authorization': prefs.getString('access_token')},
      );

      Response response =
          await dio.post(uploadUrl, data: formData, options: options);
      log(response.data.toString(), name: "Res");

      if (response.statusCode == 200) {
        debugPrint("Upload successful: ${response.data}");
      } else {
        debugPrint("Upload failed with status: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Error during upload: $e");
    } finally {
      changeLoadingStat();
    }
  }
}
