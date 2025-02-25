import 'dart:convert';

CarListModel carListModelFromJson(String str) => CarListModel.fromJson(json.decode(str));

String carListModelToJson(CarListModel data) => json.encode(data.toJson());

class CarListModel {
    bool? success;
    String? message;
    int? statusCode;
    List<ArrCar>? arrCars;
    ObjUser? objUser;

    CarListModel({
        this.success,
        this.message,
        this.statusCode,
        this.arrCars,
        this.objUser,
    });

    factory CarListModel.fromJson(Map<String, dynamic> json) => CarListModel(
        success: json["success"],
        message: json["message"],
        statusCode: json["statusCode"],
        arrCars: json["arrCars"] == null ? [] : List<ArrCar>.from(json["arrCars"]!.map((x) => ArrCar.fromJson(x))),
        objUser: json["objUser"] == null ? null : ObjUser.fromJson(json["objUser"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "statusCode": statusCode,
        "arrCars": arrCars == null ? [] : List<dynamic>.from(arrCars!.map((x) => x.toJson())),
        "objUser": objUser?.toJson(),
    };
}

class ArrCar {
    String? id;
    String? strCarCode;
    String? strCarNumber;
    String? strBrand;
    String? strStatus;
    String? chrStatus;
    String? strModel;
    String? strDescription;
    String? strCarCategory;
    int? strSeatNo;
    dynamic strFuelType;
    String? strImgUrl;
    List<String>? arrImgUrl;
    int? intPower;
    dynamic intFuelCapacity;
    dynamic intRating;
    String? strVarients;
    dynamic strYear;
    int? intPricePerDay;
    int? intPricePerWeek;
    int? intPricePerMonth;
    dynamic arrCarFeatures;
    String? strCreatedBy;
    DateTime? strCreatedTime;
    String? strUpdatedBy;
    DateTime? strUpdatedTime;
    bool? isFavourite;

    ArrCar({
        this.id,
        this.strCarCode,
        this.strCarNumber,
        this.strBrand,
        this.strStatus,
        this.chrStatus,
        this.strModel,
        this.strDescription,
        this.strCarCategory,
        this.strSeatNo,
        this.strFuelType,
        this.strImgUrl,
        this.arrImgUrl,
        this.intPower,
        this.intFuelCapacity,
        this.intRating,
        this.strVarients,
        this.strYear,
        this.intPricePerDay,
        this.intPricePerWeek,
        this.intPricePerMonth,
        this.arrCarFeatures,
        this.strCreatedBy,
        this.strCreatedTime,
        this.strUpdatedBy,
        this.strUpdatedTime,
        this.isFavourite,
    });

    factory ArrCar.fromJson(Map<String, dynamic> json) => ArrCar(
        id: json["_id"],
        strCarCode: json["strCarCode"],
        strCarNumber: json["strCarNumber"],
        strBrand: json["strBrand"],
        strStatus: json["strStatus"],
        chrStatus: json["chrStatus"],
        strModel: json["strModel"],
        strDescription: json["strDescription"],
        strCarCategory: json["strCarCategory"],
        strSeatNo: json["strSeatNo"],
        strFuelType: json["strFuelType"],
        strImgUrl: json["strImgUrl"],
        arrImgUrl: json["arrImgUrl"] == null ? [] : List<String>.from(json["arrImgUrl"]!.map((x) => x)),
        intPower: json["intPower"],
        intFuelCapacity: json["intFuelCapacity"],
        intRating: json["intRating"],
        strVarients: json["strVarients"],
        strYear: json["strYear"],
        intPricePerDay: json["intPricePerDay"],
        intPricePerWeek: json["intPricePerWeek"],
        intPricePerMonth: json["intPricePerMonth"],
        arrCarFeatures: json["arrCarFeatures"],
        strCreatedBy: json["strCreatedBy"],
        strCreatedTime: json["strCreatedTime"] == null ? null : DateTime.parse(json["strCreatedTime"]),
        strUpdatedBy: json["strUpdatedBy"],
        strUpdatedTime: json["strUpdatedTime"] == null ? null : DateTime.parse(json["strUpdatedTime"]),
        isFavourite: json["isFavourite"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "strCarCode": strCarCode,
        "strCarNumber": strCarNumber,
        "strBrand": strBrand,
        "strStatus": strStatus,
        "chrStatus": chrStatus,
        "strModel": strModel,
        "strDescription": strDescription,
        "strCarCategory": strCarCategory,
        "strSeatNo": strSeatNo,
        "strFuelType": strFuelType,
        "strImgUrl": strImgUrl,
        "arrImgUrl": arrImgUrl == null ? [] : List<dynamic>.from(arrImgUrl!.map((x) => x)),
        "intPower": intPower,
        "intFuelCapacity": intFuelCapacity,
        "intRating": intRating,
        "strVarients": strVarients,
        "strYear": strYear,
        "intPricePerDay": intPricePerDay,
        "intPricePerWeek": intPricePerWeek,
        "intPricePerMonth": intPricePerMonth,
        "arrCarFeatures": arrCarFeatures,
        "strCreatedBy": strCreatedBy,
        "strCreatedTime": strCreatedTime?.toIso8601String(),
        "strUpdatedBy": strUpdatedBy,
        "strUpdatedTime": strUpdatedTime?.toIso8601String(),
        "isFavourite": isFavourite,
    };
}

class ObjUser {
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
    int? intAdvancePercentage;
    String? strEmiratesIdUrl;
    String? strFirstName;
    String? strFullName;
    String? strGccIdUrl;
    String? strLastName;
    String? strLicenceUrl;
    String? strNationality;
    String? strPassportUrl;
    String? strUpdatedBy;
    DateTime? strUpdatedTime;

    ObjUser({
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
        this.strEmiratesIdUrl,
        this.strFirstName,
        this.strFullName,
        this.strGccIdUrl,
        this.strLastName,
        this.strLicenceUrl,
        this.strNationality,
        this.strPassportUrl,
        this.strUpdatedBy,
        this.strUpdatedTime,
    });

    factory ObjUser.fromJson(Map<String, dynamic> json) => ObjUser(
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
        strEmiratesIdUrl: json["strEmiratesIdUrl"],
        strFirstName: json["strFirstName"],
        strFullName: json["strFullName"],
        strGccIdUrl: json["strGCCIdUrl"],
        strLastName: json["strLastName"],
        strLicenceUrl: json["strLicenceUrl"],
        strNationality: json["strNationality"],
        strPassportUrl: json["strPassportUrl"],
        strUpdatedBy: json["strUpdatedBy"],
        strUpdatedTime: json["strUpdatedTime"] == null ? null : DateTime.parse(json["strUpdatedTime"]),
    );

    Map<String, dynamic> toJson() => {
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
        "strEmiratesIdUrl": strEmiratesIdUrl,
        "strFirstName": strFirstName,
        "strFullName": strFullName,
        "strGCCIdUrl": strGccIdUrl,
        "strLastName": strLastName,
        "strLicenceUrl": strLicenceUrl,
        "strNationality": strNationality,
        "strPassportUrl": strPassportUrl,
        "strUpdatedBy": strUpdatedBy,
        "strUpdatedTime": strUpdatedTime?.toIso8601String(),
    };
}
