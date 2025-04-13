// lib/utils/upload/web_file_upload.dart

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
