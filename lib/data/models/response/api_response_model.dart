class ApiResponseModel<T> {
  final bool success;
  final T? data;
  final String? error;
  final int? statusCode;

  ApiResponseModel({
    required this.success,
    this.data,
    this.error,
    required this.statusCode,
  });

  Map<String, dynamic> toMap() {
    return {
      'success': success,
      'data': data,
      'error': error,
      'statusCode': statusCode,
    };
  }

  factory ApiResponseModel.success(T data, int? statusCode) {
    return ApiResponseModel<T>(success: true, data: data, statusCode: statusCode);
  }

  factory ApiResponseModel.error(String errorMessage, int? statusCode) {
    return ApiResponseModel<T>(
        success: false, error: errorMessage, statusCode: statusCode);
  }
}
