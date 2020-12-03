import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Utils/appConst.dart';
import '../../../../Utils/controller/SizeConfigController.dart';

class VehicleTypesCard extends StatelessWidget {
  final bool selected;
  VehicleTypesCard({
    this.selected
});
  final GetSizeConfig sizeConfig = Get.find();
  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: AppConst.duration,
      opacity: selected ? 1 : .5,
      child: AnimatedContainer(
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
            SizedBox(
              height: sizeConfig.height * 50,
              width: sizeConfig.width * 200,
              child: CachedNetworkImage(
                fit: BoxFit.contain,
                imageUrl: 'https://previews.123rf.com/images/janista/janista1709/janista170900014/85494232-car-black-and-white-sketch-vector-icon.jpg',
              ),
            ),
            Text(
              'Car',
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
