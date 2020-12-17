import 'package:andgarivara/General/model/registerResponse.dart';
import 'package:andgarivara/General/model/registrationModel.dart';
import 'package:andgarivara/Utils/databaseConfig.dart';
import 'package:dio/dio.dart';

class RepoRegister{
  static registerUser(RegisterModel userData) async{
    try{
      Response response = await DBHelper.dio.post(
        DBHelper.api+DBHelper.createUser,
        data: userData.toJson()
      );

      RegisterResponse registerResponse = RegisterResponse.fromJson(response.data);

      return registerResponse;

    }catch(e){
      print(e.toString());
    }
  }
}