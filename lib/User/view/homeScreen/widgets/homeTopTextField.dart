import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Utils/appConst.dart';

class HomeTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData prefix;
  final Function onTap;
  HomeTextField({
    @required this.controller,
    @required this.prefix,
    @required this.label,
    @required this.onTap,
});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1111)),
        child: Container(
          width: Get.width * .9,
          child: TextField(
            enabled: false,
            controller: controller,
            decoration: InputDecoration(
              labelText: label,
              labelStyle: TextStyle(
                color: AppConst.themeRed
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide.none
              ),
              prefixIcon: Icon(
                prefix,
                color: AppConst.themeRed,
              )
            ),
          ),
        ),
      ),
    );
  }
}
