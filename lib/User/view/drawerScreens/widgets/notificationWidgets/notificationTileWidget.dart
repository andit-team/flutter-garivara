import 'package:andgarivara/Utils/appConst.dart';
import 'package:andgarivara/Utils/controller/SizeConfigController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationTileWidget extends StatelessWidget {
  final GetSizeConfig sizeConfig = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: sizeConfig.height * 10),
      decoration: BoxDecoration(
        color: AppConst.containerBg,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey
          )
        ),
      ),
      child: ListTile(
        isThreeLine: true,
        leading: Container(
          width: sizeConfig.width * 250,
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(
                color: Colors.grey
              )
            )
          ),
          child: Center(
            child: Icon(
              Icons.email_outlined,
              color: Colors.grey,
              size: sizeConfig.getPixels(40),
            ),
          ),
        ),
        title: Text(
          'Notification title',
          style: TextStyle(
            color: AppConst.textBlue
          ),
        ),
        subtitle: Text(
          'notification details',
          style: TextStyle(
            color: AppConst.textLight
          ),
        ),
      ),
    );
  }
}
