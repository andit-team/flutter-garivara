import 'package:flutter/cupertino.dart';

class CostDetailsModel{
  String journeyDate;
  String pickUpTime;
  int duration;
  String durationType;
  String fuelType;
  CostDetailsModel({
    @required this.journeyDate,
    @required this.pickUpTime,
    @required this.duration,
    @required this.durationType,
    @required this.fuelType,
});
}