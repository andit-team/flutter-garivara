import 'package:andgarivara/Utils/controller/SizeConfigController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LightTextField extends StatelessWidget {
  final GetSizeConfig sizeConfig = Get.find();
  final String hintText;
  final bool enabled;
  final TextInputType textInputType;
  final TextEditingController controller;
  final bool suffix;
  final inputFormatter;
  LightTextField({
    @required this.hintText,
    this.enabled = false,
    this.suffix = false,
    this.inputFormatter,
    this.textInputType = TextInputType.text,
    @required this.controller
});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextField(
          keyboardType: textInputType,
          inputFormatters: inputFormatter,
          controller: controller,
          enabled: enabled,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: Color(0xffD2D2D2)
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xffD2D2D2),
              ),
              borderRadius: BorderRadius.circular(sizeConfig.width * 20),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xffD2D2D2),
              ),
              borderRadius: BorderRadius.circular(sizeConfig.width * 20),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xffD2D2D2),
              ),
              borderRadius: BorderRadius.circular(sizeConfig.width * 20),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xffD2D2D2),
              ),
              borderRadius: BorderRadius.circular(sizeConfig.width * 20),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xffD2D2D2),
              ),
              borderRadius: BorderRadius.circular(sizeConfig.width * 20),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xffD2D2D2),
              ),
              borderRadius: BorderRadius.circular(sizeConfig.width * 20),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: sizeConfig.width * 25)
          ),
        ),
        suffix ? Positioned(
          right: sizeConfig.width * 10,
          child: IconButton(
            onPressed: ()=>controller.clear(),
            icon: Icon(
              Icons.cancel,
              color: Color(0xffD2D2D2),
            ),
          ),
        ) : SizedBox()
      ],
    );
  }
}
