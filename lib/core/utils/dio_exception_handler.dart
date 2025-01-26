import 'package:dio/dio.dart';
import 'package:hny_main/core/utils/app_alerts.dart';

class DioExceptionHandler {
  final DioExceptionType type;
  final String? message;
  final Response? response;

  DioExceptionHandler({
    required this.type,
    this.message,
    this.response,
  }) {
    // Add method body here if needed
  }

  static handleDioError(DioException e) {
    String errorMessage;

    switch (e.type) {
      case DioExceptionType.cancel:
        errorMessage = "Request was cancelled";
        break;
      case DioExceptionType.connectionTimeout:
        errorMessage = "Connection timeout occurred";
        AppAlerts.appToast(errorMessage);
        break;
      case DioExceptionType.receiveTimeout:
        errorMessage = "Receive timeout occurred";
        AppAlerts.appToast(errorMessage);
        break;
      case DioExceptionType.sendTimeout:
        errorMessage = "Send timeout occurred";
        break;
      case DioExceptionType.badResponse:
        errorMessage =
            "Received invalid status code: ${e.response?.statusCode}";
        break;
      case DioExceptionType.unknown:
        if (e.message?.contains('SocketException') ?? false) {
          errorMessage = "No internet connection";
        } else if (e.message?.contains('HandshakeException') ?? false) {
          errorMessage = "Handshake exception occurred";
        } else {
          errorMessage = "An unexpected error occurred";
        }
        AppAlerts.appToast(errorMessage);
        break;
      default:
        errorMessage = "Something went wrong";
        AppAlerts.appToast(errorMessage);
        break;
    }

    // Show the error message to the user using a SnackBar, Dialog, etc.
  }
}
