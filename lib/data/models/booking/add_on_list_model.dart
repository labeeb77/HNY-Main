import 'dart:convert';

GetAddOnListModel getAddOnListModelFromJson(String str) => GetAddOnListModel.fromJson(json.decode(str));

String getAddOnListModelToJson(GetAddOnListModel data) => json.encode(data.toJson());

class GetAddOnListModel {
    bool? success;
    String? message;
    int? statusCode;
    List<AddOnArrList>? arrList;
    Pagination? pagination;

    GetAddOnListModel({
        this.success,
        this.message,
        this.statusCode,
        this.arrList,
        this.pagination,
    });

    factory GetAddOnListModel.fromJson(Map<String, dynamic> json) => GetAddOnListModel(
        success: json["success"],
        message: json["message"],
        statusCode: json["statusCode"],
        arrList: json["arrList"] == null ? [] : List<AddOnArrList>.from(json["arrList"]!.map((x) => AddOnArrList.fromJson(x))),
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

class AddOnArrList {
    String? id;
    String? chrStatus;
    String? strCreatedBy;
    String? strName;
    String? strDescription;
    dynamic strImgUrl;
    int? intTotalQty;
    int? intAvlQty;
    int? intPricePerDay;
    int? intPricePerWeek;
    int? intPricePerMonth;
    String? strImageUrl;
    DateTime? strCreatedTime;

    AddOnArrList({
        this.id,
        this.chrStatus,
        this.strCreatedBy,
        this.strName,
        this.strDescription,
        this.strImgUrl,
        this.intTotalQty,
        this.intAvlQty,
        this.intPricePerDay,
        this.intPricePerWeek,
        this.intPricePerMonth,
        this.strImageUrl,
        this.strCreatedTime,
    });

    factory AddOnArrList.fromJson(Map<String, dynamic> json) => AddOnArrList(
        id: json["_id"],
        chrStatus: json["chrStatus"],
        strCreatedBy: json["strCreatedBy"],
        strName: json["strName"],
        strDescription: json["strDescription"],
        strImgUrl: json["strImgUrl"],
        intTotalQty: json["intTotalQty"],
        intAvlQty: json["intAvlQty"],
        intPricePerDay: json["intPricePerDay"],
        intPricePerWeek: json["intPricePerWeek"],
        intPricePerMonth: json["intPricePerMonth"],
        strImageUrl: json["strImageUrl"],
        strCreatedTime: json["strCreatedTime"] == null ? null : DateTime.parse(json["strCreatedTime"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "chrStatus": chrStatus,
        "strCreatedBy": strCreatedBy,
        "strName": strName,
        "strDescription": strDescription,
        "strImgUrl": strImgUrl,
        "intTotalQty": intTotalQty,
        "intAvlQty": intAvlQty,
        "intPricePerDay": intPricePerDay,
        "intPricePerWeek": intPricePerWeek,
        "intPricePerMonth": intPricePerMonth,
        "strImageUrl": strImageUrl,
        "strCreatedTime": strCreatedTime?.toIso8601String(),
    };
}

class Pagination {
    int? page;
    int? count;

    Pagination({
        this.page,
        this.count,
    });

    factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        page: json["page"],
        count: json["count"],
    );

    Map<String, dynamic> toJson() => {
        "page": page,
        "count": count,
    };
}
