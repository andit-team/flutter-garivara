import 'package:andgarivara/Utils/appConst.dart';
import 'package:andgarivara/Utils/controller/SizeConfigController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TitleWithTextButton extends StatelessWidget {
  final GetSizeConfig sizeConfig = Get.find();

  final String title;
  final String subtitle;
  final Function onTap;

  TitleWithTextButton({
    @required this.title,
    @required this.subtitle,
    @required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: sizeConfig.height * 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: sizeConfig.getPixels(16),
                color: AppConst.textLight
            ),
          ),
          SizedBox(height: sizeConfig.height * 10,),
          GestureDetector(
            onTap: onTap,
            child: Text(
              subtitle,
              style: TextStyle(
                fontSize: sizeConfig.getPixels(18),
                color: AppConst.textBlue
              ),
            ),
          ),
        ],
      ),
    );
  }
}
