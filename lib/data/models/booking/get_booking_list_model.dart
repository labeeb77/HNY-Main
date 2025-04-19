import 'dart:convert';

BookingsListModel bookingsListModelFromJson(String str) => BookingsListModel.fromJson(json.decode(str));

String bookingsListModelToJson(BookingsListModel data) => json.encode(data.toJson());

class BookingsListModel {
    bool? success;
    String? message;
    int? statusCode;
    List<BookingArrList>? arrList;
    Pagination? pagination;

    BookingsListModel({
        this.success,
        this.message,
        this.statusCode,
        this.arrList,
        this.pagination,
    });

    factory BookingsListModel.fromJson(Map<String, dynamic> json) => BookingsListModel(
        success: json["success"],
        message: json["message"],
        statusCode: json["statusCode"],
        arrList: json["arrList"] == null ? [] : List<BookingArrList>.from(json["arrList"]!.map((x) => BookingArrList.fromJson(x))),
        pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "statusCode": statusCode,
        "arrList": arrList == null ? [] : List<dynamic>.from(arrList!.map((x) => x.toJson())),
        "pagination": pagination?.toJson(),
    };
}

class BookingArrList {
    String? id;
    ChrStatus? chrStatus;
    String? strStatus;
    String? strCustomerId;
    String? strBookingId;
    dynamic strBookingType;
    String? strPaymentMode;
    dynamic strRemarks;
    dynamic strPromocode;
    dynamic intPromocodeDiscount;
    dynamic intCoinsUsed;
    dynamic intCoinDiscount;
    double? intTotalAmount;
    double? intPayedAmount;
    int? intTotalDiscount;
    double? intCheckoutAmount;
    dynamic intRewardCoinCount;
    String? strCusMobileNo;
    double? intBalanceAmt;
    DateTime? strStartDate;
    DateTime? strEndDate;
    DateTime? strCreatedTime;
    List<ObjCustomer>? objCustomer;
    List<ArrBookingItem>? arrBookingItems;
    dynamic strCarName;
    String? strCarNumber;
    String? strCustomer;
    String? strCreatedByName;
    bool? upcoming;
    bool? inRental;
    bool? completed;

    BookingArrList({
        this.id,
        this.chrStatus,
        this.strStatus,
        this.strCustomerId,
        this.strBookingId,
        this.strBookingType,
        this.strPaymentMode,
        this.strRemarks,
        this.strPromocode,
        this.intPromocodeDiscount,
        this.intCoinsUsed,
        this.intCoinDiscount,
        this.intTotalAmount,
        this.intPayedAmount,
        this.intTotalDiscount,
        this.intCheckoutAmount,
        this.intRewardCoinCount,
        this.strCusMobileNo,
        this.intBalanceAmt,
        this.strStartDate,
        this.strEndDate,
        this.strCreatedTime,
        this.objCustomer,
        this.arrBookingItems,
        this.strCarName,
        this.strCarNumber,
        this.strCustomer,
        this.strCreatedByName,
        this.upcoming,
        this.inRental,
        this.completed,
    });

    factory BookingArrList.fromJson(Map<String, dynamic> json) => BookingArrList(
    id: json["_id"],
    chrStatus: json["chrStatus"] != null ? chrStatusValues.map[json["chrStatus"]] : null,
    strStatus: json["strStatus"],
    strCustomerId: json["strCustomerId"],
    strBookingId: json["strBookingId"],
    strBookingType: json["strBookingType"],
    strPaymentMode: json["strPaymentMode"],
    strRemarks: json["strRemarks"],
    strPromocode: json["strPromocode"],
    intPromocodeDiscount: json["intPromocodeDiscount"],
    intCoinsUsed: json["intCoinsUsed"],
    intCoinDiscount: json["intCoinDiscount"],
    intTotalAmount: json["intTotalAmount"]?.toDouble(),
    intPayedAmount: json["intPayedAmount"]?.toDouble(),
    intTotalDiscount: json["intTotalDiscount"],
    intCheckoutAmount: json["intCheckoutAmount"]?.toDouble(),
    intRewardCoinCount: json["intRewardCoinCount"],
    strCusMobileNo: json["strCusMobileNo"],
    intBalanceAmt: json["intBalanceAmt"]?.toDouble(),
    strStartDate: json["strStartDate"] == null ? null : DateTime.parse(json["strStartDate"]),
    strEndDate: json["strEndDate"] == null ? null : DateTime.parse(json["strEndDate"]),
    strCreatedTime: json["strCreatedTime"] == null ? null : DateTime.parse(json["strCreatedTime"]),
    objCustomer: json["objCustomer"] == null ? [] : List<ObjCustomer>.from(json["objCustomer"]!.map((x) => ObjCustomer.fromJson(x))),
    arrBookingItems: json["arrBookingItems"] == null ? [] : List<ArrBookingItem>.from(json["arrBookingItems"]!.map((x) => ArrBookingItem.fromJson(x))),
    strCarName: json["strCarName"],
    strCarNumber: json["strCarNumber"],
    strCustomer: json["strCustomer"],
    strCreatedByName: json["strCreatedByName"],
    upcoming: json["upcoming"],
    inRental: json["inRental"],
    completed: json["completed"],
);

    Map<String, dynamic> toJson() => {
        "_id": id,
        "chrStatus": chrStatusValues.reverse[chrStatus],
        "strStatus": strStatus,
        "strCustomerId": strCustomerId,
        "strBookingId": strBookingId,
        "strBookingType": strBookingType,
        "strPaymentMode": strPaymentMode,
        "strRemarks": strRemarks,
        "strPromocode": strPromocode,
        "intPromocodeDiscount": intPromocodeDiscount,
        "intCoinsUsed": intCoinsUsed,
        "intCoinDiscount": intCoinDiscount,
        "intTotalAmount": intTotalAmount,
        "intPayedAmount": intPayedAmount,
        "intTotalDiscount": intTotalDiscount,
        "intCheckoutAmount": intCheckoutAmount,
        "intRewardCoinCount": intRewardCoinCount,
        "strCusMobileNo": strCusMobileNo,
        "intBalanceAmt": intBalanceAmt,
        "strStartDate": strStartDate?.toIso8601String(),
        "strEndDate": strEndDate?.toIso8601String(),
        "strCreatedTime": strCreatedTime?.toIso8601String(),
        "objCustomer": objCustomer == null ? [] : List<dynamic>.from(objCustomer!.map((x) => x.toJson())),
        "arrBookingItems": arrBookingItems == null ? [] : List<dynamic>.from(arrBookingItems!.map((x) => x.toJson())),
        "strCarName": strCarName,
        "strCarNumber": strCarNumber,
        "strCustomer": strCustomer,
        "strCreatedByName": strCreatedByName,
        "upcoming": upcoming,
        "inRental": inRental,
        "completed": completed,
    };
}

class ArrBookingItem {
    String? id;
    String? strCarNumber;
    String? strCarCode;
    DateTime? strStartDate;
    DateTime? strEndDate;
    StrLocation? strDeliveryLocation;
    StrLocation? strPickupLocation;
    String? strPickupLocationAddress;
    String? strDeliveryLocationAddress;
    double? intTotalAmount;
    dynamic strBookingType;
    ArrBookingItemType? type;
    int? intPricePerDay;
    String? strImgUrl;
    String? strModel;
    int? intPricePerMonth;
    int? intPricePerWeek;
    String? arrBookingItemStrBookingId;
    String? strBookingId;
    dynamic strContractId;
    StrCarId? strCarId;
    ChrStatus? chrStatus;
    double? intUnitPrice;
    int? intTotalDays;
    StrTedBy? strCreatedBy;
    DateTime? strCreatedTime;
    String? strStatus;
    String? strUpdatedBy;
    DateTime? strUpdatedTime;
    String? strAddOnItemId;
    String? strAddOnName;
    int? intQty;
    String? strName;
    String? strDescription;
    StrTedBy? strDeletedBy;
    DateTime? strDeletedTime;

    ArrBookingItem({
        this.id,
        this.strCarNumber,
        this.strCarCode,
        this.strStartDate,
        this.strEndDate,
        this.strDeliveryLocation,
        this.strPickupLocation,
        this.strPickupLocationAddress,
        this.strDeliveryLocationAddress,
        this.intTotalAmount,
        this.strBookingType,
        this.type,
        this.intPricePerDay,
        this.strImgUrl,
        this.strModel,
        this.intPricePerMonth,
        this.intPricePerWeek,
        this.arrBookingItemStrBookingId,
        this.strBookingId,
        this.strContractId,
        this.strCarId,
        this.chrStatus,
        this.intUnitPrice,
        this.intTotalDays,
        this.strCreatedBy,
        this.strCreatedTime,
        this.strStatus,
        this.strUpdatedBy,
        this.strUpdatedTime,
        this.strAddOnItemId,
        this.strAddOnName,
        this.intQty,
        this.strName,
        this.strDescription,
        this.strDeletedBy,
        this.strDeletedTime,
    });

   factory ArrBookingItem.fromJson(Map<String, dynamic> json) => ArrBookingItem(
    id: json["_id"],
    strCarNumber: json["strCarNumber"],
    strCarCode: json["strCarCode"],
    strStartDate: json["strStartDate"] == null ? null : DateTime.parse(json["strStartDate"]),
    strEndDate: json["strEndDate"] == null ? null : DateTime.parse(json["strEndDate"]),
    strDeliveryLocation: json["strDeliveryLocation"] == null ? null : StrLocation.fromJson(json["strDeliveryLocation"]),
    strPickupLocation: json["strPickupLocation"] == null ? null : StrLocation.fromJson(json["strPickupLocation"]),
    strPickupLocationAddress: json["strPickupLocationAddress"],
    strDeliveryLocationAddress: json["strDeliveryLocationAddress"],
    intTotalAmount: json["intTotalAmount"]?.toDouble(),
    strBookingType: json["strBookingType"],
    type: json["type"] != null ? arrBookingItemTypeValues.map[json["type"]] : null,
    intPricePerDay: json["intPricePerDay"],
    strImgUrl: json["strImgUrl"],
    strModel: json["strModel"] ,
    intPricePerMonth: json["intPricePerMonth"],
    intPricePerWeek: json["intPricePerWeek"],
    arrBookingItemStrBookingId: json["strBooking_Id"],
    strBookingId: json["strBookingId"],
    strContractId: json["strContractId"],
    strCarId: json["strCarId"] != null ? strCarIdValues.map[json["strCarId"]] : null,
    chrStatus: json["chrStatus"] != null ? chrStatusValues.map[json["chrStatus"]] : null,
    intUnitPrice: json["intUnitPrice"]?.toDouble(),
    intTotalDays: json["intTotalDays"],
    strCreatedBy: json["strCreatedBy"] != null ? strTedByValues.map[json["strCreatedBy"]] : null,
    strCreatedTime: json["strCreatedTime"] == null ? null : DateTime.parse(json["strCreatedTime"]),
    strStatus: json["strStatus"],
    strUpdatedBy: json["strUpdatedBy"],
    strUpdatedTime: json["strUpdatedTime"] == null ? null : DateTime.parse(json["strUpdatedTime"]),
    strAddOnItemId: json["strAddOnItemId"],
    strAddOnName: json["strAddOnName"],
    intQty: json["intQty"],
    strName: json["strName"],
    strDescription: json["strDescription"],
    strDeletedBy: json["strDeletedBy"] != null ? strTedByValues.map[json["strDeletedBy"]] : null,
    strDeletedTime: json["strDeletedTime"] == null ? null : DateTime.parse(json["strDeletedTime"]),
);

    Map<String, dynamic> toJson() => {
        "_id": id,
        "strCarNumber": strCarNumber,
        "strCarCode": strCarCode,
        "strStartDate": strStartDate?.toIso8601String(),
        "strEndDate": strEndDate?.toIso8601String(),
        "strDeliveryLocation": strDeliveryLocation?.toJson(),
        "strPickupLocation": strPickupLocation?.toJson(),
        "strPickupLocationAddress": strPickupLocationAddress,
        "strDeliveryLocationAddress": strDeliveryLocationAddress,
        "intTotalAmount": intTotalAmount,
        "strBookingType": strBookingType,
        "type": arrBookingItemTypeValues.reverse[type],
        "intPricePerDay": intPricePerDay,
        "strImgUrl": strImgUrl,
        "strModel": strModel,
        "intPricePerMonth": intPricePerMonth,
        "intPricePerWeek": intPricePerWeek,
        "strBooking_Id": arrBookingItemStrBookingId,
        "strBookingId": strBookingId,
        "strContractId": strContractId,
        "strCarId": strCarIdValues.reverse[strCarId],
        "chrStatus": chrStatusValues.reverse[chrStatus],
        "intUnitPrice": intUnitPrice,
        "intTotalDays": intTotalDays,
        "strCreatedBy": strTedByValues.reverse[strCreatedBy],
        "strCreatedTime": strCreatedTime?.toIso8601String(),
        "strStatus": strStatus,
        "strUpdatedBy": strUpdatedBy,
        "strUpdatedTime": strUpdatedTime?.toIso8601String(),
        "strAddOnItemId": strAddOnItemId,
        "strAddOnName": strAddOnName,
        "intQty": intQty,
        "strName": strName,
        "strDescription": strDescription,
        "strDeletedBy": strTedByValues.reverse[strDeletedBy],
        "strDeletedTime": strDeletedTime?.toIso8601String(),
    };
}

enum ChrStatus {
    C,
    N
}

final chrStatusValues = EnumValues({
    "C": ChrStatus.C,
    "N": ChrStatus.N
});

enum StrCarId {
    THE_67_B426405_E0_F5_FB01_F00_DC99,
    THE_67_B426405_E0_F5_FB01_F00_DC9_A,
    THE_67_C48_BF1_C883_A1_EAE8_E92_D94
}

final strCarIdValues = EnumValues({
    "67b426405e0f5fb01f00dc99": StrCarId.THE_67_B426405_E0_F5_FB01_F00_DC99,
    "67b426405e0f5fb01f00dc9a": StrCarId.THE_67_B426405_E0_F5_FB01_F00_DC9_A,
    "67c48bf1c883a1eae8e92d94": StrCarId.THE_67_C48_BF1_C883_A1_EAE8_E92_D94
});

enum StrTedBy {
    THE_67_B424_A4_B6_B7811_D1_AD23_DF6,
    THE_67_BC9772_E349706_AE5_DFBBE9
}

final strTedByValues = EnumValues({
    "67b424a4b6b7811d1ad23df6": StrTedBy.THE_67_B424_A4_B6_B7811_D1_AD23_DF6,
    "67bc9772e349706ae5dfbbe9": StrTedBy.THE_67_BC9772_E349706_AE5_DFBBE9
});

class StrLocation {
    StrDeliveryLocationType? type;
    List<double>? coordinates;

    StrLocation({
        this.type,
        this.coordinates,
    });

  factory StrLocation.fromJson(Map<String, dynamic> json) => StrLocation(
    type: json["type"] != null ? strDeliveryLocationTypeValues.map[json["type"]] : null,
    coordinates: json["coordinates"] == null ? [] : List<double>.from(json["coordinates"]!.map((x) => x?.toDouble())),
);
    Map<String, dynamic> toJson() => {
        "type": strDeliveryLocationTypeValues.reverse[type],
        "coordinates": coordinates == null ? [] : List<dynamic>.from(coordinates!.map((x) => x)),
    };
}

enum StrDeliveryLocationType {
    POINT
}

final strDeliveryLocationTypeValues = EnumValues({
    "Point": StrDeliveryLocationType.POINT
});

enum StrModel {
    JAGUAR_100,
    V8
}

final strModelValues = EnumValues({
    "jaguar 100": StrModel.JAGUAR_100,
    "V8": StrModel.V8
});

enum ArrBookingItemType {
    ADD_ON,
    CAR
}

final arrBookingItemTypeValues = EnumValues({
    "ADD_ON": ArrBookingItemType.ADD_ON,
    "CAR": ArrBookingItemType.CAR
});

class ObjCustomer {
    String? id;
    ChrStatus? chrStatus;
    String? strOtpToken;
    String? strOtp;
    String? strName;
    String? strMobileNo;
    StrEmail? strEmail;
    String? strSignupMethode;
    Str? strRoleName;
    Str? strType;
    dynamic strProfileUrl;
    String? strHashPassword;
    DateTime? strCreatedTime;
    String? strAccountId;
    String? strFcmToken;
    String? strRefCode;
    int? intAdvancePercentage;
    dynamic strEmiratesIdUrl;
    String? strFirstName;
    String? strFullName;
    String? strGccIdUrl;
    String? strLastName;
    dynamic strLicenceUrl;
    String? strNationality;
    String? strPassportUrl;
    String? strUpdatedBy;
    DateTime? strUpdatedTime;
    double? intCurrentBalance;
    int? intOpningBalance;
    dynamic strJoinDate;
    dynamic strPromoCode;
    String? strCreatedUser;

    ObjCustomer({
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
        this.intCurrentBalance,
        this.intOpningBalance,
        this.strJoinDate,
        this.strPromoCode,
        this.strCreatedUser,
    });

   factory ObjCustomer.fromJson(Map<String, dynamic> json) => ObjCustomer(
    id: json["_id"],
    chrStatus: json["chrStatus"] != null ? chrStatusValues.map[json["chrStatus"]] : null,
    strOtpToken: json["strOTPToken"],
    strOtp: json["strOtp"],
    strName: json["strName"],
    strMobileNo: json["strMobileNo"],
    strEmail: json["strEmail"] != null ? strEmailValues.map[json["strEmail"]] : null,
    strSignupMethode: json["strSignupMethode"],
    strRoleName: json["strRoleName"] != null ? strValues.map[json["strRoleName"]] : null,
    strType: json["strType"] != null ? strValues.map[json["strType"]] : null,
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
    intCurrentBalance: json["intCurrentBalance"]?.toDouble(),
    intOpningBalance: json["intOpningBalance"],
    strJoinDate: json["strJoinDate"],
    strPromoCode: json["strPromoCode"],
    strCreatedUser: json["strCreatedUser"],
);

    Map<String, dynamic> toJson() => {
        "_id": id,
        "chrStatus": chrStatusValues.reverse[chrStatus],
        "strOTPToken": strOtpToken,
        "strOtp": strOtp,
        "strName": strName,
        "strMobileNo": strMobileNo,
        "strEmail": strEmailValues.reverse[strEmail],
        "strSignupMethode": strSignupMethode,
        "strRoleName": strValues.reverse[strRoleName],
        "strType": strValues.reverse[strType],
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
        "intCurrentBalance": intCurrentBalance,
        "intOpningBalance": intOpningBalance,
        "strJoinDate": strJoinDate,
        "strPromoCode": strPromoCode,
        "strCreatedUser": strCreatedUser,
    };
}

enum StrEmail {
    EMPTY,
    LABEEB_GMAIL_COM
}

final strEmailValues = EnumValues({
    "": StrEmail.EMPTY,
    "labeeb@gmail.com": StrEmail.LABEEB_GMAIL_COM
});

enum Str {
    NORMAL,
    USER
}

final strValues = EnumValues({
    "Normal": Str.NORMAL,
    "USER": Str.USER
});

class Pagination {
    int? page;
    int? pageSize;
    int? count;

    Pagination({
        this.page,
        this.pageSize,
        this.count,
    });

    factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        page: json["page"],
        pageSize: json["pageSize"],
        count: json["count"],
    );

    Map<String, dynamic> toJson() => {
        "page": page,
        "pageSize": pageSize,
        "count": count,
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