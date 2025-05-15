import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hny_main/core/constants/api_constants.dart';
import 'package:hny_main/data/models/car_typelist/car_typelist.dart';
import 'package:hny_main/data/models/response/api_response_model.dart';
import 'package:hny_main/data/models/response/car_list_model.dart';
import 'package:hny_main/service/api_service.dart';

class HomeService {
  final ApiService _apiService;

  HomeService(BuildContext context) : _apiService = ApiService(context);

 Future<CarListModel?> fetchCarDataList({start, end, search}) async {
  log('fetchCarDataList : start - $start, end - $end, search - $search');
  try {
    // Convert DateTime objects to strings safely
    final String? startDate = start is DateTime ? start.toIso8601String() : start?.toString();
    final String? endDate = end is DateTime ? end.toIso8601String() : end?.toString();
    
    ApiResponseModel<dynamic> apiResponse = await _apiService.apiCall(
      endpoint: ApiConstants.getCarDataListUrl,
      method: 'POST',
      sendToken: true,
      data: {
        'strSearch': search ?? '',
        'strStartDate': startDate ?? '',
        'strEndDate': endDate ?? '',
      },
    );
    
    if (apiResponse.success && apiResponse.data != null) {
      log('Car Data: ${apiResponse.data}');
      try {
        return CarListModel.fromJson(apiResponse.data);
      } catch (parseError) {
        debugPrint('Error parsing car data: $parseError');
        return null;
      }
    }
    return null;
  } catch (e) {
    debugPrint('Error fetching car data: $e');
    return null;
  }
}

  // New method to fetch car type list
  Future<CarTypeList?> fetchCarTypeList() async {
    try {
      ApiResponseModel<dynamic> apiResponse = await _apiService.apiCall(
          endpoint: ApiConstants.getTypeListUrl,
          method: 'POST',
          data: {"strType": "car_filter_type", "type": "allTypes"},
          sendToken: true);

      if (apiResponse.success && apiResponse.data != null) {
        return CarTypeList.fromJson(apiResponse.data);
      }
      return null;
    } catch (e) {
      debugPrint('Error fetching car type list: $e');
      return null;
    }
  }
}
