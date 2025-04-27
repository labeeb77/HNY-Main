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

    factory CarListModel.fromJson(Map<String, dynamic>? json) {
        if (json == null) {
            return CarListModel(
                success: false,
                message: 'Invalid response',
                statusCode: 500,
                arrCars: [],
                objUser: null,
            );
        }
        return CarListModel(
            success: json["success"] ?? false,
            message: json["message"] ?? '',
            statusCode: json["statusCode"] ?? 0,
            arrCars: json["arrCars"] == null ? [] : List<ArrCar>.from(json["arrCars"]!.map((x) => ArrCar.fromJson(x))),
            objUser: json["objUser"] == null ? null : ObjUser.fromJson(json["objUser"]),
        );
    }

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
    StrStatus? strStatus;
    ChrStatus? chrStatus;
    String? strModel;
    String? strDescription;
    StrCarCategory? strCarCategory;
    dynamic strSeatNo;
    StrFuelType? strFuelType;
    String? strImgUrl;
    List<String>? arrImgUrl;
    dynamic intPower;
    dynamic intFuelCapacity;
    dynamic intRating;
    String? strVarients;
    dynamic strYear;
    String? strColor;
    dynamic intPricePerDay;
    dynamic intPricePerWeek;
    dynamic intPricePerMonth;
    List<ArrCarFeature>? arrCarFeatures;
    StrAtedBy? strCreatedBy;
    DateTime? strCreatedTime;
    StrAtedBy? strUpdatedBy;
    DateTime? strUpdatedTime;
    bool? isFavourite;
    dynamic intKm;
    StrInsurance? strInsurance;
    String? strChasis;

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
        this.strColor,
        this.intPricePerDay,
        this.intPricePerWeek,
        this.intPricePerMonth,
        this.arrCarFeatures,
        this.strCreatedBy,
        this.strCreatedTime,
        this.strUpdatedBy,
        this.strUpdatedTime,
        this.isFavourite,
        this.intKm,
        this.strInsurance,
        this.strChasis,
    });

    factory ArrCar.fromJson(Map<String, dynamic>? json) {
        if (json == null) {
            return ArrCar();
        }
        return ArrCar(
            id: json["_id"] ?? '',
            strCarCode: json["strCarCode"] ?? '',
            strCarNumber: json["strCarNumber"] ?? '',
            strBrand: json["strBrand"] ?? '',
            strStatus: strStatusValues.map[json["strStatus"]] ?? StrStatus.AVAILABLE,
            chrStatus: chrStatusValues.map[json["chrStatus"]] ?? ChrStatus.N,
            strModel: json["strModel"] ?? '',
            strDescription: json["strDescription"] ?? '',
            strCarCategory: strCarCategoryValues.map[json["strCarCategory"]] ?? StrCarCategory.EMPTY,
            strSeatNo: json["strSeatNo"] ?? 0,
            strFuelType: strFuelTypeValues.map[json["strFuelType"]] ?? StrFuelType.PETROL,
            strImgUrl: json["strImgUrl"] ?? '',
            arrImgUrl: json["arrImgUrl"] == null ? [] : List<String>.from(json["arrImgUrl"]!.map((x) => x.toString())),
            intPower: json["intPower"] ?? 0,
            intFuelCapacity: json["intFuelCapacity"] ?? 0,
            intRating: json["intRating"] ?? 0,
            strVarients: json["strVarients"] ?? '',
            strYear: json["strYear"] ?? 0,
            strColor: json["strColor"] ?? '',
            intPricePerDay: json["intPricePerDay"] ?? 0,
            intPricePerWeek: json["intPricePerWeek"] ?? 0,
            intPricePerMonth: json["intPricePerMonth"] ?? 0,
            arrCarFeatures: json["arrCarFeatures"] == null ? [] : List<ArrCarFeature>.from(json["arrCarFeatures"]!.map((x) => ArrCarFeature.fromJson(x))),
            strCreatedBy: strAtedByValues.map[json["strCreatedBy"]] ?? StrAtedBy.SYSTEM,
            strCreatedTime: json["strCreatedTime"] == null ? null : DateTime.tryParse(json["strCreatedTime"]),
            strUpdatedBy: strAtedByValues.map[json["strUpdatedBy"]] ?? StrAtedBy.SYSTEM,
            strUpdatedTime: json["strUpdatedTime"] == null ? null : DateTime.tryParse(json["strUpdatedTime"]),
            isFavourite: json["isFavourite"] ?? false,
            intKm: json["intKm"] ?? 0,
            strInsurance: strInsuranceValues.map[json["strInsurance"]] ?? StrInsurance.AL_SAGR_NATIONAL_INSURANCE_CO_PSC,
            strChasis: json["strChasis"] ?? '',
        );
    }

    Map<String, dynamic> toJson() => {
        "_id": id,
        "strCarCode": strCarCode,
        "strCarNumber": strCarNumber,
        "strBrand": strBrand,
        "strStatus": strStatusValues.reverse[strStatus],
        "chrStatus": chrStatusValues.reverse[chrStatus],
        "strModel": strModel,
        "strDescription": strDescription,
        "strCarCategory": strCarCategoryValues.reverse[strCarCategory],
        "strSeatNo": strSeatNo,
        "strFuelType": strFuelTypeValues.reverse[strFuelType],
        "strImgUrl": strImgUrl,
        "arrImgUrl": arrImgUrl == null ? [] : List<dynamic>.from(arrImgUrl!.map((x) => x)),
        "intPower": intPower,
        "intFuelCapacity": intFuelCapacity,
        "intRating": intRating,
        "strVarients": strVarients,
        "strYear": strYear,
        "strColor": strColor,
        "intPricePerDay": intPricePerDay,
        "intPricePerWeek": intPricePerWeek,
        "intPricePerMonth": intPricePerMonth,
        "arrCarFeatures": arrCarFeatures == null ? [] : List<dynamic>.from(arrCarFeatures!.map((x) => x.toJson())),
        "strCreatedBy": strAtedByValues.reverse[strCreatedBy],
        "strCreatedTime": strCreatedTime?.toIso8601String(),
        "strUpdatedBy": strAtedByValues.reverse[strUpdatedBy],
        "strUpdatedTime": strUpdatedTime?.toIso8601String(),
        "isFavourite": isFavourite,
        "intKm": intKm,
        "strInsurance": strInsuranceValues.reverse[strInsurance],
        "strChasis": strChasis,
    };
}

class ArrCarFeature {
    String? strFeatures;
    String? strDescription;

    ArrCarFeature({
        this.strFeatures,
        this.strDescription,
    });

    factory ArrCarFeature.fromJson(Map<String, dynamic>? json) {
        if (json == null) {
            return ArrCarFeature();
        }
        return ArrCarFeature(
            strFeatures: json["strFeatures"] ?? '',
            strDescription: json["strDescription"] ?? '',
        );
    }

    Map<String, dynamic> toJson() => {
        "strFeatures": strFeatures,
        "strDescription": strDescription,
    };
}

enum ChrStatus {
    N
}

final chrStatusValues = EnumValues({
    "N": ChrStatus.N
});

enum StrCarCategory {
    EMPTY,
    LUXURY
}

final strCarCategoryValues = EnumValues({
    "": StrCarCategory.EMPTY,
    "Luxury": StrCarCategory.LUXURY
});

enum StrAtedBy {
    SYSTEM,
    THE_67_C8_CCE3342_B65_B85_D6_AB507
}

final strAtedByValues = EnumValues({
    "System": StrAtedBy.SYSTEM,
    "67c8cce3342b65b85d6ab507": StrAtedBy.THE_67_C8_CCE3342_B65_B85_D6_AB507
});

enum StrFuelType {
    PETROL
}

final strFuelTypeValues = EnumValues({
    "Petrol": StrFuelType.PETROL
});

enum StrInsurance {
    AL_SAGR_NATIONAL_INSURANCE_CO_PSC
}

final strInsuranceValues = EnumValues({
    "AL SAGR NATIONAL INSURANCE CO. (PSC)\n": StrInsurance.AL_SAGR_NATIONAL_INSURANCE_CO_PSC
});

enum StrStatus {
    AVAILABLE,
    IN_RENTAL
}

final strStatusValues = EnumValues({
    "Available": StrStatus.AVAILABLE,
    "IN RENTAL": StrStatus.IN_RENTAL
});

class ObjUser {
    String? id;
    ChrStatus? chrStatus;
    String? strOtpToken;
    String? strOtp;
    String? strName;
    String? strMobileNo;
    dynamic strEmail;
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
    dynamic strEmiratesIdUrl;
    dynamic strFirstName;
    String? strFullName;
    dynamic strGccIdUrl;
    dynamic strLastName;
    dynamic strLicenceUrl;
    dynamic strNationality;
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
        chrStatus: chrStatusValues.map[json["chrStatus"]]!,
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
        "chrStatus": chrStatusValues.reverse[chrStatus],
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

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
