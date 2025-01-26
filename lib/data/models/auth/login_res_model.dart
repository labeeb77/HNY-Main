// To parse this JSON data, do
//
//     final loginResModel = loginResModelFromJson(jsonString);

import 'dart:convert';

LoginResModel loginResModelFromJson(String str) => LoginResModel.fromJson(json.decode(str));

String loginResModelToJson(LoginResModel data) => json.encode(data.toJson());

class LoginResModel {
    bool success;
    String message;
    int statusCode;
    String id;
    String strOtpToken;

    LoginResModel({
        required this.success,
        required this.message,
        required this.statusCode,
        required this.id,
        required this.strOtpToken,
    });

    factory LoginResModel.fromJson(Map<String, dynamic> json) => LoginResModel(
        success: json["success"],
        message: json["message"],
        statusCode: json["statusCode"],
        id: json["_id"],
        strOtpToken: json["strOTPToken"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "statusCode": statusCode,
        "_id": id,
        "strOTPToken": strOtpToken,
    };
}
