import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hny_main/core/constants/api_constants.dart';
import 'package:hny_main/core/utils/app_alerts.dart';
import 'package:hny_main/data/models/response/api_response_model.dart';
import 'package:hny_main/data/models/response/car_list_model.dart';
import 'package:hny_main/service/api_service.dart';

class HomeController extends ChangeNotifier {
  List<ArrCar> _carListData = [];
  bool _isLoading = false;
  String? _error;
bool get isLoading => _isLoading;
  String? get error => _error;
  List<ArrCar> get carListData => _carListData;
  
  RangeValues currentRangeValues = const RangeValues(30, 50);
  String selectedCarType = 'Economy';

  final List<String> carTypes = [
    'Economy',
    'Luxury',
    'Sedan',
    'Compact',
    'Hatchback',
    'Suv',
  ];

  changeLoadingStat() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  changeSliderValue(value) {
    currentRangeValues = value;
    notifyListeners();
  }

  changeCarType(value) {
    selectedCarType = value;
    notifyListeners();
  }

  Future<CarListModel?> getCarDataList(BuildContext context) async {
    try {
      changeLoadingStat();

      ApiResponseModel<dynamic> apiResponse = await ApiService(context).apiCall(
          endpoint: ApiConstants.getCartDataListUrl,
          method: 'POST',
          
          data: {
            "arrCategory": ["Economy", "Coupe"]
          });
      log(apiResponse.data.toString(), name: "Data");

      if (apiResponse.success && apiResponse.data != null) {
        CarListModel data = CarListModel.fromJson(apiResponse.data);
        _carListData = data.arrCars;
        notifyListeners();
      } else {
        AppAlerts.showCustomSnackBar(apiResponse.error??"Alert", isSuccess: false);
        return null;
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
