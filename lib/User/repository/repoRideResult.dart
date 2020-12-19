import 'package:andgarivara/User/model/vehicleSearchResult.dart';
import 'package:andgarivara/User/viewModel/viewModelRideResutl.dart';
import 'package:andgarivara/Utils/databaseConfig.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RepoRideResult{
  static getRideResult(String serviceType, String vehicleType, LatLng pickUp) async{
    try{
      Response response = await DBHelper.dio.post(
        DotEnv().env['API_URL']+DotEnv().env['searchVehicle'],
        data: {
          "service" : serviceType,
          "vehicleType": vehicleType,
          "long" : pickUp.longitude,
          "lat" : pickUp.latitude
        }
      );

      response.data['data'].forEach((element){
        ViewModelRideResult.rideResults.add(VehicleModel.fromJson(element));
      });

      // return response.data["error"];

    }catch(e){
      print(e.toString());
    }
  }
}