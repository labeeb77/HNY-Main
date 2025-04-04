import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hny_main/core/utils/app_alerts.dart';
import 'package:hny_main/core/utils/app_colors.dart';
import 'package:hny_main/core/utils/app_overlays.dart';
import 'package:hny_main/data/models/booking/add_on_list_model.dart';
import 'package:hny_main/data/models/booking/gadgets_model.dart';
import 'package:hny_main/data/models/booking/get_booking_list_model.dart';
import 'package:hny_main/data/models/response/api_response_model.dart';
import 'package:hny_main/data/models/response/car_list_model.dart';
import 'package:hny_main/service/booking_service.dart';
import 'package:hny_main/view/screens/sub/car_details_screen/widgets/add_gadget_bottomsheet.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

class BookingProvider extends ChangeNotifier {
  final BookingService _bookingService;

  BookingProvider(BuildContext context)
      : _bookingService = BookingService(context);

  List<BookingArrList> _bookingsListData = [];

  //Bookings Getters
  List<BookingArrList> get bookingsListData => _bookingsListData;

  String _pickupAddress = 'Select Location';
  String _dropoffAddress = 'Select Location';

  DateTime? _startDate;
  TimeOfDay? _startTime;
  DateTime? _endDate;
  TimeOfDay? _endTime;

  // Location Getters
  String get pickupAddress => _pickupAddress;
  String get dropoffAddress => _dropoffAddress;

  List<double>? get pickupCoordinates => _pickupCoordinates;
  List<double>? get dropoffCoordinates => _dropoffCoordinates;

  // Add location coordinates
  List<double>? _pickupCoordinates;
  List<double>? _dropoffCoordinates;

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

  // Calculate total days
  int get totalDays {
    if (_startDate == null || _endDate == null) {
      return 1; // Default to 1 day if dates not selected
    }

    // Create DateTime objects with times if available
    final start = DateTime(
      _startDate!.year,
      _startDate!.month,
      _startDate!.day,
      _startTime?.hour ?? 0,
      _startTime?.minute ?? 0,
    );

    final end = DateTime(
      _endDate!.year,
      _endDate!.month,
      _endDate!.day,
      _endTime?.hour ?? 0,
      _endTime?.minute ?? 0,
    );

    // Calculate difference in days
    final difference = end.difference(start);
    int days = difference.inDays;

    // If there's a partial day, round up
    if (difference.inHours % 24 > 0) {
      days += 1;
    }

    // Ensure minimum of 1 day
    return days > 0 ? days : 1;
  }

  // Calculate total amount based on price per day
  int calculateTotalAmount(int pricePerDay) {
    return pricePerDay * totalDays;
  }

  

  // Location update methods
  void updatePickupAddress(String address) {
    _pickupAddress = address;
    notifyListeners();
  }

  void updateDropoffAddress(String address) {
    _dropoffAddress = address;
    notifyListeners();
  }

  void updateBookingList(List<BookingArrList> data) {
    _bookingsListData = data;
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
        initializeGadgets(data.arrList!); // Initialize gadgets
      } else {
        _handleError("Failed to addon data");
      }
    } catch (e) {
      _handleError("An unexpected error occurred");
    } finally {
      _setLoading(false);
    }
  }

  // Gadget Adding For ADD ON
  List<GadgetModel> _gadgets = [];
  List<GadgetModel> get gadgets => _gadgets;

  // Initialize gadgets from API data
  void initializeGadgets(List<AddOnArrList> addOnList) {
    _gadgets = addOnList.map((addOn) {
      return GadgetModel(
        id: addOn.id ?? '',
        name: addOn.strName ?? '',
        price: addOn.intPricePerDay?.toDouble() ?? 0.0,
        image: addOn.strImageUrl ?? '',
        isQuantityItem: true, // Assuming all gadgets are quantity items
      );
    }).toList();
    notifyListeners();
  }

  // Update gadget quantity
void updateGadgetQuantity(String id, int quantity) async {
  final gadget = _gadgets.firstWhere((g) => g.id == id);
  final prevQuantity = gadget.quantity;

  gadget.quantity = quantity;
  notifyListeners();

  if (_startDate == null || _endDate == null) {
    _handleError("Please select booking dates");
    return;
  }

  if (_pickupAddress == 'Select Location' || _dropoffAddress == 'Select Location') {
    _handleError("Please select pickup and dropoff locations");
    return;
  }

  final pickupCoords = _pickupCoordinates ?? [25.28071250637328, 55.41023254394531];
  final dropoffCoords = _dropoffCoordinates ?? [25.252777, 55.364445];

  if (prevQuantity == 0 && quantity > 0) {
    // 👉 Call createCart
    final data = {
      "strItemId": id,
      "strStartDate": _startDate?.toIso8601String(),
      "strEndDate": _endDate?.toIso8601String(),
      "strPickupLocation": {
        "type": "Point",
        "coordinates": pickupCoords,
      },
      "strDeliveryLocation": {
        "type": "Point",
        "coordinates": dropoffCoords,
      },
      "strPickupLocationAddress": _pickupAddress,
      "strDeliveryLocationAddress": _dropoffAddress,
    };
    log('add gadget to cart data: $data');

    final response = await _bookingService.createCart(data);
    if (response.success) {
      log('add gadget to cart response: ${response.data}');
      final cartItemId = response.data['_id'];
      if (cartItemId != null) {
        gadget.cartItemId = cartItemId; // 💾 store _id for updates
      }
    } else {
      _handleError("Failed to add gadget to cart");
    }

  } else if (prevQuantity > 0 && quantity >= 0) {
    if (gadget.cartItemId == null) {
      _handleError("Cart item ID not found for gadget. Please try again.");
      return;
    }

    // 👉 Call updateCart
    final data = {
      "_id": gadget.cartItemId, // ✅ use stored cartItemId
      "intCount": quantity,
      "strStartDate": _startDate?.toIso8601String(),
      "strEndDate": _endDate?.toIso8601String(),
      "strPickupLocation": {
        "type": "Point",
        "coordinates": pickupCoords,
      },
      "strDeliveryLocation": {
        "type": "Point",
        "coordinates": dropoffCoords,
      },
      "strPickupLocationAddress": _pickupAddress,
      "strDeliveryLocationAddress": _dropoffAddress,
    };
    log('update gadget in cart data: $data');

    final response = await _bookingService.updateCart(data);
    if (response.success) {
      log('update gadget in cart response: ${response.data}');
    } else {
      _handleError("Failed to update gadget in cart");
    }
  }
}


  // Calculate total price of selected gadgets
  double get totalGadgetPrice {
    return _gadgets.fold(
      0,
      (sum, gadget) => sum + (gadget.quantity * gadget.price),
    );
  }

  // Calculate total number of selected gadgets
  int get totalGadgetItems {
    return _gadgets.fold(
      0,
      (sum, gadget) => sum + gadget.quantity,
    );
  }

  void _handleError(String message) {
    _setError(message);
    AppAlerts.showCustomSnackBar(message, isSuccess: false);
  }

  // Create Cart

Future<bool> createCart(BuildContext context, ArrCar arrCar) async {
  _setLoading(true);
  _setError(null);
  try {
    // Validate required fields
    if (_startDate == null || _endDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select start and end dates')));
      return false;
    }
    
    if (_endDate!.isBefore(_startDate!)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('End date cannot be before the start date')),
      );
      return false;
    }
    
    if (_pickupAddress == 'Select Location' ||
        _dropoffAddress == 'Select Location') {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please select pickup and dropoff locations')));
      return false;
    }
    
    // Use stored coordinates or default ones
    final pickupCoords =
        _pickupCoordinates ?? [25.28071250637328, 55.41023254394531];
    final dropoffCoords = _dropoffCoordinates ?? [25.252777, 55.364445];
    
    // Create new request payload based on the updated format
    final data = {
      "strItemId": arrCar.id ?? "",
      "strStartDate": _startDate?.toIso8601String(),
      "strEndDate": _endDate?.toIso8601String(),
      "strPickupLocation": {
        "type": "Point", 
        "coordinates": pickupCoords
      },
      "strDeliveryLocation": {
        "type": "Point", 
        "coordinates": dropoffCoords
      },
      "strPickupLocationAddress": _pickupAddress,
      "strDeliveryLocationAddress": _dropoffAddress
    };
    
    // Call API
    final response = await _bookingService.createCart(data);
    if (response.success) {
      // Show success message
   if (response.success) {
  // Show custom animation instead of SnackBar
  showSuccessAnimation(context);
  return true;
}
      return true;
    } else {
      _handleError('Failed to create cart');
      return false;
    }
  } catch (e) {
    _handleError(e.toString());
    return false;
  } finally {
    _setLoading(false);
  }
}


Future<void> downloadInvoice(BuildContext context, String bookingId) async {
  _setLoading(true);
  _setError(null);
  
  try {
    final response = await _bookingService.createInvoice(bookingId);
    
    if (response.success && response.data != null) {
      final invoiceUrl = response.data['invoice'];
      
      if (invoiceUrl != null) {
        // Launch URL to download PDF
        final result = await launchUrl(
          Uri.parse(invoiceUrl),
          mode: LaunchMode.externalApplication,
        );
        
        if (!result) {
          _handleError("Could not launch invoice URL");
        }
      } else {
        _handleError("Invoice URL not found in response");
      }
    } else {
      _handleError("Failed to generate invoice");
    }
  } catch (e) {
    _handleError("An error occurred while downloading the invoice");
  } finally {
    _setLoading(false);
  }
}

// Create Booking

  String _selectedPaymentMethod = "TAP_LINK";
  String get selectedPaymentMethod => _selectedPaymentMethod;

  void updatePaymentMethod(String method) {
    if (_selectedPaymentMethod != method) {
      _selectedPaymentMethod = method;
      notifyListeners();
    }
  }

  Future<bool> createBooking(
    BuildContext context, {
    required String email,
    required String phoneNumber,
    required double amount,
    required ArrCar carDetails, // Add car details parameter
  }) async {
    _setLoading(true);
    _setError(null);

    try {


      if (_startDate == null || _endDate == null) {
        _handleError('Please select booking dates');
        return false;
      }

      // Create car item
      final carItem = {
        "strImgUrl": carDetails.strImgUrl ?? "",
        "strCarNumber": carDetails.strCarNumber ?? "",
        "strModel": carDetails.strModel ?? "",
        "intPricePerDay": carDetails.intPricePerDay ?? 0,
        "StartDate": _startDate?.toIso8601String(),
        "EndDate": _endDate?.toIso8601String(),
        "intPricePerWeek": carDetails.intPricePerWeek ?? 0,
        "intPricePerMonth": carDetails.intPricePerMonth ?? 0,
        "intTotalAmount": calculateTotalAmount(carDetails.intPricePerDay?.toInt() ?? 0),
        "intTotalDays": totalDays,
        "intUnitPrice": carDetails.intPricePerDay ?? 0,
        "strCarId": carDetails.id ?? "",
        "_id": const Uuid().v4(),
        "type": "CAR",
        "strPickupLocation": {
          "type": "Point",
          "coordinates":
              _pickupCoordinates ?? [25.28071250637328, 55.41023254394531]
        },
        "strPickupLocationAddress": _pickupAddress,
        "strDeliveryLocation": {
          "type": "Point",
          "coordinates": _dropoffCoordinates ?? [25.252777, 55.364445]
        },
        "strDeliveryLocationAddress": _dropoffAddress,
      };

      // Create gadget items (add-ons)
      final gadgetItems = _gadgets
          .where((gadget) => gadget.quantity > 0)
          .map((gadget) => {
                "strImgUrl": gadget.image,
                "strName": gadget.name,
                "_id": gadget.id,
                "type": "ADD_ON",
                "intPricePerDay": gadget.price,
                "intPricePerMonth": gadget.price * 30, // Assuming monthly price
                "intPricePerWeek": gadget.price * 7, // Assuming weekly price
                "intQty": gadget.quantity,
                "intTotalDays": totalDays,
                "intUnitPrice": gadget.price,
                "intTotalAmount": gadget.price * gadget.quantity * totalDays,
                "intAvlQty": 10, // You might want to get this from the API
                "strDescription": "", // Add description if available
                "StartDate": _startDate?.toIso8601String(),
                "EndDate": _endDate?.toIso8601String(),
              })
          .toList();

      // Combine car and gadget items
      final arrCarItems = [carItem, ...gadgetItems];

      // Prepare booking data
      final bookingData = {
        "strEmail": email,
        "strAltMobileNo": phoneNumber,
        "strPaymentMethod": _selectedPaymentMethod,
        "strPickupLocation": {
          "type": "Point",
          "coordinates":
              _pickupCoordinates ?? [25.28071250637328, 55.41023254394531]
        },
        "strPickupLocationAddress": _pickupAddress,
        "strDeliveryLocation": {
          "type": "Point",
          "coordinates": _dropoffCoordinates ?? [25.252777, 55.364445]
        },
        "strDeliveryLocationAddress": _dropoffAddress,
        "strStartDate": _startDate?.toIso8601String(),
        "strEndDate": _endDate?.toIso8601String(),
        "intTotalDays": totalDays,
        "intTotalDiscount": 0,
        "intTotalAmount": amount,
        "intPayedAmount": amount,
        "intCheckoutAmount": 0,
        "intBalanceAmt": 0,
        "arrCarItems": arrCarItems, // Add the combined items array
      };

      // Call booking API
      log('Booking Data: $bookingData');
      final response = await _bookingService.createBooking(bookingData);

      if (response.success) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Booking created successfully!')));
        return true;
      } else {
        _handleError('Failed to create booking');
        return false;
      }
    } catch (e) {
      _handleError('An error occurred while creating the booking');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> updateBooking(
    BuildContext context, {
    required String locationAddress,
    required List<double> coordinates,
    required String bookingId,
    required bool isPickup,
  }) async {
    _setLoading(true);
    _setError(null);

    try {
      // Validate required fields
      if (bookingId.isEmpty || locationAddress.isEmpty) {
        _handleError('Location Address not found!');
        return false;
      }

      // Create car item
      final locationData = {
        "_id": "67b4b5495e0f5fb01f00dcb0",
        isPickup ? "strPickupLocation" : 'strDeliveryLocation': {
          "type": "Point",
          "coordinates": [coordinates[0], coordinates[1]]
        },
        isPickup ? "strPickupLocationAddress" : 'strDeliveryLocationAddress':
            locationAddress
      };

      final response =
          await _bookingService.updateBookingLocation(locationData);

      if (response.success) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Booking updated successfully!')));
        return true;
      } else {
        _handleError('Failed to update booking');
        return false;
      }
    } catch (e) {
      _handleError('An error occurred while updating the booking');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  String _activeTab = 'Upcoming'; // Default active tab
  String get activeTab => _activeTab;

  Future<void> getBookingList(BuildContext context,
      {Map<String, dynamic>? filters}) async {
        log("Booking List called");
    _setLoading(true);
    _setError(null);

    try {
      // Add filters to the request
      final data = await _bookingService.fetchBookingList(filters: filters);
      if (data != null) {
        updateBookingList(data.arrList!);
        notifyListeners();
      } else {
        _handleError("Failed to fetch booking data");
      }
    } catch (e) {
      _handleError("An unexpected error occurred");
    } finally {
      _setLoading(false);
    }
  }

  // Add a method to update the active tab
  void updateActiveTab(String tab) {
    _activeTab = tab;
    notifyListeners();
  }


// Then in your createCart function, replace the SnackBar with:

}
