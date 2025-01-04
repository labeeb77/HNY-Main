class FileUploadResponse {
  final bool success;
  final String message;
  final int statusCode;
  final List<String> arrUrls;

  FileUploadResponse({
    required this.success,
    required this.message,
    required this.statusCode,
    required this.arrUrls,
  });

  factory FileUploadResponse.fromJson(Map<String, dynamic> json) {
    return FileUploadResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      statusCode: json['statusCode'] ?? 0,
      arrUrls: List<String>.from(json['arrUrls'] ?? []),
    );
  }
}