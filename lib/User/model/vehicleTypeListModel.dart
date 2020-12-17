// To parse this JSON data, do
//
//     final getAllVehicleType = getAllVehicleTypeFromJson(jsonString);

import 'dart:convert';

GetAllVehicleType getAllVehicleTypeFromJson(String str) => GetAllVehicleType.fromJson(json.decode(str));

String getAllVehicleTypeToJson(GetAllVehicleType data) => json.encode(data.toJson());

class GetAllVehicleType {
  GetAllVehicleType({
    this.data,
    this.error,
    this.msg,
  });

  List<Datum> data;
  bool error;
  String msg;

  factory GetAllVehicleType.fromJson(Map<String, dynamic> json) => GetAllVehicleType(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    error: json["error"],
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "error": error,
    "msg": msg,
  };
}

class Datum {
  Datum({
    this.id,
    this.title,
    this.icon,
  });

  Id id;
  String title;
  String icon;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: Id.fromJson(json["_id"]),
    title: json["title"],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id.toJson(),
    "title": title,
    "icon": icon,
  };
}

class Id {
  Id({
    this.oid,
  });

  String oid;

  factory Id.fromJson(Map<String, dynamic> json) => Id(
    oid: json["\u0024oid"],
  );

  Map<String, dynamic> toJson() => {
    "\u0024oid": oid,
  };
}
