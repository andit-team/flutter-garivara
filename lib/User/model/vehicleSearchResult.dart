// To parse this JSON data, do
//
//     final getAllVehicleTypes = getAllVehicleTypesFromJson(jsonString);

import 'dart:convert';

import 'package:andgarivara/User/model/idModel.dart';

GetAllVehicleTypes getAllVehicleTypesFromJson(String str) => GetAllVehicleTypes.fromJson(json.decode(str));

String getAllVehicleTypesToJson(GetAllVehicleTypes data) => json.encode(data.toJson());

class GetAllVehicleTypes {
  GetAllVehicleTypes({
    this.data,
    this.error,
    this.msg,
  });

  List<SearchVehicleModel> data;
  bool error;
  dynamic msg;

  factory GetAllVehicleTypes.fromJson(Map<String, dynamic> json) => GetAllVehicleTypes(
    data: List<SearchVehicleModel>.from(json["data"].map((x) => SearchVehicleModel.fromJson(x))),
    error: json["error"],
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "error": error,
    "msg": msg,
  };
}

class SearchVehicleModel {
  SearchVehicleModel({
    this.id,
    this.brandTitle,
    this.carAddress,
    this.fuelTypeTitle,
    this.manufactureYear,
    this.millage,
    this.model,
    this.serviceDetails,
    this.thumbImage,
    this.vehicleTypeTitle,
  });

  IdModel id;
  String brandTitle;
  String carAddress;
  String fuelTypeTitle;
  String manufactureYear;
  String millage;
  String model;
  ServiceDetails serviceDetails;
  String thumbImage;
  String vehicleTypeTitle;

  factory SearchVehicleModel.fromJson(Map<String, dynamic> json) => SearchVehicleModel(
    id: IdModel.fromJson(json["_id"]),
    brandTitle: json["brandTitle"],
    carAddress: json["carAddress"],
    fuelTypeTitle: json["fuelTypeTitle"],
    manufactureYear: json["manufactureYear"],
    millage: json["millage"],
    model: json["model"],
    serviceDetails: ServiceDetails.fromJson(json["serviceDetails"]),
    thumbImage: json["thumbImage"],
    vehicleTypeTitle: json["vehicleTypeTitle"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id.toJson(),
    "brandTitle": brandTitle,
    "carAddress": carAddress,
    "fuelTypeTitle": fuelTypeTitle,
    "manufactureYear": manufactureYear,
    "millage": millage,
    "model": model,
    "serviceDetails": serviceDetails.toJson(),
    "thumbImage": thumbImage,
    "vehicleTypeTitle": vehicleTypeTitle,
  };
}

class ServiceDetails {
  ServiceDetails({
    this.perDayBodyRent,
  });

  String perDayBodyRent;

  factory ServiceDetails.fromJson(Map<String, dynamic> json) => ServiceDetails(
    perDayBodyRent: json["perDayBodyRent"],
  );

  Map<String, dynamic> toJson() => {
    "perDayBodyRent": perDayBodyRent,
  };
}
