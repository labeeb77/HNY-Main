import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hny_main/core/utils/app_alerts.dart';
import 'package:hny_main/data/models/car_typelist/car_typelist.dart';
import 'package:hny_main/data/models/response/car_list_model.dart';
import 'package:hny_main/service/home_serveice.dart';
import 'package:intl/intl.dart';

class HomeController extends ChangeNotifier {
  final HomeService _homeService;
callNot(){
  notifyListeners();
}
  List<ArrCar> _carListData = [];
  List<ArrTypeList> _carTypeListData = [];

  bool _isLoading = false;
  bool _isFilterOn = false;
  String? _error;
  String? searchQuery = '';
  RangeValues currentRangeValues = const RangeValues(30, 50);
  RangeValues defaultRangeValues = const RangeValues(30, 50);
  Set<String> selectedCarTypeIds = {};

  HomeController(BuildContext context) : _homeService = HomeService(context);

  DateTime? selecteStratdDate;
  String? selectedDateTOString;

  TimeOfDay? selectedStartTime;
  String? selectedStartTimeString;

  TimeOfDay? selectedEndTime;
  String? selectedEndTimeString;

  DateTime? selecteEnddDate;
  String? selectedEndTOString;

  bool get isFilterOn => _isFilterOn || 
      currentRangeValues != defaultRangeValues || 
      selectedCarTypeIds.isNotEmpty;

  void setSelectedStartDate(DateTime? date) {
    if (date == null) {
      selectedDateTOString = null;
      selecteStratdDate = null;
      selectedStartTime = null;
      selectedStartTimeString = null;
    } else {
    selectedDateTOString = DateFormat('MMM d, y\nh:mm a').format(date);
    selecteStratdDate = date;
    selectedStartTime = TimeOfDay.fromDateTime(date);
    selectedStartTimeString = DateFormat('hh:mm a').format(date);
    }
    log(selectedDateTOString.toString());
    notifyListeners();
  }

  void setSelectedEndtDate(DateTime? date) {
    if (date == null) {
      selectedEndTOString = null;
      selecteEnddDate = null;
      selectedEndTime = null;
      selectedEndTimeString = null;
    } else {
    selectedEndTOString = DateFormat('MMM d, y\nh:mm a').format(date);
    selecteEnddDate = date;
    selectedEndTime = TimeOfDay.fromDateTime(date);
    selectedEndTimeString = DateFormat('hh:mm a').format(date);
    }
    log(selectedDateTOString.toString());
    notifyListeners();
  }

  void filterWithDate() {}

  void _updateFilterState() {
    _isFilterOn = currentRangeValues != defaultRangeValues || 
        selectedCarTypeIds.isNotEmpty;
    notifyListeners();
  }

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
    _updateFilterState();
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
    _updateFilterState();
    notifyListeners();
  }

  void toggleCarType(ArrTypeList carType) {
    if (carType.id == null) return;

    if (selectedCarTypeIds.contains(carType.id)) {
      selectedCarTypeIds.remove(carType.id);
    } else {
      selectedCarTypeIds.add(carType.id!);
    }
    _updateFilterState();
    notifyListeners();
  }

  // Updated method to check if a car type is selected
  bool isCarTypeSelected(ArrTypeList carType) {
    log(carType.toString());
    return carType.id != null && selectedCarTypeIds.contains(carType.id);
  }

  void clearCarTypes() {
    selectedCarTypeIds.clear();
    _updateFilterState();
    notifyListeners();
  }

  void clearAllFilters(BuildContext context) {
    currentRangeValues = defaultRangeValues;
    selectedCarTypeIds.clear();
    _isFilterOn = false;
    getCarDataList(context: context,startDate: selecteStratdDate,endDate: selecteEnddDate);
    notifyListeners();
  }

  Future<void> getCarDataList(
      {required BuildContext context, startDate, endDate, search}) async {
    _setLoading(true);
    _setError(null);

    try {
      final data = await _homeService.fetchCarDataList(
          end: endDate, start: startDate, search: search);

      if (data != null) {
        _updateCarList(data.arrCars ?? []);
        // Update isFilterOn based on whether any filter is applied
        _isFilterOn = search != null && search.isNotEmpty;
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
        log(data.arrList?.first.strImgUrl ?? 'assets/images/placeholder_image.webp',name: 'car type list');
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
