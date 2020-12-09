import 'package:andgarivara/Utils/controller/SizeConfigController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../appConst.dart';

class WideRedButton extends StatelessWidget {
  final GetSizeConfig sizeConfig = Get.find();
  final String label;
  final Function onPressed;
  WideRedButton({
    @required this.label,
    @required this.onPressed
});
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      height: sizeConfig.getPixels(45),
      minWidth: double.infinity,
      color: AppConst.appRed,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(sizeConfig.width* 15)
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
              fontSize: sizeConfig.getPixels(20),
              fontFamily: 'Robot-M',
              color: Colors.white
          ),
        ),
      ),
    );
  }
}
