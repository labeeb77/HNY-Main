import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hny_main/core/constants/api_constants.dart';
import 'package:hny_main/data/models/booking/add_on_list_model.dart';
import 'package:hny_main/data/models/booking/get_booking_list_model.dart';
import 'package:hny_main/data/models/booking/reservation_item_details_model.dart';
import 'package:hny_main/data/models/response/api_response_model.dart';
import 'package:hny_main/service/api_service.dart';

class BookingService {
  final ApiService _apiService;

  BookingService(BuildContext context) : _apiService = ApiService(context);

  // New method to fetch add on list
  Future<GetAddOnListModel?> fetchAddOnList() async {
    try {
      ApiResponseModel<dynamic> apiResponse = await _apiService.apiCall(
          endpoint: ApiConstants.getAddOnList,
          method: 'POST',
          data: {},
          sendToken: true);

      if (apiResponse.success && apiResponse.data != null) {
        return GetAddOnListModel.fromJson(apiResponse.data);
      }
      return null;
    } catch (e) {
      debugPrint('Error fetching add on list: $e');
      return null;
    }
  }

  Future<BookingsListModel?> fetchBookingList(
      {Map<String, dynamic>? filters}) async {
    try {
      Map<String, dynamic> requestData = {};

      // Add filters if provided
      if (filters != null) {
        requestData = filters;
      }

      ApiResponseModel<dynamic> apiResponse = await _apiService.apiCall(
          endpoint: ApiConstants.getBookingListUrl,
          method: 'POST',
          data: requestData,
          sendToken: true);

      if (apiResponse.success && apiResponse.data != null) {
        log('fetchBookingList : ${apiResponse.data}');
        return BookingsListModel.fromJson(apiResponse.data);
      }
      return null;
    } catch (e) {
      debugPrint('Error fetching booking list: $e');
      return null;
    }
  }

  Future<ApiResponseModel> createCart(Map<String, dynamic> cartData) async {
    return await _apiService.apiCall(
        endpoint: ApiConstants.createCart,
        method: 'POST',
        data: cartData,
        sendToken: true);
  }

  Future<ApiResponseModel> updateCart(Map<String, dynamic> cartData) async {
    return await _apiService.apiCall(
        endpoint: ApiConstants.updateCart,
        method: 'POST',
        data: cartData,
        sendToken: true);
  }

  Future<ApiResponseModel> createInvoice(String bookingId) async {
    return await _apiService.apiCall(
        endpoint: ApiConstants.saveInvoice,
        method: 'POST',
        data: {"_id": bookingId},
        sendToken: true);
  }

  Future<ApiResponseModel> createBooking(
      Map<String, dynamic> bookingData) async {
    return await _apiService.apiCall(
        endpoint: ApiConstants.createReservation,
        method: 'POST',
        data: bookingData,
        sendToken: true);
  }

  Future<ApiResponseModel> updateBookingLocation(
      Map<String, dynamic> bookingData) async {
    return await _apiService.apiCall(
        endpoint: ApiConstants.updateBookingLocation,
        method: 'POST',
        data: bookingData,
        sendToken: true);
  }

    Future<ApiResponseModel> updateBookingDate(
      Map<String, dynamic> date) async {
    return await _apiService.apiCall(
        endpoint: ApiConstants.dateChange,
        method: 'POST',
        data: date,
        sendToken: true);
  }

      Future<ApiResponseModel> createPayment(
      Map<String, dynamic> date) async {
    return await _apiService.apiCall(
        endpoint: ApiConstants.createPayment,
        method: 'POST',
        data: date,
        sendToken: true);
  }

  Future<ApiResponseModel> getReservationItemDetails(reservationData) async {
    return await _apiService.apiCall(
        endpoint: ApiConstants.getReservationItemDetails,
        method: 'POST',
        data: reservationData,
        sendToken: true);
  }
}
