import 'package:andgarivara/Utils/appConst.dart';
import 'package:andgarivara/Utils/controller/SizeConfigController.dart';
import 'package:andgarivara/Utils/widgets/drawerlessAPpBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReferAFriendScreen extends StatelessWidget {
  final GetSizeConfig sizeConfig = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DrawerLessAppBar(),
      backgroundColor: AppConst.appRed,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: sizeConfig.getPixels(20)),
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }
}
