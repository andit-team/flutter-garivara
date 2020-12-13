import 'package:andgarivara/Utils/appConst.dart';
import 'package:andgarivara/Utils/controller/SizeConfigController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CostCalculatedRowDataWidget extends StatelessWidget {
  final GetSizeConfig sizeConfig = Get.find();

  final String label;
  final String cost;
  final bool isBold;

  CostCalculatedRowDataWidget({
    @required this.label,
    @required this.cost,
    this.isBold = true
});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: sizeConfig.height * 15),
      child: Row(
        children: [
          Expanded(
            flex: 7,
            child: Text(
              '$label:',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16,
                  color: AppConst.textLight
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              cost,
              style: TextStyle(
                  fontSize: 16,
                  color: AppConst.textLight,
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal
              ),
            ),
          ),
        ],
      ),
    );
  }
}
