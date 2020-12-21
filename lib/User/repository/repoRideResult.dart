import 'package:andgarivara/User/model/vehicleDetails.dart';
import 'package:andgarivara/User/model/vehicleSearchResult.dart';
import 'package:andgarivara/User/view/homeScreen/homeScreen.dart';
import 'package:andgarivara/User/viewModel/userData.dart';
import 'package:andgarivara/User/viewModel/viewModelRideResutl.dart';
import 'package:andgarivara/Utils/databaseConfig.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

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

  static createModel(String vehicleId, String journeyDate, String pickupTime, int time, String durationType, String fuelType){
    double gap = distance/1000;
    double fuelRate = ViewModelRideResult.vehicleData.value.fuelTypeDetails[0].rate;
    double mileage = double.parse(ViewModelRideResult.vehicleData.value.millage);
    double perDayBodyRent = double.parse(ViewModelRideResult.vehicleData.value.serviceDetails.perDayBodyRent);
    double perDayBodyRentNight = double.parse(ViewModelRideResult.vehicleData.value.serviceDetails.perDayBodyRentNightStay);
    double perHourFuelIncluded = double.parse(ViewModelRideResult.vehicleData.value.serviceDetails.perHourRentWithFuel);
    double perHourFuelExcluded = double.parse(ViewModelRideResult.vehicleData.value.serviceDetails.perHourRentWithoutFuel);

    double fuelCost = fuelRate / mileage;
    double totalFare;
    if(durationType == 'days' && fuelType.toLowerCase() =='included'){
      totalFare = calculateIncludedDays(perDayBodyRent,perDayBodyRentNight,time,gap,fuelCost*2);
    }else if(durationType == 'days' && fuelType.toLowerCase() =='excluded'){
      totalFare = calculateExcludedDays(perDayBodyRent,perDayBodyRentNight,time);
    }else if(durationType == 'hours' && fuelType.toLowerCase() =='included'){
      totalFare = calculateIncludedHours(time,perHourFuelIncluded);
    }else{
      totalFare = calculateExcludedHours(time,perHourFuelExcluded);
    }

    double voucher = 0;
    double grandTotal = totalFare - voucher;


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
      "voucherType": "_",
      "totalFare": totalFare,
      "grandTotalFare" : grandTotal,
      "paymentType": "cash",
      "totalDistance": gap,
      "from": {
        "type": "Point",
        "coordinates": [pickUpAddress.coordinates.longitude, pickUpAddress.coordinates.latitude]
      },
      "to": {
        "type": "Point",
        "coordinates": [dropOffAddress.coordinates.longitude, dropOffAddress.coordinates.latitude]
      },
      "driverId": ViewModelRideResult.vehicleData.value.driver.oid,
      "bookingDate": DateFormat('yyyy-MM-dd').format(DateTime.now())
    };
    return data;
  }

  static requestRide(Map<String, dynamic> data, vehicleId) async{
    try{
      Response response = await DBHelper.dio.post(
        DotEnv().env['API_URL']+DotEnv().env['rentCarReq']+'/$vehicleId',
        data: data,
        options: Options(
          headers: {
            "Authorization" : "Bearer ${ViewModelUserData.userToken}"
          }
        )
      );

      return response.data['error'];

    }catch(e){
      print(e.toString());
      return true;
    }
  }

  static double calculateIncludedDays(perDayRent, perDayRentNight, journeyDuration, totalDistance, fuelCostUpDown){
    double totalFare = 0;
    totalFare = journeyDuration >1 ? perDayRentNight : perDayRent * journeyDuration + (totalDistance*fuelCostUpDown);
    return totalFare;
  }
  static double calculateExcludedDays(perDayRent, perDayRentNight, journeyDuration){
    double totalFare = 0;
    totalFare = journeyDuration >1 ? perDayRentNight : perDayRent * journeyDuration;
    return totalFare;
  }
  static double calculateIncludedHours(journeyDuration, perHourRentIncludeFuel){
    double totalFare = 0;
    totalFare = journeyDuration*perHourRentIncludeFuel;
    return totalFare;
  }
  static double calculateExcludedHours(journeyDuration, perHourRentExcludedFuel){
    double totalFare = 0;
    totalFare = journeyDuration*perHourRentExcludedFuel;
    return totalFare;
  }
}