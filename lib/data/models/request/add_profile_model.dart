// To parse this JSON data, do
//
//     final addProfileModel = addProfileModelFromJson(jsonString);

import 'dart:convert';

AddProfileModel addProfileModelFromJson(String str) => AddProfileModel.fromJson(json.decode(str));

String addProfileModelToJson(AddProfileModel data) => json.encode(data.toJson());

class AddProfileModel {
    String? strFirstName;
    String? strLastName;
    String? strEmail;
    String? strProfileUrl;
    String? strPassportUrl;
    String? strNationality;
    String? strLicenceUrl;
    String? strGccIdUrl;
    String? strEmiratesIdUrl;
    String? strFcmToken;
    String? strGender;
    String? strDateOfBirth;
    String? strCitizenType;
    

    AddProfileModel({
    
        this.strFirstName,
        this.strLastName,
        this.strEmail,
        this.strProfileUrl,
        this.strPassportUrl,
        this.strNationality,
        this.strLicenceUrl,
        this.strGccIdUrl,
        this.strEmiratesIdUrl,
        this.strFcmToken,
        this.strGender,
        this.strDateOfBirth,
        this.strCitizenType,
    });

    factory AddProfileModel.fromJson(Map<String, dynamic> json) => AddProfileModel(
  
        strFirstName: json["strFirstName"],
        strLastName: json["strLastName"],
        strEmail: json["strEmail"],
        strProfileUrl: json["strProfileUrl"],
        strPassportUrl: json["strPassportUrl"],
        strNationality: json["strNationality"],
        strLicenceUrl: json["strLicenceUrl"],
        strGccIdUrl: json["strGCCIdUrl"],
        strEmiratesIdUrl: json["strEmiratesIdUrl"],
        strFcmToken: json["strFcmToken"],
        strGender: json["strGender"],
        strDateOfBirth: json["strDateOfBirth"],
        strCitizenType: json["strCitizenType"],
    );

    Map<String, dynamic> toJson() => {
       
        "strFirstName": strFirstName,
        "strLastName": strLastName,
        "strEmail": strEmail,
        "strProfileUrl": strProfileUrl,
        "strPassportUrl": strPassportUrl,
        "strNationality": strNationality,
        "strLicenceUrl": strLicenceUrl,
        "strGCCIdUrl": strGccIdUrl,
        "strEmiratesIdUrl": strEmiratesIdUrl,
        "strFcmToken": strFcmToken,
        "strGender": strGender,
        "strDateOfBirth": strDateOfBirth,
        "strCitizenType": strCitizenType,
    };
}
