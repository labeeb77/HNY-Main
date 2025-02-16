import 'dart:convert';

FavouritesModel favouritesModelFromJson(String str) =>
    FavouritesModel.fromJson(json.decode(str));

String favouritesModelToJson(FavouritesModel data) =>
    json.encode(data.toJson());

class FavouritesModel {
  bool? success;
  String? message;
  int? statusCode;
  List<FavArrList>? arrList;

  FavouritesModel({
    this.success,
    this.message,
    this.statusCode,
    this.arrList,
  });

  factory FavouritesModel.fromJson(Map<String, dynamic> json) =>
      FavouritesModel(
        success: json["success"],
        message: json["message"],
        statusCode: json["statusCode"],
        arrList: json["arrList"] == null
            ? []
            : List<FavArrList>.from(
                json["arrList"]!.map((x) => FavArrList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "statusCode": statusCode,
        "arrList": arrList == null
            ? []
            : List<dynamic>.from(arrList!.map((x) => x.toJson())),
      };
}

class FavArrList {
  String? id;
  String? chrStatus;
  String? strCreatedBy;
  String? strCarId;
  DateTime? strCreatedTime;
  CarData? carData;

  FavArrList({
    this.id,
    this.chrStatus,
    this.strCreatedBy,
    this.strCarId,
    this.strCreatedTime,
    this.carData,
  });

  factory FavArrList.fromJson(Map<String, dynamic> json) => FavArrList(
        id: json["_id"],
        chrStatus: json["chrStatus"],
        strCreatedBy: json["strCreatedBy"],
        strCarId: json["strCarId"],
        strCreatedTime: json["strCreatedTime"] == null
            ? null
            : DateTime.parse(json["strCreatedTime"]),
        carData:
            json["carData"] == null ? null : CarData.fromJson(json["carData"]),
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
  String? id;
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

  CarData({
    this.id,
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
  });

  factory CarData.fromJson(Map<String, dynamic> json) => CarData(
        id: json["_id"],
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
        arrImgUrl: json["arrImgUrl"] == null
            ? []
            : List<String>.from(json["arrImgUrl"]!.map((x) => x)),
        intPower: json["intPower"],
        intFuelCapacity: json["intFuelCapacity"],
        intRating: json["intRating"],
        strVarients: json["strVarients"],
        strYear: json["strYear"],
        intPricePerDay: json["intPricePerDay"],
        intPricePerWeek: json["intPricePerWeek"],
        intPricePerMonth: json["intPricePerMonth"],
        arrCarFeatures: json["arrCarFeatures"] == null
            ? []
            : List<ArrCarFeature>.from(
                json["arrCarFeatures"]!.map((x) => ArrCarFeature.fromJson(x))),
        strCreatedBy: json["strCreatedBy"],
        strCreatedTime: json["strCreatedTime"] == null
            ? null
            : DateTime.parse(json["strCreatedTime"]),
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
        "arrImgUrl": arrImgUrl == null
            ? []
            : List<dynamic>.from(arrImgUrl!.map((x) => x)),
        "intPower": intPower,
        "intFuelCapacity": intFuelCapacity,
        "intRating": intRating,
        "strVarients": strVarients,
        "strYear": strYear,
        "intPricePerDay": intPricePerDay,
        "intPricePerWeek": intPricePerWeek,
        "intPricePerMonth": intPricePerMonth,
        "arrCarFeatures": arrCarFeatures == null
            ? []
            : List<dynamic>.from(arrCarFeatures!.map((x) => x.toJson())),
        "strCreatedBy": strCreatedBy,
        "strCreatedTime": strCreatedTime?.toIso8601String(),
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
