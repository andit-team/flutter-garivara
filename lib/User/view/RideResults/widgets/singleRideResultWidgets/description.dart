import 'package:andgarivara/User/viewModel/viewModelRideResutl.dart';
import 'package:andgarivara/Utils/appConst.dart';
import 'package:andgarivara/Utils/controller/SizeConfigController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DescriptionWidget extends StatelessWidget {
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
              'Description',
              style: TextStyle(
                fontSize: sizeConfig.getPixels(22),
                color: AppConst.textBlue,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          children: [
            Container(
              color: AppConst.containerBg,
              width: double.infinity,
              padding: EdgeInsets.all(sizeConfig.getPixels(12)),
              child: RichText(
                text: TextSpan(
                  text: ViewModelRideResult.vehicleData.value.description ?? 'Loading',
                  style: TextStyle(
                    color: AppConst.textLight,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
