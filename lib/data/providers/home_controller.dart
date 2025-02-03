import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hny_main/core/constants/api_constants.dart';
import 'package:hny_main/core/utils/app_alerts.dart';
import 'package:hny_main/data/models/response/api_response_model.dart';
import 'package:hny_main/data/models/response/car_list_model.dart';
import 'package:hny_main/service/api_service.dart';
import 'package:hny_main/service/home_serveice.dart';

class HomeController extends ChangeNotifier {
  final HomeService _homeService;

  List<ArrCar> _carListData = [];
  bool _isLoading = false;
  String? _error;

  RangeValues currentRangeValues = const RangeValues(30, 50);
  String selectedCarType = 'Economy';

  final List<String> carTypes = [
    'Economy', 'Luxury', 'Sedan', 
    'Compact', 'Hatchback', 'Suv',
  ];

  HomeController(BuildContext context) : _homeService = HomeService(context);

  // Getters
  List<ArrCar> get carListData => _carListData;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Methods
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? value) {
    _error = value;
    notifyListeners();
  }

  void changeSliderValue(RangeValues value) {
    currentRangeValues = value;
    notifyListeners();
  }

  void changeCarType(String value) {
    selectedCarType = value;
    notifyListeners();
  }

  Future<void> getCarDataList(BuildContext context) async {
    try {
      _setLoading(true);
      _error = null;

      final data = await _homeService.fetchCarDataList();
      
      if (data != null) {
        _carListData = data.arrCars;
        notifyListeners();
      } else {
        _setError("Failed to fetch car data");
        AppAlerts.showCustomSnackBar("Failed to fetch the data", isSuccess: false);
      }
    } catch (e) {
      _setError('An unexpected error occurred');
      AppAlerts.showCustomSnackBar("Failed to fetch the data", isSuccess: false);
    } finally {
      _setLoading(false);
    }
  }
}