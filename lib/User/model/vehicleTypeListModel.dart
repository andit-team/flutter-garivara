import 'idModel.dart';

class VehicleTypeModel {
  VehicleTypeModel({
    this.id,
    this.title,
    this.icon,
  });

  IdModel id;
  String title;
  String icon;

  factory VehicleTypeModel.fromJson(Map<String, dynamic> json) => VehicleTypeModel(
    id: IdModel.fromJson(json["_id"]),
    title: json["title"],
    icon: json["typeIcon"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id.toJson(),
    "title": title,
    "typeIcon": icon,
  };
}
