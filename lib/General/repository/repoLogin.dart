import 'package:andgarivara/General/model/loginResponse.dart';
import 'package:andgarivara/User/viewModel/userData.dart';
import 'package:andgarivara/Utils/databaseConfig.dart';
import 'package:dio/dio.dart';

class RepoLogin{
  static login(String phone, String password) async{
    try{
      Response response = await DBHelper.dio.post(
          DBHelper.api+DBHelper.loginUser,
          data: {
            "phone_no": phone,
            "password": password
          }

      );

      //TODO login response model needs work later
      LoginResponseModel loginResponse = LoginResponseModel.fromJson(response.data);

      if(!loginResponse.error){
        ViewModelUserData.userData.value = loginResponse.data;
        ViewModelUserData.userToken.value = loginResponse.token;
      }

      return response.data['error'];

    }catch(e){
      print(e.toString());
    }
  }
}