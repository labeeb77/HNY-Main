import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hny_main/core/constants/api_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hny_main/core/utils/upload/file_upload_stub.dart'; 

class CommonProvider with ChangeNotifier {
  final Dio dio = Dio();

  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;
  String? get error => _error;

  void changeLoadingState() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  Future<String?> commonFileUploadApi(BuildContext context, String imagePath) async {
    changeLoadingState();
    try {
      const String uploadUrl = "${ApiConstants.baseUrl2}${ApiConstants.fileUploadApiUrl}";

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');

      if (token == null) {
        debugPrint("Error: Missing access token.");
        return null;
      }

      final formData = await createFormData(imagePath); // platform-safe

      final options = Options(headers: {'Authorization': token});
      final response = await dio.post(uploadUrl, data: formData, options: options);

      log(response.data.toString(), name: "Upload Response");

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['statusCode'] == 200 &&
            data['arrUrls'] != null &&
            data['arrUrls'].isNotEmpty) {
          return data['arrUrls'][0];
        } else {
          debugPrint("Unexpected response format: $data");
        }
      } else {
        debugPrint("Upload failed with status: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Error during upload: $e");
    } finally {
      changeLoadingState();
    }
    return null;
  }
}
