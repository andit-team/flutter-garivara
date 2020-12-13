import 'package:andgarivara/Utils/enum.dart';
import 'package:get/get.dart';

class GetRideStatusController extends GetxController{
  Rx<RideStatus> status = RideStatus.NONE.obs;
  updateStatus(RideStatus value) => status.value = value;
}