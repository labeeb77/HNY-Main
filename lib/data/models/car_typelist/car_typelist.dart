import 'dart:convert';

CarTypeList carTypeListFromJson(String str) => CarTypeList.fromJson(json.decode(str));

String carTypeListToJson(CarTypeList data) => json.encode(data.toJson());

class CarTypeList {
    bool? success;
    String? message;
    int? statusCode;
    List<ArrTypeList>? arrList;

    CarTypeList({
        this.success,
        this.message,
        this.statusCode,
        this.arrList,
    });

    factory CarTypeList.fromJson(Map<String, dynamic> json) => CarTypeList(
        success: json["success"],
        message: json["message"],
        statusCode: json["statusCode"],
        arrList: json["arrList"] == null ? [] : List<ArrTypeList>.from(json["arrList"]!.map((x) => ArrTypeList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "statusCode": statusCode,
        "arrList": arrList == null ? [] : List<dynamic>.from(arrList!.map((x) => x.toJson())),
    };
}

class ArrTypeList {
    String? id;
    String? strType;
    String? strName;

    ArrTypeList({
        this.id,
        this.strType,
        this.strName,
    });

    factory ArrTypeList.fromJson(Map<String, dynamic> json) => ArrTypeList(
        id: json["_id"],
        strType: json["strType"],
        strName: json["strName"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "strType": strType,
        "strName": strName,
    };
}
