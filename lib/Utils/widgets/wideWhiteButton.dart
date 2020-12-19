
import 'package:andgarivara_driver/Utils/controller/SizeConfigController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../appConst.dart';

class WideWhiteButton extends StatelessWidget {
  final GetSizeConfig sizeConfig = Get.find();
  final String label;
  final Function onPressed;
  WideWhiteButton({
    @required this.label,
    @required this.onPressed
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: sizeConfig.getPixels(45),
      width: double.infinity,
      child: OutlineButton(
        onPressed: onPressed,
        color: AppConst.appRed,
        borderSide: BorderSide(
          color: AppConst.appRed,
          width: 1.5
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(sizeConfig.width* 15)
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: sizeConfig.getPixels(20),
              fontFamily: 'Robot-M',
              color: AppConst.textBlue
            ),
          ),
        ),
      ),
    );
  }
}
