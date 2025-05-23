// To parse this JSON data, do
//
//     final userProfileModel = userProfileModelFromJson(jsonString);

import 'dart:convert';

UserProfileModel userProfileModelFromJson(String str) => UserProfileModel.fromJson(json.decode(str));

String userProfileModelToJson(UserProfileModel data) => json.encode(data.toJson());

class UserProfileModel {
    bool? success;
    String? message;
    int? statusCode;
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
    String? strProfileUrl;
    dynamic strHashPassword;
    DateTime? strCreatedTime;
    String? strAccountId;
    String? strFcmToken;
    String? strRefCode;
    int? intAdvancePercentage;
    dynamic intOpningBalance;
    String? strEmiratesIdUrl;
    String? strVisaUrl;
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
    dynamic strZoneName;
    dynamic strZonePolygon;
    int? userCoins;
    bool? isUserPremium;

    UserProfileModel({
        this.success,
        this.message,
        this.statusCode,
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
        this.strZoneName,
        this.strZonePolygon,
        this.userCoins,
        this.isUserPremium,
        this.strVisaUrl
    });

    factory UserProfileModel.fromJson(Map<String, dynamic> json) => UserProfileModel(
        success: json["success"],
        message: json["message"],
        statusCode: json["statusCode"],
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
        strZoneName: json["strZoneName"],
        strZonePolygon: json["strZonePolygon"],
        userCoins: json["userCoins"],
        isUserPremium: json["isUserPremium"],
        strVisaUrl: json["strVisaUrl"]
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "statusCode": statusCode,
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
        "strZoneName": strZoneName,
        "strZonePolygon": strZonePolygon,
        "userCoins": userCoins,
        "isUserPremium": isUserPremium,
        "strVisaUrl": strVisaUrl
    };
}
