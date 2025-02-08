// To parse this JSON data, do
//
//     final addProfileModel = addProfileModelFromJson(jsonString);

import 'dart:convert';

UserModel UserModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String UserModelToJson(UserModel data) => json.encode(data.toJson());

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
    dynamic strEmail;
    String? strSignupMethode;
    String? strRoleName;
    String? strType;
    String? strProfileUrl;
    dynamic strHashPassword;
    DateTime? strCreatedTime;
    String? strAccountId;
    String? strFcmToken;
    String? strRefCode;
    int? intAdvancePercentage;
    dynamic intOpningBalance;
    String? strEmiratesIdUrl;
    String? strFirstName;
    String? strFullName;
    String? strGccIdUrl;
    dynamic strJoinDate;
    String? strLastName;
    String? strLicenceUrl;
    String? strNationality;
    String? strPassportUrl;
    String? strUpdatedBy;
    DateTime? strUpdatedTime;

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
        this.intAdvancePercentage,
        this.intOpningBalance,
        this.strEmiratesIdUrl,
        this.strFirstName,
        this.strFullName,
        this.strGccIdUrl,
        this.strJoinDate,
        this.strLastName,
        this.strLicenceUrl,
        this.strNationality,
        this.strPassportUrl,
        this.strUpdatedBy,
        this.strUpdatedTime,
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
        strUpdatedTime: json["strUpdatedTime"] == null ? null : DateTime.parse(json["strUpdatedTime"]),
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
        "strUpdatedTime": strUpdatedTime?.toIso8601String(),
    };
}
