import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hny_main/core/constants/api_constants.dart';
import 'package:hny_main/data/models/cart/cartlist_model.dart';
import 'package:hny_main/data/models/response/api_response_model.dart';
import 'package:hny_main/service/api_service.dart';

class MyCartService {
  final ApiService _apiService;

  MyCartService(BuildContext context) : _apiService = ApiService(context);

  Future<MyCartListModel?> fetchMyCartList({start, end, search}) async {
    try {
      ApiResponseModel<dynamic> apiResponse = await _apiService.apiCall(
          endpoint: ApiConstants.getCart,
          method: 'POST',
          sendToken: true,);

      if (apiResponse.success && apiResponse.data != null) {
        log('Cart Data: ${apiResponse.data}');
        return MyCartListModel.fromJson(apiResponse.data);
      }
      return null;
    } catch (e) {
      debugPrint('Error fetching car data: $e');
      return null;
    }
  }

  Future<ApiResponseModel> deleteCartItem(String cartItemId) async {
    return await _apiService.apiCall(
      endpoint: ApiConstants.deleteCart,
      method: 'POST',
      data: {'_id': cartItemId},
      sendToken: true,
    );
  }

  Future<ApiResponseModel> updateCartItem(Map<String, dynamic> data) async {
    return await _apiService.apiCall(
      endpoint: ApiConstants.updateCart,
      method: 'POST',
      data: data,
      sendToken: true,
    );
  }
}
