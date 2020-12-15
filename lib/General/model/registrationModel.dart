import 'package:flutter/cupertino.dart';

class RegisterModel{
  String firstName;
  String lastName;
  String mobile;
  String email;
  String password;

  RegisterModel({
   @required this.firstName,
   @required this.lastName,
   @required this.mobile,
   @required this.password,
    this.email = ''
});

  Map<String, dynamic> toJson() => {
    "phone_no": mobile,
    "password": password,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
  };

}