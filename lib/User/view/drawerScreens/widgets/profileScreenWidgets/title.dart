import 'package:andgarivara/Utils/appConst.dart';
import 'package:andgarivara/Utils/controller/SizeConfigController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TitleText extends StatelessWidget {
  final String title;
  TitleText({@required this.title});
  final GetSizeConfig sizeConfig = Get.find();
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: sizeConfig.getPixels(20),
        color: AppConst.textBlue,
        fontFamily: 'Roboto-M'
      ),
    );
  }
}
