class IdModel {
  IdModel({
    this.oid,
  });

  String oid;

  factory IdModel.fromJson(Map<String, dynamic> json) => IdModel(
    oid: json["\u0024oid"] ?? 'empty',
  );

  Map<String, dynamic> toJson() => {
    "\u0024oid": oid,
  };
}