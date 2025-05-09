import 'dart:convert';

FavouritesModel favouritesModelFromJson(String str) =>
    FavouritesModel.fromJson(json.decode(str));

String favouritesModelToJson(FavouritesModel data) =>
    json.encode(data.toJson());

class FavouritesModel {
  final bool success;
  final String message;
  final int statusCode;
  final List<FavArrList> arrList;

  FavouritesModel({
    this.success = false,
    this.message = '',
    this.statusCode = 0,
    this.arrList = const [],
  });

  factory FavouritesModel.fromJson(Map<String, dynamic> json) =>
      FavouritesModel(
        success: json["success"] ?? false,
        message: json["message"]?.toString() ?? '',
        statusCode: json["statusCode"]?.toInt() ?? 0,
        arrList: json["arrList"] == null
            ? []
            : List<FavArrList>.from(
                json["arrList"]!.map((x) => FavArrList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "statusCode": statusCode,
        "arrList": List<dynamic>.from(arrList.map((x) => x.toJson())),
      };
}

class FavArrList {
  final String id;
  final String chrStatus;
  final String strCreatedBy;
  final String strCarId;
  final DateTime? strCreatedTime;
  final CarData? carData;

  FavArrList({
    this.id = '',
    this.chrStatus = '',
    this.strCreatedBy = '',
    this.strCarId = '',
    this.strCreatedTime,
    this.carData,
  });

  factory FavArrList.fromJson(Map<String, dynamic> json) => FavArrList(
        id: json["_id"]?.toString() ?? '',
        chrStatus: json["chrStatus"]?.toString() ?? '',
        strCreatedBy: json["strCreatedBy"]?.toString() ?? '',
        strCarId: json["strCarId"]?.toString() ?? '',
        strCreatedTime: json["strCreatedTime"] == null
            ? null
            : DateTime.tryParse(json["strCreatedTime"]),
        carData: json["carData"] == null 
            ? null 
            : CarData.fromJson(json["carData"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "chrStatus": chrStatus,
        "strCreatedBy": strCreatedBy,
        "strCarId": strCarId,
        "strCreatedTime": strCreatedTime?.toIso8601String(),
        "carData": carData?.toJson(),
      };
}

class CarData {
  final String id;
  final String strCarNumber;
  final String strBrand;
  final String strStatus;
  final String chrStatus;
  final String strModel;
  final String strDescription;
  final String strCarCategory;
  final int strSeatNo;
  final String strFuelType;
  final String strImgUrl;
  final List<String> arrImgUrl;
  final int intPower;
  final double intFuelCapacity;
  final double intRating;
  final String strVarients;
  final String strYear;
  final int intPricePerDay;
  final int intPricePerWeek;
  final int intPricePerMonth;
  final List<ArrCarFeature> arrCarFeatures;
  final String strCreatedBy;
  final DateTime? strCreatedTime;

  CarData({
    this.id = '',
    this.strCarNumber = '',
    this.strBrand = '',
    this.strStatus = '',
    this.chrStatus = '',
    this.strModel = '',
    this.strDescription = '',
    this.strCarCategory = '',
    this.strSeatNo = 0,
    this.strFuelType = '',
    this.strImgUrl = '',
    this.arrImgUrl = const [],
    this.intPower = 0,
    this.intFuelCapacity = 0.0,
    this.intRating = 0.0,
    this.strVarients = '',
    this.strYear = '',
    this.intPricePerDay = 0,
    this.intPricePerWeek = 0,
    this.intPricePerMonth = 0,
    this.arrCarFeatures = const [],
    this.strCreatedBy = '',
    this.strCreatedTime,
  });

  factory CarData.fromJson(Map<String, dynamic> json) => CarData(
        id: json["_id"]?.toString() ?? '',
        strCarNumber: json["strCarNumber"]?.toString() ?? '',
        strBrand: json["strBrand"]?.toString() ?? '',
        strStatus: json["strStatus"]?.toString() ?? '',
        chrStatus: json["chrStatus"]?.toString() ?? '',
        strModel: json["strModel"]?.toString() ?? '',
        strDescription: json["strDescription"]?.toString() ?? '',
        strCarCategory: json["strCarCategory"]?.toString() ?? '',
        strSeatNo: json["strSeatNo"]?.toInt() ?? 0,
        strFuelType: json["strFuelType"]?.toString() ?? '',
        strImgUrl: json["strImgUrl"]?.toString() ?? '',
        arrImgUrl: json["arrImgUrl"] == null
            ? []
            : List<String>.from(json["arrImgUrl"]!.map((x) => x.toString())),
        intPower: json["intPower"]?.toInt() ?? 0,
        intFuelCapacity: (json["intFuelCapacity"] ?? 0).toDouble(),
        intRating: (json["intRating"] ?? 0).toDouble(),
        strVarients: json["strVarients"]?.toString() ?? '',
        strYear: json["strYear"]?.toString() ?? '',
        intPricePerDay: json["intPricePerDay"]?.toInt() ?? 0,
        intPricePerWeek: json["intPricePerWeek"]?.toInt() ?? 0,
        intPricePerMonth: json["intPricePerMonth"]?.toInt() ?? 0,
        arrCarFeatures: json["arrCarFeatures"] == null
            ? []
            : List<ArrCarFeature>.from(
                json["arrCarFeatures"]!.map((x) => ArrCarFeature.fromJson(x))),
        strCreatedBy: json["strCreatedBy"]?.toString() ?? '',
        strCreatedTime: json["strCreatedTime"] == null
            ? null
            : DateTime.tryParse(json["strCreatedTime"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
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
        "arrImgUrl": List<dynamic>.from(arrImgUrl.map((x) => x)),
        "intPower": intPower,
        "intFuelCapacity": intFuelCapacity,
        "intRating": intRating,
        "strVarients": strVarients,
        "strYear": strYear,
        "intPricePerDay": intPricePerDay,
        "intPricePerWeek": intPricePerWeek,
        "intPricePerMonth": intPricePerMonth,
        "arrCarFeatures": List<dynamic>.from(arrCarFeatures.map((x) => x.toJson())),
        "strCreatedBy": strCreatedBy,
        "strCreatedTime": strCreatedTime?.toIso8601String(),
      };
}

class ArrCarFeature {
  final String strFeatures;
  final String strDescription;

  ArrCarFeature({
    this.strFeatures = '',
    this.strDescription = '',
  });

  factory ArrCarFeature.fromJson(Map<String, dynamic> json) => ArrCarFeature(
        strFeatures: json["strFeatures"]?.toString() ?? '',
        strDescription: json["strDescription"]?.toString() ?? '',
      );

  Map<String, dynamic> toJson() => {
        "strFeatures": strFeatures,
        "strDescription": strDescription,
      };
}
