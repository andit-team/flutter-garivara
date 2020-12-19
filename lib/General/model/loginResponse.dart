

import 'package:andgarivara_driver/User/model/userModel.dart';

class LoginResponseModel {
  LoginResponseModel({
    this.data,
    this.error,
    this.msg,
    this.token,
  });

  UserModel data;
  bool error;
  String msg;
  String token;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
    data: json["data"] == null ? UserModel() : UserModel.fromJson(json["data"]),
    error: json["error"],
    msg: json["msg"],
    token: json["token"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "error": error,
    "msg": msg,
    "token": token,
  };
}