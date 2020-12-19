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

  List<VehicleModel> data;
  bool error;
  dynamic msg;

  factory GetAllVehicleTypes.fromJson(Map<String, dynamic> json) => GetAllVehicleTypes(
    data: List<VehicleModel>.from(json["data"].map((x) => VehicleModel.fromJson(x))),
    error: json["error"],
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "error": error,
    "msg": msg,
  };
}

class VehicleModel {
  VehicleModel({
    this.id,
    this.amenities,
    this.brandTitle,
    this.carAddress,
    this.carLocation,
    this.fuelTypeTitle,
    this.manufactureYear,
    this.millage,
    this.model,
    this.serviceDetails,
    this.thumbImage,
    this.vehicleTypeTitle,
  });

  IdModel id;
  Amenities amenities;
  String brandTitle;
  String carAddress;
  CarLocation carLocation;
  String fuelTypeTitle;
  String manufactureYear;
  String millage;
  String model;
  ServiceDetails serviceDetails;
  String thumbImage;
  String vehicleTypeTitle;

  factory VehicleModel.fromJson(Map<String, dynamic> json) => VehicleModel(
    id: IdModel.fromJson(json["_id"]),
    amenities: Amenities.fromJson(json["amenities"]),
    brandTitle: json["brandTitle"],
    carAddress: json["carAddress"],
    carLocation: CarLocation.fromJson(json["carLocation"]),
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
    "amenities": amenities.toJson(),
    "brandTitle": brandTitle,
    "carAddress": carAddress,
    "carLocation": carLocation.toJson(),
    "fuelTypeTitle": fuelTypeTitle,
    "manufactureYear": manufactureYear,
    "millage": millage,
    "model": model,
    "serviceDetails": serviceDetails.toJson(),
    "thumbImage": thumbImage,
    "vehicleTypeTitle": vehicleTypeTitle,
  };
}

class Amenities {
  Amenities({
    this.ac,
  });

  bool ac;

  factory Amenities.fromJson(Map<String, dynamic> json) => Amenities(
    ac: json["ac"],
  );

  Map<String, dynamic> toJson() => {
    "ac": ac,
  };
}

class CarLocation {
  CarLocation({
    this.coordinates,
    this.type,
  });

  List<double> coordinates;
  String type;

  factory CarLocation.fromJson(Map<String, dynamic> json) => CarLocation(
    coordinates: List<double>.from(json["coordinates"].map((x) => x.toDouble())),
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
    "type": type,
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
