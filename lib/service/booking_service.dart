import 'package:flutter/material.dart';
import 'package:hny_main/core/constants/api_constants.dart';
import 'package:hny_main/data/models/booking/add_on_list_model.dart';
import 'package:hny_main/data/models/car_typelist/car_typelist.dart';
import 'package:hny_main/data/models/response/api_response_model.dart';
import 'package:hny_main/data/models/response/car_list_model.dart';
import 'package:hny_main/service/api_service.dart';

class BookingService {
  final ApiService _apiService;

  BookingService(BuildContext context) : _apiService = ApiService(context);

  // New method to fetch add on list
  Future<GetAddOnListModel?> fetchAddOnList() async {
    try {
      ApiResponseModel<dynamic> apiResponse = await _apiService.apiCall(
          endpoint: ApiConstants.getAddOnList,
          method: 'POST',
          data: {},
          sendToken: true);

      if (apiResponse.success && apiResponse.data != null) {
        return GetAddOnListModel.fromJson(apiResponse.data);
      }
      return null;
    } catch (e) {
      debugPrint('Error fetching add on list: $e');
      return null;
    }
  }
}
