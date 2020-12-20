// To parse this JSON data, do
//
//     final getVehicleInfo = getVehicleInfoFromJson(jsonString);

import 'dart:convert';

import 'package:andgarivara/User/model/idModel.dart';

GetVehicleInfo getVehicleInfoFromJson(String str) => GetVehicleInfo.fromJson(json.decode(str));

class GetVehicleInfo {
  GetVehicleInfo({
    this.data,
    this.error,
    this.msg,
  });

  List<VehicleInfo> data;
  bool error;
  String msg;

  factory GetVehicleInfo.fromJson(Map<String, dynamic> json) => GetVehicleInfo(
    data: List<VehicleInfo>.from(json["data"].map((x) => VehicleInfo.fromJson(x))),
    error: json["error"],
    msg: json["msg"],
  );
}

class VehicleInfo {
  VehicleInfo({
    this.id,
    this.activeService,
    this.activeStatus,
    this.amenities,
    this.brand,
    this.brandTitle,
    this.capacity,
    this.carAddress,
    this.carLocation,
    this.chassisNumber,
    this.color,
    this.coverImage,
    this.defaultContactNumber,
    this.delStatus,
    this.description,
    this.district,
    this.districtTitle,
    this.division,
    this.divisionTitle,
    this.driver,
    this.driverDetails,
    this.engineNumber,
    this.fuelType,
    this.fuelTypeTitle,
    this.fuelTypeDetails,
    this.gearType,
    this.insuranceCompany,
    this.insuranceExpiry,
    this.insuranceName,
    this.isMunicipal,
    this.licenceVelidation,
    this.manufactureYear,
    this.millage,
    this.model,
    this.municipal,
    this.municipalTitle,
    this.policyNumber,
    this.policyType,
    this.refType,
    this.regNumber,
    this.service,
    this.serviceDetails,
    this.thumbImage,
    this.tiresNumber,
    this.union,
    this.unionTitle,
    this.upazila,
    this.upazilaTitle,
    this.userId,
    this.vehicleCc,
    this.vehicleLength,
    this.vehicleNumber,
    this.vehicleTitle,
    this.vehicleType,
    this.vehicleTypeDetails,
    this.vehicleTypeTitle,
    this.vehicleImgs,
    this.video,
    this.village,
    this.villageTitle,
    this.ward,
    this.wardTitle,
  });

  IdModel id;
  String activeService;
  String activeStatus;
  VehicleAmenities amenities;
  IdModel brand;
  String brandTitle;
  String capacity;
  String carAddress;
  CarLocation carLocation;
  String chassisNumber;
  String color;
  String coverImage;
  String defaultContactNumber;
  bool delStatus;
  String description;
  String district;
  String districtTitle;
  String division;
  String divisionTitle;
  IdModel driver;
  List<DriverDetail> driverDetails;
  String engineNumber;
  IdModel fuelType;
  String fuelTypeTitle;
  List<FuelTypeDetail> fuelTypeDetails;
  String gearType;
  String insuranceCompany;
  String insuranceExpiry;
  String insuranceName;
  bool isMunicipal;
  String licenceVelidation;
  String manufactureYear;
  String millage;
  String model;
  dynamic municipal;
  String municipalTitle;
  String policyNumber;
  String policyType;
  String refType;
  String regNumber;
  List<String> service;
  ServiceDetails serviceDetails;
  String thumbImage;
  String tiresNumber;
  String union;
  String unionTitle;
  String upazila;
  String upazilaTitle;
  IdModel userId;
  String vehicleCc;
  String vehicleLength;
  String vehicleNumber;
  String vehicleTitle;
  IdModel vehicleType;
  VehicleTypeDetails vehicleTypeDetails;
  String vehicleTypeTitle;
  List<String> vehicleImgs;
  String video;
  String village;
  String villageTitle;
  dynamic ward;
  String wardTitle;

  factory VehicleInfo.fromJson(Map<String, dynamic> json) => VehicleInfo(
    id: IdModel.fromJson(json["_id"]),
    activeService: json["activeService"],
    activeStatus: json["activeStatus"],
    amenities: VehicleAmenities.fromJson(json["amenities"]),
    brand: IdModel.fromJson(json["brand"]),
    brandTitle: json["brandTitle"],
    capacity: json["capacity"],
    carAddress: json["carAddress"],
    carLocation: CarLocation.fromJson(json["carLocation"]),
    chassisNumber: json["chassisNumber"],
    color: json["color"],
    coverImage: json["coverImage"],
    defaultContactNumber: json["default_contact_number"],
    delStatus: json["del_status"],
    description: json["description"],
    district: json["district"],
    districtTitle: json["districtTitle"],
    division: json["division"],
    divisionTitle: json["divisionTitle"],
    driver: IdModel.fromJson(json["driver"]),
    driverDetails: List<DriverDetail>.from(json["driverDetails"].map((x) => DriverDetail.fromJson(x))),
    engineNumber: json["engineNumber"],
    fuelType: IdModel.fromJson(json["fuelType"]),
    fuelTypeTitle: json["fuelTypeTitle"],
    fuelTypeDetails: List<FuelTypeDetail>.from(json["fuel_type_details"].map((x) => FuelTypeDetail.fromJson(x))),
    gearType: json["gearType"],
    insuranceCompany: json["insuranceCompany"],
    insuranceExpiry: json["insuranceExpiry"],
    insuranceName: json["insuranceName"],
    isMunicipal: json["isMunicipal"],
    licenceVelidation: json["licenceVelidation"],
    manufactureYear: json["manufactureYear"],
    millage: json["millage"],
    model: json["model"],
    municipal: json["municipal"],
    municipalTitle: json["municipalTitle"],
    policyNumber: json["policyNumber"],
    policyType: json["policyType"],
    refType: json["refType"],
    regNumber: json["regNumber"],
    // service: List<String>.from(json["service"].map((x) => x)),
    serviceDetails: ServiceDetails.fromJson(json["serviceDetails"]),
    thumbImage: json["thumbImage"],
    tiresNumber: json["tiresNumber"],
    union: json["union"],
    unionTitle: json["unionTitle"],
    upazila: json["upazila"],
    upazilaTitle: json["upazilaTitle"],
    userId: IdModel.fromJson(json["userId"]),
    vehicleCc: json["vehicleCC"],
    vehicleLength: json["vehicleLength"],
    vehicleNumber: json["vehicleNumber"],
    vehicleTitle: json["vehicleTitle"],
    vehicleType: IdModel.fromJson(json["vehicleType"]),
    vehicleTypeDetails: VehicleTypeDetails.fromJson(json["vehicleTypeDetails"]),
    vehicleTypeTitle: json["vehicleTypeTitle"],
    vehicleImgs: List<String>.from(json["vehicle_imgs"].map((x) => x)),
    video: json["video"],
    village: json["village"],
    villageTitle: json["villageTitle"],
    ward: json["ward"],
    wardTitle: json["wardTitle"],
  );
}

class VehicleAmenities {
  VehicleAmenities({
    this.ac,
    this.airBags,
    this.alloyRims,
    this.cdPlayer,
    this.fmRadio,
    this.navigationSystem,
    this.powerLocks,
    this.powerMirrors,
  });

  bool ac;
  bool airBags;
  bool alloyRims;
  bool cdPlayer;
  bool fmRadio;
  bool navigationSystem;
  bool powerLocks;
  bool powerMirrors;

  factory VehicleAmenities.fromJson(Map<String, dynamic> json) => VehicleAmenities(
    ac: json["ac"],
    airBags: json["air_bags"],
    alloyRims: json["alloy_rims"],
    cdPlayer: json["cd_player"],
    fmRadio: json["fm_radio"],
    navigationSystem: json["navigation_system"],
    powerLocks: json["power_locks"],
    powerMirrors: json["power_mirrors"],
  );

  Map<String, dynamic> toJson() => {
    "ac": ac,
    "air_bags": airBags,
    "alloy_rims": alloyRims,
    "cd_player": cdPlayer,
    "fm_radio": fmRadio,
    "navigation_system": navigationSystem,
    "power_locks": powerLocks,
    "power_mirrors": powerMirrors,
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

class DriverDetail {
  DriverDetail({
    this.address,
    this.dob,
    this.drivingLicence,
    this.drivingLicenceExpiry,
    this.drivingLicenceImg,
    this.drivingLicenceType,
    this.image,
    this.name,
    this.nid,
    this.phoneNo,
    this.refType,
  });

  String address;
  DateTime dob;
  String drivingLicence;
  DateTime drivingLicenceExpiry;
  String drivingLicenceImg;
  String drivingLicenceType;
  String image;
  String name;
  String nid;
  String phoneNo;
  String refType;

  factory DriverDetail.fromJson(Map<String, dynamic> json) => DriverDetail(
    address: json["address"],
    dob: DateTime.parse(json["dob"]),
    drivingLicence: json["drivingLicence"],
    drivingLicenceExpiry: DateTime.parse(json["drivingLicenceExpiry"]),
    drivingLicenceImg: json["drivingLicenceImg"],
    drivingLicenceType: json["drivingLicenceType"],
    image: json["image"],
    name: json["name"],
    nid: json["nid"],
    phoneNo: json["phone_no"],
    refType: json["refType"],
  );

  Map<String, dynamic> toJson() => {
    "address": address,
    "dob": "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
    "drivingLicence": drivingLicence,
    "drivingLicenceExpiry": "${drivingLicenceExpiry.year.toString().padLeft(4, '0')}-${drivingLicenceExpiry.month.toString().padLeft(2, '0')}-${drivingLicenceExpiry.day.toString().padLeft(2, '0')}",
    "drivingLicenceImg": drivingLicenceImg,
    "drivingLicenceType": drivingLicenceType,
    "image": image,
    "name": name,
    "nid": nid,
    "phone_no": phoneNo,
    "refType": refType,
  };
}

class FuelTypeDetail {
  FuelTypeDetail({
    this.id,
    this.rate,
    this.title,
  });

  IdModel id;
  dynamic rate;
  String title;

  factory FuelTypeDetail.fromJson(Map<String, dynamic> json) => FuelTypeDetail(
    id: IdModel.fromJson(json["_id"]),
    rate: json["rate"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id.toJson(),
    "rate": rate,
    "title": title,
  };
}

class ServiceDetails {
  ServiceDetails({
    this.faq,
    this.perDayBodyRent,
    this.perDayBodyRentNightStay,
    this.perHourRentWithFuel,
    this.perHourRentWithoutFuel,
    this.service,
  });

  List<VehicleFaq> faq;
  String perDayBodyRent;
  String perDayBodyRentNightStay;
  String perHourRentWithFuel;
  String perHourRentWithoutFuel;
  String service;

  factory ServiceDetails.fromJson(Map<String, dynamic> json) => ServiceDetails(
    faq: List<VehicleFaq>.from(json["faq"].map((x) => VehicleFaq.fromJson(x))),
    perDayBodyRent: json["perDayBodyRent"],
    perDayBodyRentNightStay: json["perDayBodyRentNightStay"],
    perHourRentWithFuel: json["perHourRentWithFuel"],
    perHourRentWithoutFuel: json["perHourRentWithoutFuel"],
    service: json["service"],
  );

  Map<String, dynamic> toJson() => {
    "faq": List<dynamic>.from(faq.map((x) => x.toJson())),
    "perDayBodyRent": perDayBodyRent,
    "perDayBodyRentNightStay": perDayBodyRentNightStay,
    "perHourRentWithFuel": perHourRentWithFuel,
    "perHourRentWithoutFuel": perHourRentWithoutFuel,
    "service": service,
  };
}

class VehicleFaq {
  VehicleFaq({
    this.answer,
    this.question,
  });

  String answer;
  String question;

  factory VehicleFaq.fromJson(Map<String, dynamic> json) => VehicleFaq(
    answer: json["answer"],
    question: json["question"],
  );

  Map<String, dynamic> toJson() => {
    "answer": answer,
    "question": question,
  };
}

class VehicleTypeDetails {
  VehicleTypeDetails({
    this.brands,
    this.title,
  });

  List<Brand> brands;
  String title;

  factory VehicleTypeDetails.fromJson(Map<String, dynamic> json) => VehicleTypeDetails(
    brands: List<Brand>.from(json["brands"].map((x) => Brand.fromJson(x))),
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "brands": List<dynamic>.from(brands.map((x) => x.toJson())),
    "title": title,
  };
}

class Brand {
  Brand({
    this.id,
    this.brand,
  });

  IdModel id;
  String brand;

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
    id: IdModel.fromJson(json["_id"]),
    brand: json["brand"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id.toJson(),
    "brand": brand,
  };
}
