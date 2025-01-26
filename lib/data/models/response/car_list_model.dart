class CarListModel {
  bool success;
  String message;
  int statusCode;
  List<ArrCar> arrCars;
  dynamic objUser;

  CarListModel({
    required this.success,
    required this.message,
    required this.statusCode,
    required this.arrCars,
    required this.objUser,
  });

  factory CarListModel.fromJson(Map<String, dynamic> json) {
    return CarListModel(
      success: json['success'],
      message: json['message'],
      statusCode: json['statusCode'],
      arrCars:
          (json['arrCars'] as List).map((car) => ArrCar.fromJson(car)).toList(),
      objUser: json['objUser'],
    );
  }
}

class ArrCar {
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
  List<String?> arrImgUrl;
  int? intPower;
  dynamic intFuelCapacity;
  dynamic intRating;
  String? strVarients;
  dynamic strYear;
  int? intPricePerDay;
  int? intPricePerWeek;
  int? intPricePerMonth;
  List<ArrCarFeature?> arrCarFeatures;
  String? strCreatedBy;
  DateTime strCreatedTime;

  ArrCar({
    required this.id,
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
   required  this.arrImgUrl,
    this.intPower,
    this.intFuelCapacity,
    this.intRating,
    this.strVarients,
    this.strYear,
    this.intPricePerDay,
    this.intPricePerWeek,
    this.intPricePerMonth,
   required this.arrCarFeatures,
    this.strCreatedBy,
   required  this.strCreatedTime,
  });

  factory ArrCar.fromJson(Map<String, dynamic> json) {
    return ArrCar(
      id: json['id'],
      strCarNumber: json['strCarNumber'],
      strBrand: json['strBrand'],
      strStatus: json['strStatus'],
      chrStatus: json['chrStatus'],
      strModel: json['strModel'],
      strDescription: json['strDescription'],
      strCarCategory: json['strCarCategory'],
      strSeatNo: json['strSeatNo'],
      strFuelType: json['strFuelType'],
      strImgUrl: json['strImgUrl'],
      arrImgUrl: List<String>.from(json['arrImgUrl']),
      intPower: json['intPower'],
      intFuelCapacity: json['intFuelCapacity'],
      intRating: json['intRating'],
      strVarients: json['strVarients'],
      strYear: json['strYear'],
      intPricePerDay: json['intPricePerDay'],
      intPricePerWeek: json['intPricePerWeek'],
      intPricePerMonth: json['intPricePerMonth'],
      arrCarFeatures: (json['arrCarFeatures'] as List)
          .map((feature) => ArrCarFeature.fromJson(feature))
          .toList(),
      strCreatedBy: json['strCreatedBy'],
      strCreatedTime: DateTime.parse(json['strCreatedTime']),
    );
  }
}

class ArrCarFeature {
  String strFeatures;
  String strDescription;

  ArrCarFeature({
    required this.strFeatures,
    required this.strDescription,
  });

  factory ArrCarFeature.fromJson(Map<String, dynamic> json) {
    return ArrCarFeature(
      strFeatures: json['strFeatures'],
      strDescription: json['strDescription'],
    );
  }
}
