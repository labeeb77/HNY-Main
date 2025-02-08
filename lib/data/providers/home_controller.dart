import 'package:flutter/material.dart';
import 'package:hny_main/core/utils/app_alerts.dart';
import 'package:hny_main/data/models/response/car_list_model.dart';
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

  // Private Methods
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? value) {
    _error = value;
    notifyListeners();
  }

  void _updateCarList(List<ArrCar> data) {
    _carListData = data;
    notifyListeners();
  }

  // Public Methods
  void changeSliderValue(RangeValues value) {
    currentRangeValues = value;
    notifyListeners();
  }

  void changeCarType(String value) {
    selectedCarType = value;
    notifyListeners();
  }

  Future<void> getCarDataList(BuildContext context) async {
    _setLoading(true);
    _setError(null);

    try {
      final data = await _homeService.fetchCarDataList();
      if (data != null) {
        _updateCarList(data.arrCars);
      } else {
        _handleError("Failed to fetch car data");
      }
    } catch (e) {
      _handleError("An unexpected error occurred");
    } finally {
      _setLoading(false);
    }
  }

  void _handleError(String message) {
    _setError(message);
    AppAlerts.showCustomSnackBar(message, isSuccess: false);
  }
}
