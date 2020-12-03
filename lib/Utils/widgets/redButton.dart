import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../appConst.dart';
import '../controller/SizeConfigController.dart';

class RedButton extends StatelessWidget {
  final String title;
  final Function function;
  final IconData icon;
  RedButton({@required this.title, @required this.function, this.icon});
  final GetSizeConfig sizeConfigController = Get.find();
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: function,
      color: AppConst.themeRed,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11111)),
      child: Container(
        height: sizeConfigController.height * 70,
        width: sizeConfigController.width * 1000,
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              icon != null ? Icon(
                icon,
                size: sizeConfigController.height * 35,
                color: Colors.white,
              ): Text(''),
              icon != null ? SizedBox(width: sizeConfigController.width * 25,) : Text(''),
              Text(
                title,
                style: TextStyle(fontSize: sizeConfigController.getPixels(20),color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
