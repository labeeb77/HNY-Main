// lib/utils/upload/file_upload_web.dart
// Only import this file in Flutter Web builds
import 'dart:html' as html;
import 'dart:typed_data';
import 'package:dio/dio.dart';

Future<FormData> createFormData(String imagePath) async {
  final fileBytes = await html.HttpRequest.request(imagePath,
      method: 'GET', responseType: 'arraybuffer').then((res) => res.response as ByteBuffer);

  final multipartFile = MultipartFile.fromBytes(
    fileBytes.asUint8List(),
    filename: imagePath.split("/").last,
  );

  return FormData.fromMap({"arrFiles": multipartFile});
}
