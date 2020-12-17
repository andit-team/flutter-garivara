import 'package:andgarivara/Utils/appConst.dart';
import 'package:andgarivara/Utils/controller/SizeConfigController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawerTileWidget extends StatelessWidget {
  final GetSizeConfig sizeConfig = Get.find();
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(
          Icons.home_outlined,
          color: AppConst.appRed,
          size: sizeConfig.getPixels(35),
        ),
        title: Text(
          '61, Ahsan ahmed road, PTI, Khulna.'
        ),
        subtitle: Text(
          '2.5 Km'
        ),
      ),
    );
  }
}
