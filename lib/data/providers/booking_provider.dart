import 'package:flutter/material.dart';
import 'package:hny_main/core/utils/app_alerts.dart';
import 'package:hny_main/data/models/booking/add_on_list_model.dart';
import 'package:hny_main/service/booking_service.dart';
import 'package:intl/intl.dart';

class BookingProvider extends ChangeNotifier {
  final BookingService _bookingService;

  BookingProvider(BuildContext context)
      : _bookingService = BookingService(context);

  String _pickupAddress = 'Select Location';
  String _dropoffAddress = 'Select Location';

  DateTime? _startDate;
  TimeOfDay? _startTime;
  DateTime? _endDate;
  TimeOfDay? _endTime;

  // Location Getters
  String get pickupAddress => _pickupAddress;
  String get dropoffAddress => _dropoffAddress;

  // DateTime Getters
  DateTime? get startDate => _startDate;
  TimeOfDay? get startTime => _startTime;
  DateTime? get endDate => _endDate;
  TimeOfDay? get endTime => _endTime;

  List<AddOnArrList> _addOnArrList = []; //
  List<AddOnArrList> get addOnArrList => _addOnArrList;

  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;
  String? get error => _error;

  // Formatted getters for display
  String get formattedStartDate => _startDate != null
      ? DateFormat('MMMM d, yyyy').format(_startDate!)
      : 'mm/dd/yyyy';

  String get formattedStartTime =>
      _startTime != null ? _formatTimeOfDay(_startTime!) : '00:00 AM';

  String get formattedEndDate => _endDate != null
      ? DateFormat('MMMM d, yyyy').format(_endDate!)
      : 'mm/dd/yyyy';

  String get formattedEndTime =>
      _endTime != null ? _formatTimeOfDay(_endTime!) : '00:00 AM';

  // Location update methods
  void updatePickupAddress(String address) {
    _pickupAddress = address;
    notifyListeners();
  }

  void updateDropoffAddress(String address) {
    _dropoffAddress = address;
    notifyListeners();
  }

  void updateLocation(String type, String address) {
    if (type == 'Pick-Up') {
      updatePickupAddress(address);
    } else {
      updateDropoffAddress(address);
    }
  }

  // DateTime update methods
  void updateStartDate(DateTime date) {
    _startDate = date;
    notifyListeners();
  }

  void updateStartTime(TimeOfDay time) {
    _startTime = time;
    notifyListeners();
  }

  void updateEndDate(DateTime date) {
    _endDate = date;
    notifyListeners();
  }

  void updateEndTime(TimeOfDay time) {
    _endTime = time;
    notifyListeners();
  }

  String _formatTimeOfDay(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat('hh:mm a').format(dt);
  }

  // Private Methods
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? value) {
    _error = value;
    notifyListeners();
  }

  void _updateAddOnList(List<AddOnArrList> data) {
    _addOnArrList = data;
    notifyListeners();
  }

  Future<void> getAddOnList(BuildContext context) async {
    _setLoading(true);
    _setError(null);

    try {
      final data = await _bookingService.fetchAddOnList();
      if (data != null) {
        _updateAddOnList(data.arrList!);
      } else {
        _handleError("Failed to addon data");
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
