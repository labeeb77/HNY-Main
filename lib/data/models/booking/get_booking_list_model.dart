// To parse this JSON data, do
//
//     final bookingsListModel = bookingsListModelFromJson(jsonString);

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
    dynamic id;
    dynamic chrStatus;
    dynamic strStatus;
    dynamic strCustomerId;
    dynamic strBookingId;
    dynamic strBookingType;
    dynamic strPaymentMode;
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
    dynamic strCusMobileNo;
    double? intBalanceAmt;
    DateTime? strStartDate;
    DateTime? strEndDate;
    DateTime? strCreatedTime;
    List<ObjCustomer>? objCustomer;
    List<ArrBookingItem>? arrBookingItems;
    dynamic strCarName;
    dynamic strCarNumber;
    dynamic strCustomer;
    dynamic strCreatedByName;
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
        chrStatus: json["chrStatus"],
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
        "chrStatus": chrStatus,
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
    dynamic id;
    dynamic strCarNumber;
    dynamic strCarCode;
    DateTime? strStartDate;
    DateTime? strEndDate;
    StrLocation? strDeliveryLocation;
    StrLocation? strPickupLocation;
    dynamic strPickupLocationAddress;
    dynamic strDeliveryLocationAddress;
    double? intTotalAmount;
    dynamic strBookingType;
    dynamic type;
    dynamic intPricePerDay;
    dynamic strImgUrl;
    dynamic strModel;
    dynamic intPricePerMonth;
    dynamic intPricePerWeek;
    dynamic arrBookingItemStrBookingId;
    dynamic strBookingId;
    dynamic strContractId;
    dynamic strCarId;
    dynamic chrStatus;
    double? intUnitPrice;
    dynamic intTotalDays;
    dynamic strCreatedBy;
    DateTime? strCreatedTime;
    dynamic strStatus;
    dynamic strDeletedBy;
    DateTime? strDeletedTime;
    dynamic strUpdatedBy;
    DateTime? strUpdatedTime;

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
        this.strDeletedBy,
        this.strDeletedTime,
        this.strUpdatedBy,
        this.strUpdatedTime,
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
        type: json["type"],
        intPricePerDay: json["intPricePerDay"],
        strImgUrl: json["strImgUrl"],
        strModel: json["strModel"],
        intPricePerMonth: json["intPricePerMonth"],
        intPricePerWeek: json["intPricePerWeek"],
        arrBookingItemStrBookingId: json["strBooking_Id"],
        strBookingId: json["strBookingId"],
        strContractId: json["strContractId"],
        strCarId: json["strCarId"],
        chrStatus: json["chrStatus"],
        intUnitPrice: json["intUnitPrice"]?.toDouble(),
        intTotalDays: json["intTotalDays"],
        strCreatedBy: json["strCreatedBy"],
        strCreatedTime: json["strCreatedTime"] == null ? null : DateTime.parse(json["strCreatedTime"]),
        strStatus: json["strStatus"],
        strDeletedBy: json["strDeletedBy"],
        strDeletedTime: json["strDeletedTime"] == null ? null : DateTime.parse(json["strDeletedTime"]),
        strUpdatedBy: json["strUpdatedBy"],
        strUpdatedTime: json["strUpdatedTime"] == null ? null : DateTime.parse(json["strUpdatedTime"]),
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
        "type": type,
        "intPricePerDay": intPricePerDay,
        "strImgUrl": strImgUrl,
        "strModel": strModel,
        "intPricePerMonth": intPricePerMonth,
        "intPricePerWeek": intPricePerWeek,
        "strBooking_Id": arrBookingItemStrBookingId,
        "strBookingId": strBookingId,
        "strContractId": strContractId,
        "strCarId": strCarId,
        "chrStatus": chrStatus,
        "intUnitPrice": intUnitPrice,
        "intTotalDays": intTotalDays,
        "strCreatedBy": strCreatedBy,
        "strCreatedTime": strCreatedTime?.toIso8601String(),
        "strStatus": strStatus,
        "strDeletedBy": strDeletedBy,
        "strDeletedTime": strDeletedTime?.toIso8601String(),
        "strUpdatedBy": strUpdatedBy,
        "strUpdatedTime": strUpdatedTime?.toIso8601String(),
    };
}

class StrLocation {
    String? type;
    List<double>? coordinates;

    StrLocation({
        this.type,
        this.coordinates,
    });

    factory StrLocation.fromJson(Map<String, dynamic> json) => StrLocation(
        type: json["type"],
        coordinates: json["coordinates"] == null ? [] : List<double>.from(json["coordinates"]!.map((x) => x?.toDouble())),
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": coordinates == null ? [] : List<dynamic>.from(coordinates!.map((x) => x)),
    };
}

class ObjCustomer {
    dynamic id;
    dynamic chrStatus;
    dynamic strFirstName;
    dynamic strLastName;
    dynamic strMobileNo;
    dynamic strFullName;
    dynamic strEmail;
    dynamic strRoleName;
    dynamic strType;
    dynamic intOpningBalance;
    double? intCurrentBalance;
    dynamic strJoinDate;
    dynamic strNationality;
    dynamic strPromoCode;
    dynamic intAdvancePercentage;
    DateTime? strCreatedTime;
    dynamic strCreatedUser;

    ObjCustomer({
        this.id,
        this.chrStatus,
        this.strFirstName,
        this.strLastName,
        this.strMobileNo,
        this.strFullName,
        this.strEmail,
        this.strRoleName,
        this.strType,
        this.intOpningBalance,
        this.intCurrentBalance,
        this.strJoinDate,
        this.strNationality,
        this.strPromoCode,
        this.intAdvancePercentage,
        this.strCreatedTime,
        this.strCreatedUser,
    });

    factory ObjCustomer.fromJson(Map<String, dynamic> json) => ObjCustomer(
        id: json["_id"],
        chrStatus: json["chrStatus"],
        strFirstName: json["strFirstName"],
        strLastName: json["strLastName"],
        strMobileNo: json["strMobileNo"],
        strFullName: json["strFullName"],
        strEmail: json["strEmail"],
        strRoleName: json["strRoleName"],
        strType: json["strType"],
        intOpningBalance: json["intOpningBalance"],
        intCurrentBalance: json["intCurrentBalance"]?.toDouble(),
        strJoinDate: json["strJoinDate"],
        strNationality: json["strNationality"],
        strPromoCode: json["strPromoCode"],
        intAdvancePercentage: json["intAdvancePercentage"],
        strCreatedTime: json["strCreatedTime"] == null ? null : DateTime.parse(json["strCreatedTime"]),
        strCreatedUser: json["strCreatedUser"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "chrStatus": chrStatus,
        "strFirstName": strFirstName,
        "strLastName": strLastName,
        "strMobileNo": strMobileNo,
        "strFullName": strFullName,
        "strEmail": strEmail,
        "strRoleName": strRoleName,
        "strType": strType,
        "intOpningBalance": intOpningBalance,
        "intCurrentBalance": intCurrentBalance,
        "strJoinDate": strJoinDate,
        "strNationality": strNationality,
        "strPromoCode": strPromoCode,
        "intAdvancePercentage": intAdvancePercentage,
        "strCreatedTime": strCreatedTime?.toIso8601String(),
        "strCreatedUser": strCreatedUser,
    };
}

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
