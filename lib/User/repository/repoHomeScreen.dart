import 'package:andgarivara/User/model/vehicleTypeListModel.dart';
import 'package:andgarivara/User/viewModel/viewModelViewScreen.dart';
import 'package:andgarivara/Utils/databaseConfig.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class RepoHomeScreen{
  static getVehicleTypes() async{
    try{
      Response response = await DBHelper.dio.get(
        DotEnv().env['API_URL']+DotEnv().env['getVehicleType'],
      );

      ViewModelHomeScreen.vehicleTypes.clear();
      response.data['data'].forEach((element) {
        ViewModelHomeScreen.vehicleTypes.add(VehicleTypeModel.fromJson(element));
      });

    }catch(e){
      print(e.toString());
    }
  }
}