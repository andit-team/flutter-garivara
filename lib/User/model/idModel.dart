class IdModel {
  IdModel({
    this.oid,
  });

  String oid;

  factory IdModel.fromJson(Map<String, dynamic> json) => IdModel(
    oid: json["\u0024oid"],
  );

  Map<String, dynamic> toJson() => {
    "\u0024oid": oid,
  };
}