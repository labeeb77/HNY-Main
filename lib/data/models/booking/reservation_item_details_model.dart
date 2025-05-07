// To parse this JSON data, do
//
//     final reservationItemDetailsModel = reservationItemDetailsModelFromJson(jsonString);

import 'dart:convert';

ReservationItemDetailsModel reservationItemDetailsModelFromJson(String str) => ReservationItemDetailsModel.fromJson(json.decode(str));

String reservationItemDetailsModelToJson(ReservationItemDetailsModel data) => json.encode(data.toJson());

class ReservationItemDetailsModel {
    bool? success;
    String? message;
    int? statusCode;
    String? id;
    String? chrStatus;
    String? strStatus;
    String? strCustomerId;
    String? strBookingId;
    dynamic strBookingType;
    dynamic strPaymentMode;
    dynamic strRemarks;
    dynamic strPromocode;
    dynamic intPromocodeDiscount;
    dynamic intCoinsUsed;
    dynamic intCoinDiscount;
    double? intTotalAmount;
    double? intAmountExcludingVat;
    double? intVatAmount;
    int? intVatPercentage;
    int? intPayedAmount;
    int? intTotalDiscount;
    double? intCheckoutAmount;
    double? intTotalVatAmount;
    dynamic intRewardCoinCount;
    String? strCusMobileNo;
    String? strMobileNo;
    String? strCusName;
    String? strEmail;
    double? intBalanceAmt;
    int? intDepositAmount;
    DateTime? strStartDate;
    DateTime? strEndDate;
    bool? isVatIncluded;
    String? strCreatedBy;
    DateTime? strCreatedTime;
    List<ArrBookingItemTwo>? arrBookingItems;
    List<ArrPayment>? arrPayments;
    List<ArrAddCharge>? arrAddCharges;

    ReservationItemDetailsModel({
        this.success,
        this.message,
        this.statusCode,
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
        this.intAmountExcludingVat,
        this.intVatAmount,
        this.intVatPercentage,
        this.intPayedAmount,
        this.intTotalDiscount,
        this.intCheckoutAmount,
        this.intTotalVatAmount,
        this.intRewardCoinCount,
        this.strCusMobileNo,
        this.strMobileNo,
        this.strCusName,
        this.strEmail,
        this.intBalanceAmt,
        this.intDepositAmount,
        this.strStartDate,
        this.strEndDate,
        this.isVatIncluded,
        this.strCreatedBy,
        this.strCreatedTime,
        this.arrBookingItems,
        this.arrPayments,
        this.arrAddCharges,
    });

    factory ReservationItemDetailsModel.fromJson(Map<String, dynamic> json) => ReservationItemDetailsModel(
        success: json["success"],
        message: json["message"],
        statusCode: json["statusCode"],
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
        intAmountExcludingVat: json["intAmountExcludingVat"]?.toDouble(),
        intVatAmount: json["intVatAmount"]?.toDouble(),
        intVatPercentage: json["intVatPercentage"],
        intPayedAmount: json["intPayedAmount"],
        intTotalDiscount: json["intTotalDiscount"],
        intCheckoutAmount: json["intCheckoutAmount"]?.toDouble(),
        intTotalVatAmount: json["intTotalVatAmount"]?.toDouble(),
        intRewardCoinCount: json["intRewardCoinCount"],
        strCusMobileNo: json["strCusMobileNo"],
        strMobileNo: json["strMobileNo"],
        strCusName: json["strCusName"],
        strEmail: json["strEmail"],
        intBalanceAmt: json["intBalanceAmt"]?.toDouble(),
        intDepositAmount: json["intDepositAmount"],
        strStartDate: json["strStartDate"] == null ? null : DateTime.parse(json["strStartDate"]),
        strEndDate: json["strEndDate"] == null ? null : DateTime.parse(json["strEndDate"]),
        isVatIncluded: json["isVatIncluded"],
        strCreatedBy: json["strCreatedBy"],
        strCreatedTime: json["strCreatedTime"] == null ? null : DateTime.parse(json["strCreatedTime"]),
        arrBookingItems: json["arrBookingItems"] == null ? [] : List<ArrBookingItemTwo>.from(json["arrBookingItems"]!.map((x) => ArrBookingItemTwo.fromJson(x))),
        arrPayments: json["arrPayments"] == null ? [] : List<ArrPayment>.from(json["arrPayments"]!.map((x) => ArrPayment.fromJson(x))),
        arrAddCharges: json["arrAddCharges"] == null ? [] : List<ArrAddCharge>.from(json["arrAddCharges"]!.map((x) => ArrAddCharge.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "statusCode": statusCode,
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
        "intAmountExcludingVat": intAmountExcludingVat,
        "intVatAmount": intVatAmount,
        "intVatPercentage": intVatPercentage,
        "intPayedAmount": intPayedAmount,
        "intTotalDiscount": intTotalDiscount,
        "intCheckoutAmount": intCheckoutAmount,
        "intTotalVatAmount": intTotalVatAmount,
        "intRewardCoinCount": intRewardCoinCount,
        "strCusMobileNo": strCusMobileNo,
        "strMobileNo": strMobileNo,
        "strCusName": strCusName,
        "strEmail": strEmail,
        "intBalanceAmt": intBalanceAmt,
        "intDepositAmount": intDepositAmount,
        "strStartDate": strStartDate?.toIso8601String(),
        "strEndDate": strEndDate?.toIso8601String(),
        "isVatIncluded": isVatIncluded,
        "strCreatedBy": strCreatedBy,
        "strCreatedTime": strCreatedTime?.toIso8601String(),
        "arrBookingItems": arrBookingItems == null ? [] : List<dynamic>.from(arrBookingItems!.map((x) => x.toJson())),
        "arrPayments": arrPayments == null ? [] : List<dynamic>.from(arrPayments!.map((x) => x.toJson())),
        "arrAddCharges": arrAddCharges == null ? [] : List<dynamic>.from(arrAddCharges!.map((x) => x.toJson())),
    };
}

class ArrAddCharge {
    double? intAmount;
    String? strAdditionalChargeType;

    ArrAddCharge({
        this.intAmount,
        this.strAdditionalChargeType,
    });

    factory ArrAddCharge.fromJson(Map<String, dynamic> json) => ArrAddCharge(
        intAmount: json["intAmount"]?.toDouble(),
        strAdditionalChargeType: json["strAdditionalChargeType"],
    );

    Map<String, dynamic> toJson() => {
        "intAmount": intAmount,
        "strAdditionalChargeType": strAdditionalChargeType,
    };
}

class ArrBookingItemTwo {
    String? id;
    String? strCarNumber;
    dynamic strCarCode;
    DateTime? strStartDate;
    DateTime? strEndDate;
    StrLocation? strDeliveryLocation;
    StrLocation? strPickupLocation;
    String? strPickupLocationAddress;
    String? strDeliveryLocationAddress;
    int? intTotalAmount;
    int? intTotalFinalVatAmount;
    double? intAmountExcludingVat;
    double? intVatAmount;
    int? intVatPercentage;
    dynamic strBookingType;
    String? type;
    int? intPricePerDay;
    String? strImgUrl;
    String? strModel;
    int? intPricePerMonth;
    int? intPricePerWeek;
    String? arrBookingItemStrBookingId;
    String? strBookingId;
    String? strContractId;
    String? strCarId;
    String? chrStatus;
    int? intUnitPrice;
    int? intTotalDays;
    bool? isVatIncluded;
    String? strCreatedBy;
    DateTime? strCreatedTime;
    String? strStatus;
    String? strUpdatedBy;
    DateTime? strUpdatedTime;
    List<ArrTask>? arrTasks;

    ArrBookingItemTwo({
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
        this.intTotalFinalVatAmount,
        this.intAmountExcludingVat,
        this.intVatAmount,
        this.intVatPercentage,
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
        this.isVatIncluded,
        this.strCreatedBy,
        this.strCreatedTime,
        this.strStatus,
        this.strUpdatedBy,
        this.strUpdatedTime,
        this.arrTasks,
    });

    factory ArrBookingItemTwo.fromJson(Map<String, dynamic> json) => ArrBookingItemTwo(
        id: json["_id"],
        strCarNumber: json["strCarNumber"],
        strCarCode: json["strCarCode"],
        strStartDate: json["strStartDate"] == null ? null : DateTime.parse(json["strStartDate"]),
        strEndDate: json["strEndDate"] == null ? null : DateTime.parse(json["strEndDate"]),
        strDeliveryLocation: json["strDeliveryLocation"] == null ? null : StrLocation.fromJson(json["strDeliveryLocation"]),
        strPickupLocation: json["strPickupLocation"] == null ? null : StrLocation.fromJson(json["strPickupLocation"]),
        strPickupLocationAddress: json["strPickupLocationAddress"],
        strDeliveryLocationAddress: json["strDeliveryLocationAddress"],
        intTotalAmount: json["intTotalAmount"],
        intTotalFinalVatAmount: json["intTotalFinalVatAmount"],
        intAmountExcludingVat: json["intAmountExcludingVat"]?.toDouble(),
        intVatAmount: json["intVatAmount"]?.toDouble(),
        intVatPercentage: json["intVatPercentage"],
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
        intUnitPrice: json["intUnitPrice"],
        intTotalDays: json["intTotalDays"],
        isVatIncluded: json["isVatIncluded"],
        strCreatedBy: json["strCreatedBy"],
        strCreatedTime: json["strCreatedTime"] == null ? null : DateTime.parse(json["strCreatedTime"]),
        strStatus: json["strStatus"],
        strUpdatedBy: json["strUpdatedBy"],
        strUpdatedTime: json["strUpdatedTime"] == null ? null : DateTime.parse(json["strUpdatedTime"]),
        arrTasks: json["arrTasks"] == null ? [] : List<ArrTask>.from(json["arrTasks"]!.map((x) => ArrTask.fromJson(x))),
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
        "intTotalFinalVatAmount": intTotalFinalVatAmount,
        "intAmountExcludingVat": intAmountExcludingVat,
        "intVatAmount": intVatAmount,
        "intVatPercentage": intVatPercentage,
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
        "isVatIncluded": isVatIncluded,
        "strCreatedBy": strCreatedBy,
        "strCreatedTime": strCreatedTime?.toIso8601String(),
        "strStatus": strStatus,
        "strUpdatedBy": strUpdatedBy,
        "strUpdatedTime": strUpdatedTime?.toIso8601String(),
        "arrTasks": arrTasks == null ? [] : List<dynamic>.from(arrTasks!.map((x) => x.toJson())),
    };
}

class ArrTask {
    String? id;
    String? strBookingItemId;
    String? strTittle;
    String? strDescription;
    String? strTaskType;
    String? strCarNumber;
    String? strBookingId;
    DateTime? strStartDate;
    DateTime? strEndDate;
    dynamic strAssignedToId;
    dynamic strAssignedBy;
    DateTime? strDueDateAndTime;
    String? strCustomerId;
    String? chrStatus;
    String? strStatus;
    String? strCreatedBy;
    DateTime? strCreatedTime;
    dynamic strAssigneeName;

    ArrTask({
        this.id,
        this.strBookingItemId,
        this.strTittle,
        this.strDescription,
        this.strTaskType,
        this.strCarNumber,
        this.strBookingId,
        this.strStartDate,
        this.strEndDate,
        this.strAssignedToId,
        this.strAssignedBy,
        this.strDueDateAndTime,
        this.strCustomerId,
        this.chrStatus,
        this.strStatus,
        this.strCreatedBy,
        this.strCreatedTime,
        this.strAssigneeName,
    });

    factory ArrTask.fromJson(Map<String, dynamic> json) => ArrTask(
        id: json["_id"],
        strBookingItemId: json["strBookingItemId"],
        strTittle: json["strTittle"],
        strDescription: json["strDescription"],
        strTaskType: json["strTaskType"],
        strCarNumber: json["strCarNumber"],
        strBookingId: json["strBookingId"],
        strStartDate: json["strStartDate"] == null ? null : DateTime.parse(json["strStartDate"]),
        strEndDate: json["strEndDate"] == null ? null : DateTime.parse(json["strEndDate"]),
        strAssignedToId: json["strAssignedToId"],
        strAssignedBy: json["strAssignedBy"],
        strDueDateAndTime: json["strDueDateAndTime"] == null ? null : DateTime.parse(json["strDueDateAndTime"]),
        strCustomerId: json["strCustomerId"],
        chrStatus: json["chrStatus"],
        strStatus: json["strStatus"],
        strCreatedBy: json["strCreatedBy"],
        strCreatedTime: json["strCreatedTime"] == null ? null : DateTime.parse(json["strCreatedTime"]),
        strAssigneeName: json["strAssigneeName"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "strBookingItemId": strBookingItemId,
        "strTittle": strTittle,
        "strDescription": strDescription,
        "strTaskType": strTaskType,
        "strCarNumber": strCarNumber,
        "strBookingId": strBookingId,
        "strStartDate": strStartDate?.toIso8601String(),
        "strEndDate": strEndDate?.toIso8601String(),
        "strAssignedToId": strAssignedToId,
        "strAssignedBy": strAssignedBy,
        "strDueDateAndTime": strDueDateAndTime?.toIso8601String(),
        "strCustomerId": strCustomerId,
        "chrStatus": chrStatus,
        "strStatus": strStatus,
        "strCreatedBy": strCreatedBy,
        "strCreatedTime": strCreatedTime?.toIso8601String(),
        "strAssigneeName": strAssigneeName,
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

class ArrPayment {
    String? id;
    double? intAmount;
    String? strPaymentType;
    String? strPaymentMode;
    String? strBillUrl;
    String? strPaymentRecievedBy;
    DateTime? strPaymentDateTime;
    String? strStatus;
    String? strDescription;
    String? strCreatedBy;
    DateTime? strCreatedTime;
    String? shortUrl;
    String? url;

    ArrPayment({
        this.id,
        this.intAmount,
        this.strPaymentType,
        this.strPaymentMode,
        this.strBillUrl,
        this.strPaymentRecievedBy,
        this.strPaymentDateTime,
        this.strStatus,
        this.strDescription,
        this.strCreatedBy,
        this.strCreatedTime,
        this.shortUrl,
        this.url,
    });

    factory ArrPayment.fromJson(Map<String, dynamic> json) => ArrPayment(
        id: json["_id"],
        intAmount: json["intAmount"]?.toDouble(),
        strPaymentType: json["strPaymentType"],
        strPaymentMode: json["strPaymentMode"],
        strBillUrl: json["strBillUrl"],
        strPaymentRecievedBy: json["strPaymentRecievedBy"],
        strPaymentDateTime: json["strPaymentDateTime"] == null ? null : DateTime.parse(json["strPaymentDateTime"]),
        strStatus: json["strStatus"],
        strDescription: json["strDescription"],
        strCreatedBy: json["strCreatedBy"],
        strCreatedTime: json["strCreatedTime"] == null ? null : DateTime.parse(json["strCreatedTime"]),
        shortUrl: json["short_url"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "intAmount": intAmount,
        "strPaymentType": strPaymentType,
        "strPaymentMode": strPaymentMode,
        "strBillUrl": strBillUrl,
        "strPaymentRecievedBy": strPaymentRecievedBy,
        "strPaymentDateTime": strPaymentDateTime?.toIso8601String(),
        "strStatus": strStatus,
        "strDescription": strDescription,
        "strCreatedBy": strCreatedBy,
        "strCreatedTime": strCreatedTime?.toIso8601String(),
        "short_url": shortUrl,
        "url": url,
    };
}
