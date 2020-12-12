import 'package:andgarivara/Utils/appConst.dart';
import 'package:andgarivara/Utils/controller/SizeConfigController.dart';
import 'package:andgarivara/Utils/widgets/lightTextField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextBoxWithTitle extends StatelessWidget {
  final GetSizeConfig sizeConfig = Get.find();

  final String title;
  final TextEditingController controller;
  final bool enabled;
  final bool obscure;

  TextBoxWithTitle({
    @required this.title,
    @required this.controller,
    this.enabled = false,
    this.obscure = false
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
          LightTextField(
            hintText: '',
            controller: controller,
            enabled: enabled,
            obscure: obscure,
          )
        ],
      ),
    );
  }
}
