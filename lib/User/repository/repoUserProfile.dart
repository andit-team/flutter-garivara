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
      print(res.data.displayUrl);
      return res.data.displayUrl;
    }catch(e){
      print(e.toString());
      return 'https://i.ibb.co/zSgXBQ2/6494ea428d77.jpg';
    }
  }


  static uploadImage(File image) async{
    String imgLink = await uploadToImageBB(image);

    try{
      Response response = await DBHelper.dio.put(
        DotEnv().env['API_URL']+DotEnv().env['uploadImage'],
        data: {"profile_pic": imgLink},
        queryParameters: {
          "Authorization" : "Bearer ${ViewModelUserData.userToken.value}"
        }
      );

      if(!response.data["error"]){
        ViewModelUserData.userData.value.profilePic = imgLink;
      }

      print(response.data);

      return response.data["error"];

    }catch(e){
      print(e.toString());
      return true;
    }
  }
}