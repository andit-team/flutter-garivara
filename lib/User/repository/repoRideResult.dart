import 'package:andgarivara/User/model/vehicleDetails.dart';
import 'package:andgarivara/User/model/vehicleSearchResult.dart';
import 'package:andgarivara/User/view/homeScreen/homeScreen.dart';
import 'package:andgarivara/User/viewModel/viewModelRideResutl.dart';
import 'package:andgarivara/Utils/databaseConfig.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RepoRideResult{
  static getRideResult(String serviceType, String vehicleType, LatLng pickUp) async{
    ViewModelRideResult.rideResults.clear();
    try{
      Response response = await DBHelper.dio.post(
        DotEnv().env['API_URL']+DotEnv().env['searchVehicle'],
        data: {
          "service" : serviceType,
          "vehicleType": vehicleType,
          "long" : pickUp.longitude,
          "lat" : pickUp.latitude
        },
      );

      response.data['data'].forEach((element){
        ViewModelRideResult.rideResults.add(SearchVehicleModel.fromJson(element));
      });
    }catch(e){
      print(e.toString());
    }
  }

  static getVehicleInfo(String vehicleId) async{
    try{
      Response response = await DBHelper.dio.get(
          DotEnv().env['API_URL']+DotEnv().env['vehicleInfo']+'/$vehicleId',
      );

      if(response.data['error']){
        return true;
      }else{
        GetVehicleInfo data = GetVehicleInfo.fromJson(response.data);
        ViewModelRideResult.vehicleData.value = data.data[0];
        return false;
      }

    }catch(e){
      print(e.toString());
      return true;
    }
  }

  static getQuote(String vehicleId, String journeyDate, String pickupTime, String time, String durationType, String fuelType) async{
    try{
      // double fuelCost = ViewModelRideResult.vehicleData.value.fuelTypeDetails[0].rate * (distance/1000);

      double fuelPrice = double.parse(ViewModelRideResult.vehicleData.value.fuelTypeDetails[0].rate);
      double gap = distance/1000;
      double fuelCost = fuelPrice * gap;

      Map<String, dynamic> data = {
        "pickupDate": journeyDate,
        "pickupTime": pickupTime,
        "journeyDuration": time,
        "journeyDurationUnit": durationType,
        "fuelPackage": fuelType.toLowerCase(),
        "perDayRent": ViewModelRideResult.vehicleData.value.serviceDetails.perDayBodyRent,
        "perHourRentIncludeFuel": ViewModelRideResult.vehicleData.value.serviceDetails.perHourRentWithFuel,
        "perHourRentExcludedFuel": ViewModelRideResult.vehicleData.value.serviceDetails.perHourRentWithoutFuel,
        "fuelTypeTitle": ViewModelRideResult.vehicleData.value.fuelTypeTitle,
        "fuelCost": fuelCost,
        "fuelCostUpDown": fuelCost * 2,
        "voucher": 0,
        "voucherType": "",
        "totalFare": 7600,
        "grandTotalFare" : 6840,
        "paymentType": "cash",
        "totalDistance": 100,
        "from": {
          "type": "Point",
          "coordinates": ["longitude", "latitude"]
        },
        "to": {
          "type": "Point",
          "coordinates": ["longitude", "latitude"]
        },
        "driverId": "foreign objectId",
        "bookingDate": "date"
      };
      print(data);
      // Response response = await DBHelper.dio.get(
      //   DotEnv().env['API_URL']+DotEnv().env['rentCarReq']+'/$vehicleId',
      //   queryParameters: data
      // );
      //
      // if(response.data['error']){
      //   return true;
      // }else{
      //   GetVehicleInfo data = GetVehicleInfo.fromJson(response.data);
      //   ViewModelRideResult.vehicleData.value = data.data[0];
      //   return false;
      // }

    }catch(e){
      print(e.toString());
      return true;
    }
  }
}