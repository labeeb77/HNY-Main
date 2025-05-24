import 'dart:convert';

MyCartListModel cartListModelFromJson(String str) => MyCartListModel.fromJson(json.decode(str));

String cartListModelToJson(MyCartListModel data) => json.encode(data.toJson());

class MyCartListModel {
    bool? success;
    String? message;
    int? statusCode;
    List<ArrList>? arrList;

    MyCartListModel({
        this.success = false,
        this.message = '',
        this.statusCode = 0,
        this.arrList = const [],
    });

    factory MyCartListModel.fromJson(Map<String, dynamic> json) => MyCartListModel(
        success: json["success"] ?? false,
        message: json["message"]?.toString() ?? '',
        statusCode: json["statusCode"] ?? 0,
        arrList: json["arrList"] == null ? [] : List<ArrList>.from(json["arrList"]!.map((x) => ArrList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success ?? false,
        "message": message ?? '',
        "statusCode": statusCode ?? 0,
        "arrList": arrList == null ? [] : List<dynamic>.from(arrList!.map((x) => x.toJson())),
    };
}

class ArrList {
    String? id;
    String? chrStatus;
    int? intCount;
    String? strUserId;
    String? strItemId;
    DateTime? strStartDate;
    DateTime? strEndDate;
    StrLocation? strPickupLocation;
    StrLocation? strDeliveryLocation;
    String? strPickupLocationAddress;
    String? strDeliveryLocationAddress;
    String? strCreatedBy;
    DateTime? strCreatedTime;
    ItemDetails? itemDetails;
    bool? isAvailable;

    ArrList({
        this.id = '',
        this.chrStatus = '',
        this.intCount = 0,
        this.strUserId = '',
        this.strItemId = '',
        this.strStartDate,
        this.strEndDate,
        this.strPickupLocation,
        this.strDeliveryLocation,
        this.strPickupLocationAddress = '',
        this.strDeliveryLocationAddress = '',
        this.strCreatedBy = '',
        this.strCreatedTime,
        this.itemDetails,
        this.isAvailable = false,
    });

    factory ArrList.fromJson(Map<String, dynamic> json) => ArrList(
        id: json["_id"]?.toString() ?? '',
        chrStatus: json["chrStatus"]?.toString() ?? '',
        intCount: json["intCount"] ?? 0,
        strUserId: json["strUserId"]?.toString() ?? '',
        strItemId: json["strItemId"]?.toString() ?? '',
        strStartDate: json["strStartDate"] == null ? null : DateTime.tryParse(json["strStartDate"]) ?? DateTime.now(),
        strEndDate: json["strEndDate"] == null ? null : DateTime.tryParse(json["strEndDate"]) ?? DateTime.now(),
        strPickupLocation: json["strPickupLocation"] == null ? null : StrLocation.fromJson(json["strPickupLocation"]),
        strDeliveryLocation: json["strDeliveryLocation"] == null ? null : StrLocation.fromJson(json["strDeliveryLocation"]),
        strPickupLocationAddress: json["strPickupLocationAddress"]?.toString() ?? '',
        strDeliveryLocationAddress: json["strDeliveryLocationAddress"]?.toString() ?? '',
        strCreatedBy: json["strCreatedBy"]?.toString() ?? '',
        strCreatedTime: json["strCreatedTime"] == null ? null : DateTime.tryParse(json["strCreatedTime"]) ?? DateTime.now(),
        itemDetails: json["itemDetails"] == null ? null : ItemDetails.fromJson(json["itemDetails"]),
        isAvailable: json["isAvailable"] ?? false,
    );

    Map<String, dynamic> toJson() => {
        "_id": id ?? '',
        "chrStatus": chrStatus ?? '',
        "intCount": intCount ?? 0,
        "strUserId": strUserId ?? '',
        "strItemId": strItemId ?? '',
        "strStartDate": strStartDate?.toIso8601String(),
        "strEndDate": strEndDate?.toIso8601String(),
        "strPickupLocation": strPickupLocation?.toJson(),
        "strDeliveryLocation": strDeliveryLocation?.toJson(),
        "strPickupLocationAddress": strPickupLocationAddress ?? '',
        "strDeliveryLocationAddress": strDeliveryLocationAddress ?? '',
        "strCreatedBy": strCreatedBy ?? '',
        "strCreatedTime": strCreatedTime?.toIso8601String(),
        "itemDetails": itemDetails?.toJson(),
        "isAvailable": isAvailable ?? false,
    };
}

class ItemDetails {
    String? id;
    String? strCarCode;
    String? strCarNumber;
    String? strBrand;
    String? strStatus;
    String? strType;
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
    List<ArrCarFeature>? arrCarFeatures;
    String? strCreatedBy;
    DateTime? strCreatedTime;
    String? strName;
    dynamic intTotalQty;
    dynamic intAvlQty;
    String? strImageUrl;
    String? strUpdatedBy;
    DateTime? strUpdatedTime;

    ItemDetails({
        this.id = '',
        this.strCarCode = '',
        this.strCarNumber = '',
        this.strBrand = '',
        this.strType = '',
        this.strStatus = '',
        this.chrStatus = '',
        this.strModel = '',
        this.strDescription = '',
        this.strCarCategory = '',
        this.strSeatNo = 0,
        this.strFuelType,
        this.strImgUrl = '',
        this.arrImgUrl = const [],
        this.intPower = 0,
        this.intFuelCapacity,
        this.intRating,
        this.strVarients = '',
        this.strYear,
        this.intPricePerDay = 0,
        this.intPricePerWeek = 0,
        this.intPricePerMonth = 0,
        this.arrCarFeatures = const [],
        this.strCreatedBy = '',
        this.strCreatedTime,
        this.strName = '',
        this.intTotalQty,
        this.intAvlQty,
        this.strImageUrl = '',
        this.strUpdatedBy = '',
        this.strUpdatedTime,
    });

    factory ItemDetails.fromJson(Map<String, dynamic> json) => ItemDetails(
        id: json["_id"]?.toString() ?? '',
        strCarCode: json["strCarCode"]?.toString() ?? '',
        strCarNumber: json["strCarNumber"]?.toString() ?? '',
        strBrand: json["strBrand"]?.toString() ?? '',
        strStatus: json["strStatus"]?.toString() ?? '',
        chrStatus: json["chrStatus"]?.toString() ?? '',
        strType:json["strType"]?.toString()??'',
        strModel: json["strModel"]?.toString() ?? '',
        strDescription: json["strDescription"]?.toString() ?? '',
        strCarCategory: json["strCarCategory"]?.toString() ?? '',
        strSeatNo: json["strSeatNo"] ?? 0,
        strFuelType: json["strFuelType"],
        strImgUrl: json["strImgUrl"]?.toString() ?? '',
        arrImgUrl: json["arrImgUrl"] == null ? [] : List<String>.from(json["arrImgUrl"]!.map((x) => x?.toString() ?? '')),
        intPower: json["intPower"] ?? 0,
        intFuelCapacity: json["intFuelCapacity"],
        intRating: json["intRating"],
        strVarients: json["strVarients"]?.toString() ?? '',
        strYear: json["strYear"],
        intPricePerDay: json["intPricePerDay"] ?? 0,
        intPricePerWeek: json["intPricePerWeek"] ?? 0,
        intPricePerMonth: json["intPricePerMonth"] ?? 0,
        arrCarFeatures: json["arrCarFeatures"] == null ? [] : List<ArrCarFeature>.from(json["arrCarFeatures"]!.map((x) => ArrCarFeature.fromJson(x))),
        strCreatedBy: json["strCreatedBy"]?.toString() ?? '',
        strCreatedTime: json["strCreatedTime"] == null ? null : DateTime.tryParse(json["strCreatedTime"]) ?? DateTime.now(),
        strName: json["strName"]?.toString() ?? '',
        intTotalQty: json["intTotalQty"],
        intAvlQty: json["intAvlQty"],
        strImageUrl: json["strImageUrl"]?.toString() ?? '',
        strUpdatedBy: json["strUpdatedBy"]?.toString() ?? '',
        strUpdatedTime: json["strUpdatedTime"] == null ? null : DateTime.tryParse(json["strUpdatedTime"]) ?? DateTime.now(),
    );

    Map<String, dynamic> toJson() => {
        "_id": id ?? '',
        "strCarCode": strCarCode ?? '',
        "strCarNumber": strCarNumber ?? '',
        "strBrand": strBrand ?? '',
        "strStatus": strStatus ?? '',
        "strType":strType??'',
        "chrStatus": chrStatus ?? '',
        "strModel": strModel ?? '',
        "strDescription": strDescription ?? '',
        "strCarCategory": strCarCategory ?? '',
        "strSeatNo": strSeatNo ?? 0,
        "strFuelType": strFuelType,
        "strImgUrl": strImgUrl ?? '',
        "arrImgUrl": arrImgUrl == null ? [] : List<dynamic>.from(arrImgUrl!.map((x) => x)),
        "intPower": intPower ?? 0,
        "intFuelCapacity": intFuelCapacity,
        "intRating": intRating,
        "strVarients": strVarients ?? '',
        "strYear": strYear,
        "intPricePerDay": intPricePerDay ?? 0,
        "intPricePerWeek": intPricePerWeek ?? 0,
        "intPricePerMonth": intPricePerMonth ?? 0,
        "arrCarFeatures": arrCarFeatures == null ? [] : List<dynamic>.from(arrCarFeatures!.map((x) => x.toJson())),
        "strCreatedBy": strCreatedBy ?? '',
        "strCreatedTime": strCreatedTime?.toIso8601String(),
        "strName": strName ?? '',
        "intTotalQty": intTotalQty,
        "intAvlQty": intAvlQty,
        "strImageUrl": strImageUrl ?? '',
        "strUpdatedBy": strUpdatedBy ?? '',
        "strUpdatedTime": strUpdatedTime?.toIso8601String(),
    };
}

class ArrCarFeature {
    String? strFeatures;
    String? strDescription;

    ArrCarFeature({
        this.strFeatures = '',
        this.strDescription = '',
    });

    factory ArrCarFeature.fromJson(Map<String, dynamic> json) => ArrCarFeature(
        strFeatures: json["strFeatures"]?.toString() ?? '',
        strDescription: json["strDescription"]?.toString() ?? '',
    );

    Map<String, dynamic> toJson() => {
        "strFeatures": strFeatures ?? '',
        "strDescription": strDescription ?? '',
    };
}

class StrLocation {
    String? type;
    List<double>? coordinates;

    StrLocation({
        this.type = 'Point',
        this.coordinates = const [],
    });

    factory StrLocation.fromJson(Map<String, dynamic> json) => StrLocation(
        type: json["type"]?.toString() ?? 'Point',
        coordinates: json["coordinates"] == null ? [] : List<double>.from(json["coordinates"]!.map((x) => x?.toDouble() ?? 0.0)),
    );

    Map<String, dynamic> toJson() => {
        "type": type ?? 'Point',
        "coordinates": coordinates == null ? [] : List<dynamic>.from(coordinates!.map((x) => x)),
    };
}