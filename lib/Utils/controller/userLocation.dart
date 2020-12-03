import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GetUserLocation extends GetxController{
  Rx<LatLng> location = LatLng(0.0,0.0).obs;
  updateLocation(LatLng latLng) => location.value = latLng;
}