// lib/utils/upload/file_upload_io.dart
import 'package:dio/dio.dart';

Future<FormData> createFormData(String imagePath) async {
  final multipartFile = await MultipartFile.fromFile(imagePath);
  return FormData.fromMap({"arrFiles": multipartFile});
}
