// To parse this JSON data, do
//
//     final reservationItemDetailsModel = reservationItemDetailsModelFromJson(jsonString);

import 'dart:convert';

ReservationItemDetailsModel reservationItemDetailsModelFromJson(String str) =>
    ReservationItemDetailsModel.fromJson(json.decode(str));

String reservationItemDetailsModelToJson(ReservationItemDetailsModel data) =>
    json.encode(data.toJson());

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
  dynamic intTotalAmount;
  dynamic intAmountExcludingVat;
  dynamic intVatAmount;
  dynamic intVatPercentage;
  dynamic intPayedAmount;
  dynamic intTotalDiscount;
  dynamic intCheckoutAmount;
  dynamic intTotalVatAmount;
  dynamic intRewardCoinCount;
  String? strCusMobileNo;
  String? strMobileNo;
  String? strCusName;
  String? strName;
  String? strEmail;
  dynamic intBalanceAmt;
  dynamic intDepositAmount;
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
    this.strName,
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

  factory ReservationItemDetailsModel.fromJson(Map<String, dynamic> json) =>
      ReservationItemDetailsModel(
        success: json["success"] ?? false,
        message: json["message"] ?? '',
        statusCode: json["statusCode"] ?? 0,
        id: json["_id"] ?? '',
        chrStatus: json["chrStatus"] ?? '',
        strStatus: json["strStatus"] ?? '',
        strCustomerId: json["strCustomerId"] ?? '',
        strBookingId: json["strBookingId"] ?? '',
        strBookingType: json["strBookingType"] ?? '',
        strPaymentMode: json["strPaymentMode"] ?? '',
        strRemarks: json["strRemarks"] ?? '',
        strPromocode: json["strPromocode"] ?? '',
        intPromocodeDiscount: json["intPromocodeDiscount"] ?? 0,
        intCoinsUsed: json["intCoinsUsed"] ?? 0,
        intCoinDiscount: json["intCoinDiscount"] ?? 0,
        intTotalAmount: json["intTotalAmount"] ?? 0,
        intAmountExcludingVat: json["intAmountExcludingVat"] ?? 0,
        intVatAmount: json["intVatAmount"] ?? 0,
        intVatPercentage: json["intVatPercentage"] ?? 0,
        intPayedAmount: json["intPayedAmount"] ?? 0,
        intTotalDiscount: json["intTotalDiscount"] ?? 0,
        intCheckoutAmount: json["intCheckoutAmount"] ?? 0,
        intTotalVatAmount: json["intTotalVatAmount"] ?? 0,
        intRewardCoinCount: json["intRewardCoinCount"] ?? 0,
        strCusMobileNo: json["strCusMobileNo"] ?? '',
        strMobileNo: json["strMobileNo"] ?? '',
        strCusName: json["strCusName"] ?? '',
        strName: json["strName"] ?? '',
        strEmail: json["strEmail"] ?? '',
        intBalanceAmt: json["intBalanceAmt"] ?? 0,
        intDepositAmount: json["intDepositAmount"] ?? 0,
        strStartDate: json["strStartDate"] == null
            ? null
            : DateTime.parse(json["strStartDate"]),
        strEndDate: json["strEndDate"] == null
            ? null
            : DateTime.parse(json["strEndDate"]),
        isVatIncluded: json["isVatIncluded"] ?? false,
        strCreatedBy: json["strCreatedBy"] ?? '',
        strCreatedTime: json["strCreatedTime"] == null
            ? null
            : DateTime.parse(json["strCreatedTime"]),
        arrBookingItems: json["arrBookingItems"] == null
            ? []
            : List<ArrBookingItemTwo>.from(json["arrBookingItems"]!
                .map((x) => ArrBookingItemTwo.fromJson(x))),
        arrPayments: json["arrPayments"] == null
            ? []
            : List<ArrPayment>.from(
                json["arrPayments"]!.map((x) => ArrPayment.fromJson(x))),
        arrAddCharges: json["arrAddCharges"] == null
            ? []
            : List<ArrAddCharge>.from(
                json["arrAddCharges"]!.map((x) => ArrAddCharge.fromJson(x))),
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
        "strName": strName,
        "strEmail": strEmail,
        "intBalanceAmt": intBalanceAmt,
        "intDepositAmount": intDepositAmount,
        "strStartDate": strStartDate?.toIso8601String(),
        "strEndDate": strEndDate?.toIso8601String(),
        "isVatIncluded": isVatIncluded,
        "strCreatedBy": strCreatedBy,
        "strCreatedTime": strCreatedTime?.toIso8601String(),
        "arrBookingItems": arrBookingItems == null
            ? []
            : List<dynamic>.from(arrBookingItems!.map((x) => x.toJson())),
        "arrPayments": arrPayments == null
            ? []
            : List<dynamic>.from(arrPayments!.map((x) => x.toJson())),
        "arrAddCharges": arrAddCharges == null
            ? []
            : List<dynamic>.from(arrAddCharges!.map((x) => x.toJson())),
      };
}

class ArrAddCharge {
  dynamic intAmount;
  String? strAdditionalChargeType;
  dynamic count;

  ArrAddCharge({
    this.intAmount,
    this.strAdditionalChargeType,
    this.count,
  });

  factory ArrAddCharge.fromJson(Map<String, dynamic> json) => ArrAddCharge(
        intAmount: json["intAmount"] ?? 0,
        strAdditionalChargeType: json["strAdditionalChargeType"] ?? '',
        count: json["count"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "intAmount": intAmount ?? 0,
        "strAdditionalChargeType": strAdditionalChargeType ?? '',
        "count": count ?? 0,
      };
}

class ReservArrCar {
  String? id;
  String? strCarCode;
  String? strCarNumber;
  String? strBrand;
  String? strStatus;
  String? chrStatus;
  String? strModel;
  String? strDescription;
  String? strCarCategory;
  dynamic strSeatNo;
  String? strFuelType;
  String? strImgUrl;
  List<String?>? arrImgUrl;
  dynamic intPower;
  dynamic intFuelCapacity;
  dynamic intRating;
  String? strVarients;
  String? strYear;
  String? strColor;
  dynamic intPricePerDay;
  dynamic intPricePerWeek;
  dynamic intPricePerMonth;
  List<CarFeature>? arrCarFeatures;
  String? strCreatedBy;
  DateTime? strCreatedTime;

  ReservArrCar({
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
  });

  factory ReservArrCar.fromJson(Map<String, dynamic> json) => ReservArrCar(
        id: json["_id"] ?? '',
        strCarCode: json["strCarCode"] ?? '',
        strCarNumber: json["strCarNumber"] ?? '',
        strBrand: json["strBrand"] ?? '',
        strStatus: json["strStatus"] ?? '',
        chrStatus: json["chrStatus"] ?? '',
        strModel: json["strModel"] ?? '',
        strDescription: json["strDescription"] ?? '',
        strCarCategory: json["strCarCategory"] ?? '',
        strSeatNo: json["strSeatNo"] ?? 0,
        strFuelType: json["strFuelType"] ?? '',
        strImgUrl: json["strImgUrl"] ?? '',
        arrImgUrl: json["arrImgUrl"] == null
            ? []
            : List<String?>.from(json["arrImgUrl"]!.map((x) => x ?? '')),
        intPower: json["intPower"] ?? 0,
        intFuelCapacity: json["intFuelCapacity"] ?? 0,
        intRating: json["intRating"] ?? 0,
        strVarients: json["strVarients"] ?? '',
        strYear: json["strYear"] ?? '',
        strColor: json["strColor"] ?? '',
        intPricePerDay: json["intPricePerDay"] ?? 0,
        intPricePerWeek: json["intPricePerWeek"] ?? 0,
        intPricePerMonth: json["intPricePerMonth"] ?? 0,
        arrCarFeatures: json["arrCarFeatures"] == null
            ? []
            : List<CarFeature>.from(
                json["arrCarFeatures"]!.map((x) => CarFeature.fromJson(x))),
        strCreatedBy: json["strCreatedBy"] ?? '',
        strCreatedTime: json["strCreatedTime"] == null
            ? null
            : DateTime.parse(json["strCreatedTime"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id ?? '',
        "strCarCode": strCarCode ?? '',
        "strCarNumber": strCarNumber ?? '',
        "strBrand": strBrand ?? '',
        "strStatus": strStatus ?? '',
        "chrStatus": chrStatus ?? '',
        "strModel": strModel ?? '',
        "strDescription": strDescription ?? '',
        "strCarCategory": strCarCategory ?? '',
        "strSeatNo": strSeatNo ?? 0,
        "strFuelType": strFuelType ?? '',
        "strImgUrl": strImgUrl ?? '',
        "arrImgUrl": arrImgUrl == null
            ? []
            : List<dynamic>.from(arrImgUrl!.map((x) => x ?? '')),
        "intPower": intPower ?? 0,
        "intFuelCapacity": intFuelCapacity ?? 0,
        "intRating": intRating ?? 0,
        "strVarients": strVarients ?? '',
        "strYear": strYear ?? '',
        "strColor": strColor ?? '',
        "intPricePerDay": intPricePerDay ?? 0,
        "intPricePerWeek": intPricePerWeek ?? 0,
        "intPricePerMonth": intPricePerMonth ?? 0,
        "arrCarFeatures": arrCarFeatures == null
            ? []
            : List<dynamic>.from(arrCarFeatures!.map((x) => x.toJson())),
        "strCreatedBy": strCreatedBy ?? '',
        "strCreatedTime": strCreatedTime?.toIso8601String(),
      };
}

class CarFeature {
  String? strFeatures;
  String? strDescription;

  CarFeature({
    this.strFeatures,
    this.strDescription,
  });

  factory CarFeature.fromJson(Map<String, dynamic> json) => CarFeature(
        strFeatures: json["strFeatures"] ?? '',
        strDescription: json["strDescription"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "strFeatures": strFeatures ?? '',
        "strDescription": strDescription ?? '',
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
  dynamic intTotalAmount;
  dynamic intTotalFinalVatAmount;
  dynamic intAmountExcludingVat;
  dynamic intVatAmount;
  dynamic intVatPercentage;
  dynamic strBookingType;
  String? type;
  dynamic intPricePerDay;
  String? strImgUrl;
  String? strModel;
  dynamic intPricePerMonth;
  dynamic intPricePerWeek;
  String? arrBookingItemStrBookingId;
  String? strBookingId;
  String? strContractId;
  String? strCarId;
  String? chrStatus;
  dynamic intUnitPrice;
  dynamic intTotalDays;
  bool? isVatIncluded;
  String? strCreatedBy;
  DateTime? strCreatedTime;
  String? strStatus;
  String? strUpdatedBy;
  DateTime? strUpdatedTime;
  List<ArrTask>? arrTasks;
  List<ReservArrCar>? reservArrCar;
  String? strName;
  String? strDescription;
  dynamic intQty;
  dynamic intTotalFinalAmount;
  String? strAddOnItemId;
  String? strAddOnName;
  String? strAssigneeName;
  dynamic intCancellationFee;
  dynamic intDeductionAmount;
  dynamic intOldTotalAmount;

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
    this.reservArrCar,
    this.strName,
    this.strDescription,
    this.intQty,
    this.intTotalFinalAmount,
    this.strAddOnItemId,
    this.strAddOnName,
    this.strAssigneeName,
    this.intCancellationFee,
    this.intDeductionAmount,
    this.intOldTotalAmount,
  });

  factory ArrBookingItemTwo.fromJson(Map<String, dynamic> json) =>
      ArrBookingItemTwo(
        id: json["_id"] ?? '',
        strCarNumber: json["strCarNumber"] ?? '',
        strCarCode: json["strCarCode"] ?? '',
        strStartDate: json["strStartDate"] == null
            ? null
            : DateTime.parse(json["strStartDate"]),
        strEndDate: json["strEndDate"] == null
            ? null
            : DateTime.parse(json["strEndDate"]),
        strDeliveryLocation: json["strDeliveryLocation"] == null
            ? null
            : StrLocation.fromJson(json["strDeliveryLocation"]),
        strPickupLocation: json["strPickupLocation"] == null
            ? null
            : StrLocation.fromJson(json["strPickupLocation"]),
        strPickupLocationAddress: json["strPickupLocationAddress"] ?? '',
        strDeliveryLocationAddress: json["strDeliveryLocationAddress"] ?? '',
        intTotalAmount: json["intTotalAmount"] ?? 0,
        intTotalFinalVatAmount: json["intTotalFinalVatAmount"] ?? 0,
        intAmountExcludingVat: json["intAmountExcludingVat"] ?? 0,
        intVatAmount: json["intVatAmount"] ?? 0,
        intVatPercentage: json["intVatPercentage"] ?? 0,
        strBookingType: json["strBookingType"] ?? '',
        type: json["type"] ?? '',
        intPricePerDay: json["intPricePerDay"] ?? 0,
        strImgUrl: json["strImgUrl"] ?? '',
        strModel: json["strModel"] ?? '',
        intPricePerMonth: json["intPricePerMonth"] ?? 0,
        intPricePerWeek: json["intPricePerWeek"] ?? 0,
        arrBookingItemStrBookingId: json["strBooking_Id"] ?? '',
        strBookingId: json["strBookingId"] ?? '',
        strContractId: json["strContractId"] ?? '',
        strCarId: json["strCarId"] ?? '',
        chrStatus: json["chrStatus"] ?? '',
        intUnitPrice: json["intUnitPrice"] ?? 0,
        intTotalDays: json["intTotalDays"] ?? 0,
        isVatIncluded: json["isVatIncluded"] ?? false,
        strCreatedBy: json["strCreatedBy"] ?? '',
        strCreatedTime: json["strCreatedTime"] == null
            ? null
            : DateTime.parse(json["strCreatedTime"]),
        strStatus: json["strStatus"] ?? '',
        strUpdatedBy: json["strUpdatedBy"] ?? '',
        strUpdatedTime: json["strUpdatedTime"] == null
            ? null
            : DateTime.parse(json["strUpdatedTime"]),
        arrTasks: json["arrTasks"] == null
            ? []
            : List<ArrTask>.from(
                json["arrTasks"]!.map((x) => ArrTask.fromJson(x))),
        reservArrCar: json["arrCar"] == null
            ? []
            : List<ReservArrCar>.from(
                json["arrCar"]!.map((x) => ReservArrCar.fromJson(x))),
        strName: json["strName"] ?? '',
        strDescription: json["strDescription"] ?? '',
        intQty: json["intQty"] ?? 0,
        intTotalFinalAmount: json["intTotalFinalAmount"] ?? 0,
        strAddOnItemId: json["strAddOnItemId"] ?? '',
        strAddOnName: json["strAddOnName"] ?? '',
        strAssigneeName: json["strAssigneeName"] ?? '',
        intCancellationFee: json["intCancellationFee"] ?? 0,
        intDeductionAmount: json["intDeductionAmount"] ?? 0,
        intOldTotalAmount: json["intOldTotalAmount"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "_id": id ?? '',
        "strCarNumber": strCarNumber ?? '',
        "strCarCode": strCarCode ?? '',
        "strStartDate": strStartDate?.toIso8601String(),
        "strEndDate": strEndDate?.toIso8601String(),
        "strDeliveryLocation": strDeliveryLocation?.toJson(),
        "strPickupLocation": strPickupLocation?.toJson(),
        "strPickupLocationAddress": strPickupLocationAddress ?? '',
        "strDeliveryLocationAddress": strDeliveryLocationAddress ?? '',
        "intTotalAmount": intTotalAmount ?? 0,
        "intTotalFinalVatAmount": intTotalFinalVatAmount ?? 0,
        "intAmountExcludingVat": intAmountExcludingVat ?? 0,
        "intVatAmount": intVatAmount ?? 0,
        "intVatPercentage": intVatPercentage ?? 0,
        "strBookingType": strBookingType ?? '',
        "type": type ?? '',
        "intPricePerDay": intPricePerDay ?? 0,
        "strImgUrl": strImgUrl ?? '',
        "strModel": strModel ?? '',
        "intPricePerMonth": intPricePerMonth ?? 0,
        "intPricePerWeek": intPricePerWeek ?? 0,
        "strBooking_Id": arrBookingItemStrBookingId ?? '',
        "strBookingId": strBookingId ?? '',
        "strContractId": strContractId ?? '',
        "strCarId": strCarId ?? '',
        "chrStatus": chrStatus ?? '',
        "intUnitPrice": intUnitPrice ?? 0,
        "intTotalDays": intTotalDays ?? 0,
        "isVatIncluded": isVatIncluded ?? false,
        "strCreatedBy": strCreatedBy ?? '',
        "strCreatedTime": strCreatedTime?.toIso8601String(),
        "strStatus": strStatus ?? '',
        "strUpdatedBy": strUpdatedBy ?? '',
        "strUpdatedTime": strUpdatedTime?.toIso8601String(),
        "arrTasks": arrTasks == null
            ? []
            : List<dynamic>.from(arrTasks!.map((x) => x.toJson())),
        "arrCar": reservArrCar == null
            ? []
            : List<dynamic>.from(reservArrCar!.map((x) => x.toJson())),
        "strName": strName ?? '',
        "strDescription": strDescription ?? '',
        "intQty": intQty ?? 0,
        "intTotalFinalAmount": intTotalFinalAmount ?? 0,
        "strAddOnItemId": strAddOnItemId ?? '',
        "strAddOnName": strAddOnName ?? '',
        "strAssigneeName": strAssigneeName ?? '',
        "intCancellationFee": intCancellationFee ?? 0,
        "intDeductionAmount": intDeductionAmount ?? 0,
        "intOldTotalAmount": intOldTotalAmount ?? 0,
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
        id: json["_id"] ?? '',
        strBookingItemId: json["strBookingItemId"] ?? '',
        strTittle: json["strTittle"] ?? '',
        strDescription: json["strDescription"] ?? '',
        strTaskType: json["strTaskType"] ?? '',
        strCarNumber: json["strCarNumber"] ?? '',
        strBookingId: json["strBookingId"] ?? '',
        strStartDate: json["strStartDate"] == null
            ? null
            : DateTime.parse(json["strStartDate"]),
        strEndDate: json["strEndDate"] == null
            ? null
            : DateTime.parse(json["strEndDate"]),
        strAssignedToId: json["strAssignedToId"] ?? '',
        strAssignedBy: json["strAssignedBy"] ?? '',
        strDueDateAndTime: json["strDueDateAndTime"] == null
            ? null
            : DateTime.parse(json["strDueDateAndTime"]),
        strCustomerId: json["strCustomerId"] ?? '',
        chrStatus: json["chrStatus"] ?? '',
        strStatus: json["strStatus"] ?? '',
        strCreatedBy: json["strCreatedBy"] ?? '',
        strCreatedTime: json["strCreatedTime"] == null
            ? null
            : DateTime.parse(json["strCreatedTime"]),
        strAssigneeName: json["strAssigneeName"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "_id": id ?? '',
        "strBookingItemId": strBookingItemId ?? '',
        "strTittle": strTittle ?? '',
        "strDescription": strDescription ?? '',
        "strTaskType": strTaskType ?? '',
        "strCarNumber": strCarNumber ?? '',
        "strBookingId": strBookingId ?? '',
        "strStartDate": strStartDate?.toIso8601String(),
        "strEndDate": strEndDate?.toIso8601String(),
        "strAssignedToId": strAssignedToId ?? '',
        "strAssignedBy": strAssignedBy ?? '',
        "strDueDateAndTime": strDueDateAndTime?.toIso8601String(),
        "strCustomerId": strCustomerId ?? '',
        "chrStatus": chrStatus ?? '',
        "strStatus": strStatus ?? '',
        "strCreatedBy": strCreatedBy ?? '',
        "strCreatedTime": strCreatedTime?.toIso8601String(),
        "strAssigneeName": strAssigneeName ?? '',
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
        type: json["type"] ?? '',
        coordinates: json["coordinates"] == null
            ? []
            : List<double>.from(json["coordinates"]!.map((x) => (x ?? 0).toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "type": type ?? '',
        "coordinates": coordinates == null
            ? []
            : List<dynamic>.from(coordinates!.map((x) => x ?? 0)),
      };
}

class ArrPayment {
  String? id;
  dynamic intAmount;
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
        id: json["_id"] ?? '',
        intAmount: json["intAmount"] ?? 0,
        strPaymentType: json["strPaymentType"] ?? '',
        strPaymentMode: json["strPaymentMode"] ?? '',
        strBillUrl: json["strBillUrl"] ?? '',
        strPaymentRecievedBy: json["strPaymentRecievedBy"] ?? '',
        strPaymentDateTime: json["strPaymentDateTime"] == null
            ? null
            : DateTime.parse(json["strPaymentDateTime"]),
        strStatus: json["strStatus"] ?? '',
        strDescription: json["strDescription"] ?? '',
        strCreatedBy: json["strCreatedBy"] ?? '',
        strCreatedTime: json["strCreatedTime"] == null
            ? null
            : DateTime.parse(json["strCreatedTime"]),
        shortUrl: json["short_url"] ?? '',
        url: json["url"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "_id": id ?? '',
        "intAmount": intAmount ?? 0,
        "strPaymentType": strPaymentType ?? '',
        "strPaymentMode": strPaymentMode ?? '',
        "strBillUrl": strBillUrl ?? '',
        "strPaymentRecievedBy": strPaymentRecievedBy ?? '',
        "strPaymentDateTime": strPaymentDateTime?.toIso8601String(),
        "strStatus": strStatus ?? '',
        "strDescription": strDescription ?? '',
        "strCreatedBy": strCreatedBy ?? '',
        "strCreatedTime": strCreatedTime?.toIso8601String(),
        "short_url": shortUrl ?? '',
        "url": url ?? '',
      };
}
