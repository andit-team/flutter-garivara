import 'package:andgarivara/User/viewModel/viewModelRideResutl.dart';
import 'package:andgarivara/Utils/appConst.dart';
import 'package:andgarivara/Utils/controller/SizeConfigController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarDetailsWidget extends StatelessWidget {
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
              'Car Details',
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
              padding: EdgeInsets.all(sizeConfig.getPixels(12)),
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                primary: false,
                children: [
                  CarDetailItem(title: 'Model', data: ViewModelRideResult.vehicleData.value.model),
                  CarDetailItem(title: 'Capacity', data: ViewModelRideResult.vehicleData.value.capacity),
                  CarDetailItem(title: 'Color', data: ViewModelRideResult.vehicleData.value.color),
                  CarDetailItem(title: 'Fuel Type', data: ViewModelRideResult.vehicleData.value.fuelTypeDetails != null ? ViewModelRideResult.vehicleData.value.fuelTypeDetails[0].title : ''),
                  CarDetailItem(title: 'Gear Type', data: ViewModelRideResult.vehicleData.value.gearType),
                  CarDetailItem(title: 'Manufacture year', data: ViewModelRideResult.vehicleData.value.manufactureYear),
                  CarDetailItem(title: 'Vehicle CC', data: ViewModelRideResult.vehicleData.value.vehicleCc),
                  CarDetailItem(title: 'Mileage', data: ViewModelRideResult.vehicleData.value.millage),
                  CarDetailItem(title: 'Tires no', data: ViewModelRideResult.vehicleData.value.tiresNumber),
                  CarDetailItem(title: 'Vehicle length', data: ViewModelRideResult.vehicleData.value.vehicleLength),
                ]
                ,
              )
            )
          ],
        ),
      ),
    );
  }
}

class CarDetailItem extends StatelessWidget {
  final GetSizeConfig sizeConfig = Get.find();
  final String title;
  final String data;
  CarDetailItem({
    @required this.title,
    @required this.data,
});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: sizeConfig.height * 7),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                  fontSize: sizeConfig.getPixels(16)
              ),
            ),
          ),
          Text(
            ' : ',
            style: TextStyle(
                fontSize: sizeConfig.getPixels(16),
                fontWeight: FontWeight.bold
            ),
          ),
          Expanded(
            child: Text(
              data ?? '123',
              style: TextStyle(
                  fontSize: sizeConfig.getPixels(16)
              ),
            ),
          )
        ],
      ),
    );
  }
}

