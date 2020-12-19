import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:andgarivara/User/model/imgbbResponseModel.dart';
import 'package:andgarivara/User/viewModel/userData.dart';
import 'package:andgarivara/Utils/databaseConfig.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart' as service;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class RepoUserProfile{

  static uploadToImageBB(File _image) async{
    try{
      ByteData bytes = await service.rootBundle.load(_image.absolute.path);
      var buffer = bytes.buffer;
      var imgData = base64.encode(Uint8List.view(buffer));

      FormData formData = FormData.fromMap({
        "key" : DotEnv().env['IMGBB'],
        "image" :imgData
      });

      Response response = await DBHelper.dio.post(
        "https://api.imgbb.com/1/upload",
        data: formData,
      );
      ImgbbResponseModel res = ImgbbResponseModel.fromJson(response.data);
      return res.data.displayUrl;
    }catch(e){
      print(e.toString());
      return 'https://i.ibb.co/zSgXBQ2/6494ea428d77.jpg';
    }
  }

  static uploadImage(File image) async{
    String imgLink = await uploadToImageBB(image);

    try{
      DBHelper.dio.options.headers["Authorization"] = "Bearer ${ViewModelUserData.userToken.value}";
      Response response = await DBHelper.dio.put(
        DotEnv().env['API_URL']+DotEnv().env['uploadImage'],
        data: {"profile_pic": imgLink}
      );

      if(!response.data["error"]){
        ViewModelUserData.userData.value.profilePic = imgLink;
      }

      return response.data["error"];

    }catch(e){
      print(e.toString());
      return true;
    }
  }

  static updateProfile(String fName, String lName, String email) async{
    try{
      DBHelper.dio.options.headers["Authorization"] = "Bearer ${ViewModelUserData.userToken.value}";
      Response response = await DBHelper.dio.put(
          DotEnv().env['API_URL']+DotEnv().env['updateProfile'],
          data: {
            "phone_no": ViewModelUserData.userData.value.phoneNo,
            "first_name": fName,
            "last_name": lName,
            "email": email,
            "country": ViewModelUserData.userData.value.country,
            "address": ViewModelUserData.userData.value.address,
            "default_contact_number": ViewModelUserData.userData.value.defaultContactNumber,
            "profile_pic": ViewModelUserData.userData.value.profilePic,
            "push_on_message_send": ViewModelUserData.userData.value.pushNotification.onMessageSend,
            "push_on_booking": ViewModelUserData.userData.value.pushNotification.onBooking,
            "push_on_suppport_reply": ViewModelUserData.userData.value.pushNotification.onSuppportReply,
            "sms_on_message_send": ViewModelUserData.userData.value.smsNotification.onMessageSend,
            "sms_on_booking": ViewModelUserData.userData.value.smsNotification.onBooking,
            "sms_on_suppport_reply": ViewModelUserData.userData.value.smsNotification.onSuppportReply
          }

      );

      if(!response.data["error"]){
        ViewModelUserData.userData.value.firstName = fName;
        ViewModelUserData.userData.value.lastName = lName;
        ViewModelUserData.userData.value.email = email;
      }

      return response.data["error"];

    }catch(e){
      print(e.toString());
      return true;
    }
  }

  static changePassword(String oldPass, String newPass) async{
    try{
      DBHelper.dio.options.headers["Authorization"] = "Bearer ${ViewModelUserData.userToken.value}";
      Response response = await DBHelper.dio.put(
          DotEnv().env['API_URL']+DotEnv().env['changePassword'],
          data: {
            "oldPassword": oldPass,
            "newPassword": newPass
          }
      );

      return response.data["error"];

    }catch(e){
      print(e.toString());
      return true;
    }
  }
}