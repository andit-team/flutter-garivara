import 'package:andgarivara/Utils/appConst.dart';
import 'package:andgarivara/Utils/controller/SizeConfigController.dart';
import 'package:andgarivara/Utils/stringResorces.dart';
import 'package:andgarivara/Utils/widgets/drawerlessAPpBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CostDetailsScreen extends StatelessWidget {
  final GetSizeConfig sizeConfig = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DrawerLessAppBar(
        height: sizeConfig.height.value,
        width: sizeConfig.width.value,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: sizeConfig.getPixels(20),vertical: sizeConfig.height * 15),
        child: ListView(
          children: [
            Text(
              StringResources.costDetailsTitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: sizeConfig.getPixels(28),
                  fontWeight: FontWeight.bold,
                  color: AppConst.textBlue
              ),
            ),
            SizedBox(height: sizeConfig.height * 10,),
            Text(
              StringResources.costDetailsSubTitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: sizeConfig.getPixels(18),
                  color: AppConst.textLight
              ),
            ),
            SizedBox(height: sizeConfig.height * 10,),

          ],
        ),
      ),
    );
  }
}
