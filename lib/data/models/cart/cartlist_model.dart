import 'dart:convert';

MyCartListModel cartListModelFromJson(String str) => MyCartListModel.fromJson(json.decode(str));

String cartListModelToJson(MyCartListModel data) => json.encode(data.toJson());

class MyCartListModel {
    bool? success;
    String? message;
    int? statusCode;
    List<ArrList>? arrList;

    MyCartListModel({
        this.success,
        this.message,
        this.statusCode,
        this.arrList,
    });

    factory MyCartListModel.fromJson(Map<String, dynamic> json) => MyCartListModel(
        success: json["success"],
        message: json["message"],
        statusCode: json["statusCode"],
        arrList: json["arrList"] == null ? [] : List<ArrList>.from(json["arrList"]!.map((x) => ArrList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "statusCode": statusCode,
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
        this.id,
        this.chrStatus,
        this.intCount,
        this.strUserId,
        this.strItemId,
        this.strStartDate,
        this.strEndDate,
        this.strPickupLocation,
        this.strDeliveryLocation,
        this.strPickupLocationAddress,
        this.strDeliveryLocationAddress,
        this.strCreatedBy,
        this.strCreatedTime,
        this.itemDetails,
        this.isAvailable,
    });

    factory ArrList.fromJson(Map<String, dynamic> json) => ArrList(
        id: json["_id"],
        chrStatus: json["chrStatus"],
        intCount: json["intCount"],
        strUserId: json["strUserId"],
        strItemId: json["strItemId"],
        strStartDate: json["strStartDate"] == null ? null : DateTime.parse(json["strStartDate"]),
        strEndDate: json["strEndDate"] == null ? null : DateTime.parse(json["strEndDate"]),
        strPickupLocation: json["strPickupLocation"] == null ? null : StrLocation.fromJson(json["strPickupLocation"]),
        strDeliveryLocation: json["strDeliveryLocation"] == null ? null : StrLocation.fromJson(json["strDeliveryLocation"]),
        strPickupLocationAddress: json["strPickupLocationAddress"],
        strDeliveryLocationAddress: json["strDeliveryLocationAddress"],
        strCreatedBy: json["strCreatedBy"],
        strCreatedTime: json["strCreatedTime"] == null ? null : DateTime.parse(json["strCreatedTime"]),
        itemDetails: json["itemDetails"] == null ? null : ItemDetails.fromJson(json["itemDetails"]),
        isAvailable: json["isAvailable"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "chrStatus": chrStatus,
        "intCount": intCount,
        "strUserId": strUserId,
        "strItemId": strItemId,
        "strStartDate": strStartDate?.toIso8601String(),
        "strEndDate": strEndDate?.toIso8601String(),
        "strPickupLocation": strPickupLocation?.toJson(),
        "strDeliveryLocation": strDeliveryLocation?.toJson(),
        "strPickupLocationAddress": strPickupLocationAddress,
        "strDeliveryLocationAddress": strDeliveryLocationAddress,
        "strCreatedBy": strCreatedBy,
        "strCreatedTime": strCreatedTime?.toIso8601String(),
        "itemDetails": itemDetails?.toJson(),
        "isAvailable": isAvailable,
    };
}

class ItemDetails {
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
        this.strName,
        this.intTotalQty,
        this.intAvlQty,
        this.strImageUrl,
        this.strUpdatedBy,
        this.strUpdatedTime,
    });

    factory ItemDetails.fromJson(Map<String, dynamic> json) => ItemDetails(
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
        arrCarFeatures: json["arrCarFeatures"] == null ? [] : List<ArrCarFeature>.from(json["arrCarFeatures"]!.map((x) => ArrCarFeature.fromJson(x))),
        strCreatedBy: json["strCreatedBy"],
        strCreatedTime: json["strCreatedTime"] == null ? null : DateTime.parse(json["strCreatedTime"]),
        strName: json["strName"],
        intTotalQty: json["intTotalQty"],
        intAvlQty: json["intAvlQty"],
        strImageUrl: json["strImageUrl"],
        strUpdatedBy: json["strUpdatedBy"],
        strUpdatedTime: json["strUpdatedTime"] == null ? null : DateTime.parse(json["strUpdatedTime"]),
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
        "arrCarFeatures": arrCarFeatures == null ? [] : List<dynamic>.from(arrCarFeatures!.map((x) => x.toJson())),
        "strCreatedBy": strCreatedBy,
        "strCreatedTime": strCreatedTime?.toIso8601String(),
        "strName": strName,
        "intTotalQty": intTotalQty,
        "intAvlQty": intAvlQty,
        "strImageUrl": strImageUrl,
        "strUpdatedBy": strUpdatedBy,
        "strUpdatedTime": strUpdatedTime?.toIso8601String(),
    };
}

class ArrCarFeature {
    String? strFeatures;
    String? strDescription;

    ArrCarFeature({
        this.strFeatures,
        this.strDescription,
    });

    factory ArrCarFeature.fromJson(Map<String, dynamic> json) => ArrCarFeature(
        strFeatures: json["strFeatures"],
        strDescription: json["strDescription"],
    );

    Map<String, dynamic> toJson() => {
        "strFeatures": strFeatures,
        "strDescription": strDescription,
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