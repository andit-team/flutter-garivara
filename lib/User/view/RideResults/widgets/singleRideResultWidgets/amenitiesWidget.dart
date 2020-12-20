import 'package:andgarivara/User/viewModel/viewModelRideResutl.dart';
import 'package:andgarivara/Utils/appConst.dart';
import 'package:andgarivara/Utils/controller/SizeConfigController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AmenitiesWidget extends StatelessWidget {
  final GetSizeConfig sizeConfig = Get.find();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: sizeConfig.getPixels(15)),
      child: Card(
        child: ExpansionTile(
          tilePadding: EdgeInsets.zero,
          initiallyExpanded: true,
          title: Padding(
            padding: EdgeInsets.only(left: sizeConfig.width * 30),
            child: Text(
              'Amenities',
              style: TextStyle(
                  fontSize: sizeConfig.getPixels(22),
                  color: AppConst.textBlue,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
          children: [
            Container(
              width: double.infinity,
              color: AppConst.containerBg,
              padding: EdgeInsets.all(sizeConfig.getPixels(10)),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.end,
                spacing: sizeConfig.width * 50,
                runSpacing: sizeConfig.height * 10,
                children: [
                  AmenitiesItem(title: 'AC', status: ViewModelRideResult.vehicleData.value.amenities.ac),
                  AmenitiesItem(title: 'Air Bags', status: ViewModelRideResult.vehicleData.value.amenities.airBags),
                  AmenitiesItem(title: 'Alloy Rims', status: ViewModelRideResult.vehicleData.value.amenities.alloyRims),
                  AmenitiesItem(title: 'CD Player', status: ViewModelRideResult.vehicleData.value.amenities.cdPlayer),
                  AmenitiesItem(title: 'FM Radio', status: ViewModelRideResult.vehicleData.value.amenities.fmRadio),
                  AmenitiesItem(title: 'Navigation System', status: ViewModelRideResult.vehicleData.value.amenities.navigationSystem),
                  AmenitiesItem(title: 'Power Locks', status: ViewModelRideResult.vehicleData.value.amenities.powerLocks),
                  AmenitiesItem(title: 'Power Mirrors', status: ViewModelRideResult.vehicleData.value.amenities.powerMirrors),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AmenitiesItem extends StatelessWidget {
  final GetSizeConfig sizeConfig = Get.find();
  final String title;
  final bool status;
  AmenitiesItem({
    @required this.title,
    @required this.status
});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: sizeConfig.width * 400,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            status ? Icons.check : Icons.do_not_disturb_alt,
            size: sizeConfig.getPixels(15),
            color: status ? AppConst.appGreen : AppConst.appRed,
          ),
          Text(
            ' $title',
            style: TextStyle(
                color: AppConst.textBlue
            ),
          )
        ],
      ),
    );
  }
}
