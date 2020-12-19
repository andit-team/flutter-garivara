import 'package:andgarivara/User/model/vehicleTypeListModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Utils/appConst.dart';
import '../../../../Utils/controller/SizeConfigController.dart';

class VehicleTypesCard extends StatelessWidget {
  final bool selected;
  final VehicleTypeModel data;
  VehicleTypesCard({
    this.selected,
    this.data
});
  final GetSizeConfig sizeConfig = Get.find();
  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: AppConst.duration,
      opacity: selected ? 1 : .5,
      child: AnimatedContainer(
        height: sizeConfig.height * 70,
        width: sizeConfig.width * 230,
        duration: AppConst.duration,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(sizeConfig.width * 30),
            border: selected ? Border.all(
                color: AppConst.appGreen,
                width: 2
            ) : Border(
              top: BorderSide.none,
              bottom: BorderSide.none,
              left: BorderSide.none,
              right: BorderSide.none,
            )
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: sizeConfig.height * 35,
              width: sizeConfig.width * 200,
              child: CachedNetworkImage(
                fit: BoxFit.contain,
                imageUrl: data.icon,
              ),
            ),
            Text(
              data.title,
              style: TextStyle(
                  fontSize: sizeConfig.getPixels(16),
                  fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                  color: selected ? AppConst.appGreen : Colors.black
              ),
            )
          ],
        ),
      ),
    );
  }
}
