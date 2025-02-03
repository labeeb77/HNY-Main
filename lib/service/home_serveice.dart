import 'package:flutter/material.dart';
import 'package:hny_main/core/constants/api_constants.dart';
import 'package:hny_main/data/models/response/api_response_model.dart';
import 'package:hny_main/data/models/response/car_list_model.dart';
import 'package:hny_main/service/api_service.dart';

class HomeService {
  final ApiService _apiService;

  HomeService(BuildContext context) : _apiService = ApiService(context);

  Future<CarListModel?> fetchCarDataList() async {
    try {
      ApiResponseModel<dynamic> apiResponse = await _apiService.apiCall(
        endpoint: ApiConstants.getCartDataListUrl,
        method: 'POST',
        data: {
          "arrCategory": ["Economy", "Coupe"]
        },
        sendToken: true
      );

      if (apiResponse.success && apiResponse.data != null) {
        return CarListModel.fromJson(apiResponse.data);
      }
      return null;
    } catch (e) {
      debugPrint('Error fetching car data: $e');
      return null;
    }
  }
}
