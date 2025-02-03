import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    bool? success;
    String? message;
    int? statusCode;
    String? strToken;
    String? id;
    String? chrStatus;
    String? strOtpToken;
    String? strOtp;
    String? strName;
    String? strMobileNo;
    String? strEmail;
    String? strSignupMethode;
    String? strRoleName;
    String? strType;
    dynamic strProfileUrl;
    String? strHashPassword;
    DateTime? strCreatedTime;
    String? strAccountId;
    String? strFcmToken;
    String? strRefCode;

    UserModel({
        this.success,
        this.message,
        this.statusCode,
        this.strToken,
        this.id,
        this.chrStatus,
        this.strOtpToken,
        this.strOtp,
        this.strName,
        this.strMobileNo,
        this.strEmail,
        this.strSignupMethode,
        this.strRoleName,
        this.strType,
        this.strProfileUrl,
        this.strHashPassword,
        this.strCreatedTime,
        this.strAccountId,
        this.strFcmToken,
        this.strRefCode,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        success: json["success"],
        message: json["message"],
        statusCode: json["statusCode"],
        strToken: json["strToken"],
        id: json["_id"],
        chrStatus: json["chrStatus"],
        strOtpToken: json["strOTPToken"],
        strOtp: json["strOtp"],
        strName: json["strName"],
        strMobileNo: json["strMobileNo"],
        strEmail: json["strEmail"],
        strSignupMethode: json["strSignupMethode"],
        strRoleName: json["strRoleName"],
        strType: json["strType"],
        strProfileUrl: json["strProfileUrl"],
        strHashPassword: json["strHashPassword"],
        strCreatedTime: json["strCreatedTime"] == null ? null : DateTime.parse(json["strCreatedTime"]),
        strAccountId: json["strAccount_Id"],
        strFcmToken: json["strFcmToken"],
        strRefCode: json["strRefCode"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "statusCode": statusCode,
        "strToken": strToken,
        "_id": id,
        "chrStatus": chrStatus,
        "strOTPToken": strOtpToken,
        "strOtp": strOtp,
        "strName": strName,
        "strMobileNo": strMobileNo,
        "strEmail": strEmail,
        "strSignupMethode": strSignupMethode,
        "strRoleName": strRoleName,
        "strType": strType,
        "strProfileUrl": strProfileUrl,
        "strHashPassword": strHashPassword,
        "strCreatedTime": strCreatedTime?.toIso8601String(),
        "strAccount_Id": strAccountId,
        "strFcmToken": strFcmToken,
        "strRefCode": strRefCode,
    };
}
