// To parse this JSON data, do
//
//     final registerResponse = registerResponseFromJson(jsonString);

import 'dart:convert';

RegisterResponse registerResponseFromJson(String str) => RegisterResponse.fromJson(json.decode(str));

String registerResponseToJson(RegisterResponse data) => json.encode(data.toJson());

class RegisterResponse {
  RegisterResponse({
    this.error,
    this.msg,
  });

  bool error;
  String msg;

  factory RegisterResponse.fromJson(Map<String, dynamic> json) => RegisterResponse(
    error: json["error"],
    msg: json['error'] ? 'Failed to register' : json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "msg": msg,
  };
}
