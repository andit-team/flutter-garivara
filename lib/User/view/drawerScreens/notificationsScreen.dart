import 'package:andgarivara/User/view/drawerScreens/widgets/notificationWidgets/notificationTileWidget.dart';
import 'package:andgarivara/Utils/appConst.dart';
import 'package:andgarivara/Utils/controller/SizeConfigController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationsScreen extends StatelessWidget {
  final GetSizeConfig sizeConfig = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Notifications',
          style: TextStyle(
            color: AppConst.textBlue
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: sizeConfig.getPixels(20)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: (){

                },
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Clear',
                          style: TextStyle(
                            color: AppConst.appBlue
                          ),
                        ),
                        Icon(
                          Icons.clear_all,
                          color: AppConst.appBlue,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: sizeConfig.height * 20,),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: 20,
                itemBuilder: (_,index){
                  return NotificationTileWidget();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
