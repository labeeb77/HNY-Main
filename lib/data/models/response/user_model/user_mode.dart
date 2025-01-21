// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    bool success;
    String message;
    int statusCode;
    String strToken;
    String id;
    String chrStatus;
    String strOtpToken;
    String strOtp;
    String strName;
    String strMobileNo;
    dynamic strEmail;
    String strSignupMethode;
    String strRoleName;
    String strType;
    dynamic strProfileUrl;
    dynamic strHashPassword;
    DateTime strCreatedTime;
    String strAccountId;
    String strFcmToken;
    String strRefCode;
    dynamic intAdvancePercentage;
    dynamic intOpningBalance;
    dynamic strEmiratesIdUrl;
    String strFirstName;
    String strFullName;
    dynamic strGccIdUrl;
    dynamic strJoinDate;
    dynamic strLastName;
    dynamic strLicenceUrl;
    dynamic strNationality;
    dynamic strPassportUrl;
    String strUpdatedBy;
    DateTime strUpdatedTime;

    UserModel({
        required this.success,
        required this.message,
        required this.statusCode,
        required this.strToken,
        required this.id,
        required this.chrStatus,
        required this.strOtpToken,
        required this.strOtp,
        required this.strName,
        required this.strMobileNo,
        required this.strEmail,
        required this.strSignupMethode,
        required this.strRoleName,
        required this.strType,
        required this.strProfileUrl,
        required this.strHashPassword,
        required this.strCreatedTime,
        required this.strAccountId,
        required this.strFcmToken,
        required this.strRefCode,
        required this.intAdvancePercentage,
        required this.intOpningBalance,
        required this.strEmiratesIdUrl,
        required this.strFirstName,
        required this.strFullName,
        required this.strGccIdUrl,
        required this.strJoinDate,
        required this.strLastName,
        required this.strLicenceUrl,
        required this.strNationality,
        required this.strPassportUrl,
        required this.strUpdatedBy,
        required this.strUpdatedTime,
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
        strCreatedTime: DateTime.parse(json["strCreatedTime"]),
        strAccountId: json["strAccount_Id"],
        strFcmToken: json["strFcmToken"],
        strRefCode: json["strRefCode"],
        intAdvancePercentage: json["intAdvancePercentage"],
        intOpningBalance: json["intOpningBalance"],
        strEmiratesIdUrl: json["strEmiratesIdUrl"],
        strFirstName: json["strFirstName"],
        strFullName: json["strFullName"],
        strGccIdUrl: json["strGCCIdUrl"],
        strJoinDate: json["strJoinDate"],
        strLastName: json["strLastName"],
        strLicenceUrl: json["strLicenceUrl"],
        strNationality: json["strNationality"],
        strPassportUrl: json["strPassportUrl"],
        strUpdatedBy: json["strUpdatedBy"],
        strUpdatedTime: DateTime.parse(json["strUpdatedTime"]),
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
        "strCreatedTime": strCreatedTime.toIso8601String(),
        "strAccount_Id": strAccountId,
        "strFcmToken": strFcmToken,
        "strRefCode": strRefCode,
        "intAdvancePercentage": intAdvancePercentage,
        "intOpningBalance": intOpningBalance,
        "strEmiratesIdUrl": strEmiratesIdUrl,
        "strFirstName": strFirstName,
        "strFullName": strFullName,
        "strGCCIdUrl": strGccIdUrl,
        "strJoinDate": strJoinDate,
        "strLastName": strLastName,
        "strLicenceUrl": strLicenceUrl,
        "strNationality": strNationality,
        "strPassportUrl": strPassportUrl,
        "strUpdatedBy": strUpdatedBy,
        "strUpdatedTime": strUpdatedTime.toIso8601String(),
    };
}
