import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hny_main/core/utils/app_alerts.dart';
import 'package:hny_main/core/utils/app_overlays.dart';
import 'package:hny_main/data/models/booking/add_on_list_model.dart';
import 'package:hny_main/data/models/booking/gadgets_model.dart';
import 'package:hny_main/data/models/booking/get_booking_list_model.dart';
import 'package:hny_main/data/models/booking/reservation_item_details_model.dart';
import 'package:hny_main/data/models/response/api_response_model.dart';
import 'package:hny_main/data/models/response/car_list_model.dart';
import 'package:hny_main/data/models/price_calculation.dart';
import 'package:hny_main/data/providers/mycart_provider.dart';
import 'package:hny_main/service/booking_service.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

class BookingProvider extends ChangeNotifier {
  final BookingService _bookingService;

  BookingProvider(BuildContext context)
      : _bookingService = BookingService(context);

  List<BookingArrList> _bookingsListData = [];

  ReservationItemDetailsModel? _reservationDetails;
  ReservationItemDetailsModel? get reservationDetails => _reservationDetails;

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
      ? DateFormat('MMM d, yyyy').format(_startDate!)
      : 'mm/dd/yyyy';

  String get formattedStartTime =>
      _startTime != null ? _formatTimeOfDay(_startTime!) : '00:00 AM';

  String get formattedEndDate => _endDate != null
      ? DateFormat('MMM d, yyyy').format(_endDate!)
      : 'mm/dd/yyyy';

  String get formattedEndTime =>
      _endTime != null ? _formatTimeOfDay(_endTime!) : '00:00 AM';

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

    // Calculate difference in days (add 1 to include both start and end date)
    final difference = end.difference(start);
    int days = difference.inDays + 1;

    // If there's a partial day with hours but not a full day, ensure it counts
    if (difference.inDays == 0 && difference.inHours > 0) {
      days = 1;
    }

    // Ensure minimum of 1 day
    return days > 0 ? days : 1;
  }

  // Calculate total amount based on price per day
  int calculateTotalAmount(
      int pricePerDay, int pricePerWeek, int pricePerMonth) {
    if (totalDays >= 30) {
      // Monthly pricing
      final monthlyPrice = (pricePerMonth / 30) * totalDays;
      return monthlyPrice.toInt();
    } else if (totalDays >= 8) {
      // Weekly pricing
      final weeklyPrice = (pricePerWeek / 7) * totalDays;
      return weeklyPrice.toInt();
    } else {
      // Daily pricing
      final dailyPrice = pricePerDay * totalDays;
      return dailyPrice.toInt();
    }
  }

  // Calculate unit price without multiplying by total days
  double calculateUnitPrice(
      int pricePerDay, int pricePerWeek, int pricePerMonth) {
    if (totalDays >= 30) {
      // Monthly pricing
      return pricePerMonth / 30;
    } else if (totalDays >= 8) {
      // Weekly pricing
      return pricePerWeek / 7;
    } else {
      // Daily pricing
      return pricePerDay.toDouble();
    }
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

  void updateReservationDetails(ReservationItemDetailsModel? data) {
    _reservationDetails = data;
    notifyListeners();
  }

  void updateLocation(String type, String address) {
    if (type == 'Return') {
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
        weeklyPrice: addOn.intPricePerWeek?.toDouble() ?? 0.0,
        monthlyPrice: addOn.intPricePerMonth?.toDouble() ?? 0.0,
        image: addOn.strImageUrl ?? '',
        isQuantityItem: true,
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

    // if (_pickupAddress == 'Select Location' || _dropoffAddress == 'Select Location') {
    //   _handleError("Please select pickup and dropoff locations");
    //   return;
    // }

    final pickupCoords =
        _pickupCoordinates ?? [25.28071250637328, 55.41023254394531];
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
      (sum, gadget) {
        if (gadget.quantity > 0) {
          if (totalDays >= 30) {
            // Monthly pricing
            final monthlyPrice =
                (gadget.monthlyPrice / 30) * totalDays * gadget.quantity;
            return sum + monthlyPrice;
          } else if (totalDays >= 8) {
            // Weekly pricing
            final weeklyPrice =
                (gadget.weeklyPrice / 7) * totalDays * gadget.quantity;
            return sum + weeklyPrice;
          } else {
            // Daily pricing
            final dailyPrice = gadget.price * totalDays * gadget.quantity;
            return sum + dailyPrice;
          }
        }
        return sum;
      },
    );
  }

  // Add a method to calculate individual gadget price
  double calculateGadgetPrice(GadgetModel gadget) {
    if (gadget.quantity <= 0) return 0;

    if (totalDays >= 30) {
      // Monthly pricing
      return (gadget.monthlyPrice / 30) * totalDays * gadget.quantity;
    } else if (totalDays >= 8) {
      // Weekly pricing
      return (gadget.weeklyPrice / 7) * totalDays * gadget.quantity;
    } else {
      // Daily pricing
      return gadget.price * totalDays * gadget.quantity;
    }
  }

  double calculateGadgetUnitPrice(GadgetModel gadget) {
    if (gadget.quantity <= 0) return 0;

    if (totalDays >= 30) {
      // Monthly pricing
      return (gadget.monthlyPrice / 30);
    } else if (totalDays >= 8) {
      // Weekly pricing
      return (gadget.weeklyPrice / 7);
    } else {
      // Daily pricing
      return gadget.price;
    }
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
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Please select trip start and trip end')));
        return false;
      }

      if (_endDate!.isBefore(_startDate!)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Trip end cannot be before the trip start')),
        );
        return false;
      }

      // if (_pickupAddress == 'Select Location' || _dropoffAddress == 'Select Location') {
      //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //     content: Text('Please select pickup and dropoff locations')));
      //   return false;
      // }

      // Use stored coordinates or default ones
      final pickupCoords =
          _pickupCoordinates ?? [25.28071250637328, 55.41023254394531];
      final dropoffCoords = _dropoffCoordinates ?? [25.252777, 55.364445];

      // Create new request payload based on the updated format
      final data = {
        "strItemId": arrCar.id ?? "",
        "strStartDate": _startDate?.toIso8601String(),
        "strEndDate": _endDate?.toIso8601String(),
        "strPickupLocation": {"type": "Point", "coordinates": pickupCoords},
        "strDeliveryLocation": {"type": "Point", "coordinates": dropoffCoords},
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
          Provider.of<MyCartProvider>(context, listen: false).fetchCartItems();
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

  // Calculate final total amount including vehicle and gadgets
  double calculateFinalTotalAmount({
    required int vehicleDailyRate,
    required int vehicleWeeklyRate,
    required int vehicleMonthlyRate,
  }) {
    // Calculate vehicle price
    final vehiclePrice = calculateTotalAmount(
      vehicleDailyRate,
      vehicleWeeklyRate,
      vehicleMonthlyRate,
    ).toDouble();

    // Add gadget prices
    return vehiclePrice + totalGadgetPrice;
  }

  Future<bool> createBooking(
    BuildContext context, {
    required String email,
    required String phoneNumber,
    required double totalVehicleAmount,
    required double totalGadgetsAmount,
    required double payedAmount,
    required double totalFinalAmount,
    required ArrCar carDetails, // Add car details parameter
  }) async {
    _setLoading(true);
    _setError(null);

    try {
      if (_startDate == null || _endDate == null) {
        _handleError('Please select booking dates');
        return false;
      }
      final unitPriceOfCar = calculateUnitPrice(carDetails.intPricePerDay ?? 0,
          carDetails.intPricePerWeek ?? 0, carDetails.intPricePerMonth ?? 0);
          
      log('unitPriceOfCar: $unitPriceOfCar');

      
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
        "intTotalAmount": totalVehicleAmount,
        "intTotalDays": totalDays,
        "intUnitPrice": unitPriceOfCar.toStringAsFixed(2),
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
                "intPricePerMonth":
                    gadget.monthlyPrice, // Assuming monthly price
                "intPricePerWeek": gadget.weeklyPrice, // Assuming weekly price
                "intQty": gadget.quantity,
                "intTotalDays": totalDays,
                "intUnitPrice": calculateUnitPrice(gadget.price.toInt(),
                    gadget.weeklyPrice.toInt(), gadget.monthlyPrice.toInt()).toStringAsFixed(2),
                "intTotalAmount": totalGadgetsAmount,
                "intAvlQty":
                    gadget.quantity, // You might want to get this from the API
                "strDescription": "", // Add description if available
                "StartDate": _startDate?.toIso8601String(),
                "EndDate": _endDate?.toIso8601String(),
              })
          .toList();
log('gadgetItems: $gadgetItems');
      // Combine car and gadget items
      final arrCarItems = [carItem, ...gadgetItems];

      // Prepare booking data
      final bookingData = {
        "strEmail": email,
        "strAltMobileNo": phoneNumber,
        "strPaymentMethod": _selectedPaymentMethod,
        "strPickupLocation": {
          "type": "Point",
          "coordinates": _pickupCoordinates ?? [00.00, 00.00]
        },
        "strPickupLocationAddress": _pickupAddress,
        "strDeliveryLocation": {
          "type": "Point",
          "coordinates": _dropoffCoordinates ?? [00.00, 00.00]
        },
        "strDeliveryLocationAddress": _dropoffAddress,
        "strStartDate": _startDate?.toIso8601String(),
        "strEndDate": _endDate?.toIso8601String(),
        "intTotalDays": totalDays,
        "intTotalDiscount": 0,
        "intTotalAmount": totalFinalAmount,
        "intPayedAmount": _selectedPaymentMethod == "CASH" ? 0 : payedAmount,
        "intCheckoutAmount": totalFinalAmount,
        "intBalanceAmt": totalFinalAmount -
            (_selectedPaymentMethod == "CASH" ? 0 : payedAmount),
        "arrCarItems": arrCarItems,
        "isVatIncluded": true,
      };

      // Call booking API
      log('Booking Data: $bookingData');
      final response = await _bookingService.createBooking(bookingData);

      if (response.success) {
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

  Future<bool> updateBookingLocation(
    BuildContext context, {
    required String locationAddress,
    required List<double> coordinates,
    required String bookingId,
    required String carId,
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

      // Create request body with the correct format
      final locationData = isPickup
          ? {
              "_id": carId,
              "strPickupLocation": {
                "type": "Point",
                "coordinates": coordinates
              },
              "strPickupLocationAddress": locationAddress
            }
          : {
              "_id": carId,
              "strDeliveryLocation": {
                "type": "Point",
                "coordinates": coordinates
              },
              "strDeliveryLocationAddress": locationAddress,
            };

      final response =
          await _bookingService.updateBookingLocation(locationData);

      if (response.success) {
        await getReservationDetails(context, bookingId: bookingId);
        await getBookingList(context);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Booking Location updated successfully!')));
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

  String _activeTab = 'All'; // Default active tab
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

  // Add price calculation method
  PriceCalculation calculateTotalPrice({
    required num dailyRate,
    required num weeklyRate,
    required num monthlyRate,
  }) {
    if (totalDays >= 30) {
      // Monthly pricing
      final monthlyPrice = (monthlyRate / 30) * totalDays;
      return PriceCalculation(
        totalPrice: monthlyPrice.toDouble(),
        priceType: 'Monthly Rate',
      );
    } else if (totalDays >= 8) {
      // Weekly pricing
      final weeklyPrice = (weeklyRate / 7) * totalDays;
      return PriceCalculation(
        totalPrice: weeklyPrice.toDouble(),
        priceType: 'Weekly Rate',
      );
    } else {
      // Daily pricing
      final dailyPrice = dailyRate * totalDays;
      return PriceCalculation(
        totalPrice: dailyPrice.toDouble(),
        priceType: 'Daily Rate',
      );
    }
  }

  // Add price calculation for add-ons
  PriceCalculation calculateAddOnPrice({
    required num price,
    required int quantity,
  }) {
    if (totalDays >= 30) {
      // Monthly pricing for add-ons
      final monthlyPrice = (price * 30 / 30) * totalDays * quantity;
      return PriceCalculation(
        totalPrice: monthlyPrice.toDouble(),
        priceType: 'Monthly Rate',
      );
    } else if (totalDays >= 8) {
      // Weekly pricing for add-ons
      final weeklyPrice = (price * 7 / 7) * totalDays * quantity;
      return PriceCalculation(
        totalPrice: weeklyPrice.toDouble(),
        priceType: 'Weekly Rate',
      );
    } else {
      // Daily pricing for add-ons
      final dailyPrice = price * totalDays * quantity;
      return PriceCalculation(
        totalPrice: dailyPrice.toDouble(),
        priceType: 'Daily Rate',
      );
    }
  }

  Future<bool> updateBookingDates(
    BuildContext context, {
    required String bookingId,
    required String startDate,
    required String endDate,
  }) async {
    _setLoading(true);
    _setError(null);

    try {
      final ApiResponseModel<dynamic> response =
          await _bookingService.updateBookingDate({
        "_id": bookingId,
        "strNewStartDate": startDate,
        "strNewEndDate": endDate,
      });

      if (response.success) {
        // Refresh the booking list after successful update
        await getBookingList(context);
        await getReservationDetails(context, bookingId: bookingId);
        return true;
      } else {
        _setError(response.error ?? 'Failed to update dates');
        return false;
      }
    } catch (e) {
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<Map<String, dynamic>?> createPayment(
    BuildContext context, {
    required String bookingId,
    required double amount,
    required String strBookingId,
    String? strAltMobileNo,
  }) async {
    _setError(null);

    try {
      final Map<String, dynamic> paymentData = {
        "intPayedAmount": amount,
        "strBookingId": strBookingId,
        "strBooking_Id": bookingId,
        "strPaymentMode": "TAP_LINK",
        "strPaymentRecievedBy": "COMPANY_BANK",
        "isDirectLink": true
      };
      if (strAltMobileNo != null && strAltMobileNo.isNotEmpty) {
        paymentData["strAltMobileNo"] = strAltMobileNo;
      }

      final ApiResponseModel<dynamic> response =
          await _bookingService.createPayment(paymentData);

      if (response.success) {
        log(response.data.toString());
        await getBookingList(context);
        await getReservationDetails(context, bookingId: bookingId);
        final mobileNo = response.data['strMobileNo'] ?? '';
        final paymentLink = response.data['short_url'] ?? '';
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (ctx) => AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.check_circle, color: Colors.green, size: 60),
                const SizedBox(height: 18),
                const Text(
                  'A payment link has been successfully sent to',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  '+$mobileNo',
                  style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 18),
                if (paymentLink != '' && paymentLink != null)
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('You can also access it directly '),
                    ],
                  ),
                GestureDetector(
                  onTap: () async {
                    await launchUrl(Uri.parse(paymentLink));
                  },
                  child: const Text(
                    'click here',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                    Navigator.of(ctx).pop();
                  },
                  child: const Text('Close',
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ),
            ],
          ),
        );
        return response.data;
      } else {
        _handleError(response.error ?? 'Failed to create payment');
        return null;
      }
    } catch (e) {
      _setError(e.toString());
      return null;
    }
  }

  Future<void> getReservationDetails(BuildContext context,
      {required String bookingId}) async {
    _setLoading(true);
    _setError(null);

    try {
      final response = await _bookingService.getReservationItemDetails({
        "_id": bookingId,
      });

      if (response.success && response.data != null) {
        log('Reservation Details Response: ${response.data}');
        // Create ReservationItemDetailsModel directly from the response data
        final reservationDetails =
            ReservationItemDetailsModel.fromJson(response.data);
        updateReservationDetails(reservationDetails);
      } else {
        _handleError(response.error ?? "Failed to fetch booking details");
        updateReservationDetails(null);
      }
    } catch (e) {
      log('Error in getReservationDetails: $e');
      _handleError("An unexpected error occurred");
      updateReservationDetails(null);
    } finally {
      _setLoading(false);
    }
  }
}
