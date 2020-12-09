import 'package:andgarivara/Utils/appConst.dart';
import 'package:andgarivara/Utils/controller/SizeConfigController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RowDataWidget extends StatelessWidget {
  final String label;
  final String value;
  RowDataWidget({
    @required this.label,
    @required this.value
});
  final GetSizeConfig sizeConfig = Get.find();
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: AppConst.containerBg,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: sizeConfig.height * 15,horizontal: sizeConfig.width * 20),
        child: Row(
          children: [
            Expanded(
              flex: 7,
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  color: AppConst.textLight
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                ': ' + value,
                style: TextStyle(
                  fontSize: 16,
                  color: AppConst.textLight
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
