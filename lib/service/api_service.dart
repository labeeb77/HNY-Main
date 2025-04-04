import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hny_main/core/constants/api_constants.dart';
import 'package:hny_main/core/global/profile.dart';
import 'package:hny_main/core/helpers/route_arguments.dart';
import 'package:hny_main/core/utils/dio_exception_handler.dart';
import 'package:hny_main/data/models/response/api_response_model.dart';
import 'package:hny_main/view/widgets/no_internet_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  Dio dio = Dio();

  ApiService(BuildContext context) {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        var connectivityResult = await (Connectivity().checkConnectivity());
        if (connectivityResult.contains(ConnectivityResult.none)) {
          showNoInternetDialog(context, NoInternetArguments(onRetry: () {
            Navigator.of(context).pop();
          }));
          return handler.reject(
              DioException(
                requestOptions: options,
                error: 'No Internet Connection',
              ),
              true);
        }

        return handler.next(options);
      },
      onError: (DioException error, handler) async {
        _handleError(error);
        return handler.next(error);
      },
    ));
    dio.options.connectTimeout = const Duration(minutes: 5);
    dio.options.receiveTimeout = const Duration(minutes: 5);
    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      requestBody: true,
    ));
  }

  void _handleError(Object error) {
    if (error is DioException) {
      DioExceptionHandler.handleDioError(error);
      if (kDebugMode) {
        debugPrint('DioException occurred: ${error.message}');
      }
    } else {
      if (kDebugMode) {
        debugPrint('Unknown error occurred: $error');
      }
    }
  }

  Future<ApiResponseModel<dynamic>> apiCall(
      {required String endpoint,
      required String method,
      dynamic data,
      Map<String, dynamic>? queryParams,
      Function(Object)? onError,
      Function(DioException)? onCustomErrorHandling,
      bool showErrorMessage = true,
      bool sendToken = true}) async {
    try {
      dio.options.baseUrl = ApiConstants.baseUrl2;
      Response response = await _handleHttpRequest(
        endpoint: endpoint,
        method: method,
        data: data,
        queryParams: queryParams,
        sendToken: sendToken,
      );

      return _handleResponse(response);
    } on DioException catch (e) {
      if (onCustomErrorHandling != null) {
        onCustomErrorHandling(e);
      } else {
        DioExceptionHandler.handleDioError(e);
      }
      if (e.response != null) {
        return ApiResponseModel.error(
            e.response!.data['message'].toString(), e.response?.statusCode);
      } else {
        return ApiResponseModel.error(e.toString(), e.response?.statusCode);
      }
    } catch (e) {
      if (onError != null) {
        onError(e);
      } else {
        _handleError(e.toString());
      }
      return ApiResponseModel.error(e.toString(), 500);
    }
  }

  Future<Response> _handleHttpRequest({
    required String endpoint,
    required String method,
    dynamic data,
    Map<String, dynamic>? queryParams,
    bool sendToken = false,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');
    log('Token: $token');
    if (currentUserId == "") {
      currentUserId = prefs.getString('userId') ?? "";
    }
    Options options = Options(
      headers: {
        'Authorization': token,
        'Content-Type': 'application/json',
      },
    );
    switch (method.toUpperCase()) {
      case 'GET':
        return await dio.get(
          endpoint,
          queryParameters: queryParams,
          options: sendToken ? options : null,
        );
      case 'POST':
        return await dio.post(endpoint,
            queryParameters: queryParams,
            data: data,
            options: sendToken ? options : null,
            onSendProgress: (int sent, int total) {
          debugPrint('sent: $sent, total: $total');
           debugPrint('data: $data');
        });
      case 'POSTFILE':
        options.contentType = 'multipart/form-data';
        return await dio.post(endpoint,
            data: data, options: sendToken ? options : null, onSendProgress: (
          int sent,
          int total,
        ) {
          debugPrint('sent: $sent, total: $total');
        });
      case 'PUT':
        return await dio.put(endpoint,
            queryParameters: queryParams,
            data: data,
            options: sendToken ? options : null);
      case 'DELETE':
        return await dio.delete(
          endpoint,
          queryParameters: queryParams,
          options: sendToken ? options : null,
        );
      case 'PATCH':
        return await dio.patch(
          endpoint,
          data: data,
          options: sendToken ? options : null,
        );
      default:
        throw Exception("Something went wrong server not responding");
    }
  }

  ApiResponseModel _handleResponse(Response response) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      return ApiResponseModel.success(response.data, response.statusCode);
    } else {
      return ApiResponseModel.error(
          response.data['message'] ?? response.data.toString(),
          response.statusCode);
    }
  }
}
