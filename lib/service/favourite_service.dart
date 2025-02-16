import 'package:flutter/material.dart';
import 'package:hny_main/core/constants/api_constants.dart';
import 'package:hny_main/data/models/favourites/favourites_model.dart';
import 'package:hny_main/data/models/response/api_response_model.dart';
import 'package:hny_main/service/api_service.dart';

class FavouriteService {
  final ApiService _apiService;

  FavouriteService(BuildContext context) : _apiService = ApiService(context);

  Future<ApiResponseModel> addToFavourites(String strCarId) async {
    return await _apiService.apiCall(
        endpoint: ApiConstants.addToFavourites,
        method: 'POST',
        data: {"strCarId": strCarId},
        sendToken: true);
  }

  Future<ApiResponseModel> removeFromFavourites(String favCarId) async {
    return await _apiService.apiCall(
        endpoint: ApiConstants.removeFavourites,
        method: 'POST',
        data: {"_id": favCarId},
        sendToken: true);
  }

  Future<FavouritesModel?> getFavouritesList() async {
    try {
      ApiResponseModel<dynamic> apiResponse = await _apiService.apiCall(
          endpoint: ApiConstants.getFavouritesList,
          method: 'POST',
          sendToken: true);

      if (apiResponse.success && apiResponse.data != null) {
        return FavouritesModel.fromJson(apiResponse.data);
      }
      return null;
    } catch (e) {
      debugPrint('Error fetching favourites list: $e');
      return null;
    }
  }
}
