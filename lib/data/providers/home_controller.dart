import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hny_main/core/utils/app_alerts.dart';
import 'package:hny_main/data/models/car_typelist/car_typelist.dart';
import 'package:hny_main/data/models/response/car_list_model.dart';
import 'package:hny_main/service/home_serveice.dart';
import 'package:intl/intl.dart';

class HomeController extends ChangeNotifier {
  final HomeService _homeService;

  List<ArrCar> _carListData = [];
  List<ArrTypeList> _carTypeListData = [];

  bool _isLoading = false;
  String? _error;
  String? searchQuery = '';
  RangeValues currentRangeValues = const RangeValues(30, 50);
  Set<String> selectedCarTypeIds = {};

  HomeController(BuildContext context) : _homeService = HomeService(context);

  DateTime? selecteStratdDate;
  String? selectedDateTOString;

  DateTime? selecteEnddDate;
  String? selectedEndTOString;

  void setSelectedStartDate(DateTime date) {
    selectedDateTOString = DateFormat('dd-MM-yyyy').format(date);
    selecteStratdDate = date;
    log(selectedDateTOString.toString());
    notifyListeners();
  }

  void setSelectedEndtDate(DateTime date) {
    selectedEndTOString = DateFormat('dd-MM-yyyy').format(date);
    selecteEnddDate = date;
    log(selectedDateTOString.toString());
    notifyListeners();
  }

  void filterWithDate() {}

  void filterCars() {
    List<ArrCar> filteredCars = _carListData.where((car) {
      bool matchesPrice = car.intPricePerDay != null &&
          car.intPricePerDay! >= currentRangeValues.start &&
          car.intPricePerDay! <= currentRangeValues.end;

      bool matchesCarType = selectedCarTypeIds.isEmpty ||
          (car.strCarCategory != null &&
              selectedCarTypeIds.contains(car.strCarCategory));

      return matchesPrice && matchesCarType;
    }).toList();

    _carListData = filteredCars;
    notifyListeners();
  }

  List<ArrCar> get carListData => _carListData;
  bool get isLoading => _isLoading;
  String? get error => _error;

  List<ArrTypeList> get carTypeListData => _carTypeListData;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void searchFeilds(query) {
    searchQuery = query.toLowerCase();
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

  void _updateCarTypeList(List<ArrTypeList> data) {
    _carTypeListData = data;
    notifyListeners();
  }

  // Public Methods
  void changeSliderValue(RangeValues value) {
    currentRangeValues = value;
    notifyListeners();
  }

  void toggleCarType(ArrTypeList carType) {
    if (carType.id == null) return;

    if (selectedCarTypeIds.contains(carType.id)) {
      selectedCarTypeIds.remove(carType.id);
    } else {
      selectedCarTypeIds.add(carType.id!);
    }
    notifyListeners();
  }

  // Updated method to check if a car type is selected
  bool isCarTypeSelected(ArrTypeList carType) {
    log(carType.toString());
    return carType.id != null && selectedCarTypeIds.contains(carType.id);
  }

  void clearCarTypes() {
    selectedCarTypeIds.clear();

    notifyListeners();
  }

  Future<void> getCarDataList(BuildContext context) async {
    _setLoading(true);
    _setError(null);

    try {
      final data = await _homeService.fetchCarDataList();

      if (data != null) {
        _updateCarList(data.arrCars ?? []);
        notifyListeners();
      } else {
        _handleError("Failed to fetch car data");
      }
    } catch (e) {
      _handleError("An unexpected error occurred");
    } finally {
      _setLoading(false);
    }
  }

  // void filterAndAssignCars(DateTime? startDate, DateTime? endDate) {
  //   if (startDate == null || endDate == null) return;

  //   _carListData = _carListData.where((item) {
  //     DateTime itemStartDate = DateTime.parse(item.str);
  //     DateTime itemEndDate = DateTime.parse(item.endDate);

  //     return (itemStartDate.isAfter(startDate) ||
  //             itemStartDate.isAtSameMomentAs(startDate)) &&
  //         (itemEndDate.isBefore(endDate) ||
  //             itemEndDate.isAtSameMomentAs(endDate));
  //   }).toList();

  //   log("Filtered Cars: ${_carListData.length}");
  //   notifyListeners(); // If using Provider
  // }

  // New method to fetch car type list
  Future<void> getCarTypeList() async {
    _setLoading(true);
    _setError(null);
    try {
      final data = await _homeService.fetchCarTypeList();
      if (data != null && data.arrList != null) {
        _updateCarTypeList(data.arrList!);
        selectedCarTypeIds.clear();
        notifyListeners();
      } else {
        _handleError("Failed to fetch car types");
      }
    } catch (e) {
      _handleError("An unexpected error occurred while fetching car types");
    } finally {
      _setLoading(false);
      notifyListeners();
    }
  }

  void _handleError(String message) {
    _setError(message);
    AppAlerts.showCustomSnackBar(message, isSuccess: false);
  }
}
