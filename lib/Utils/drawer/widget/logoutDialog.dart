
import 'package:andgarivara_driver/Utils/controller/SizeConfigController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LogoutDialog extends StatelessWidget {
  final GetSizeConfig sizeConfig = Get.find();
  final GetStorage localStorage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: sizeConfig.width*20,vertical: sizeConfig.height*20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
                'Are you sure you want to\nLogout?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: sizeConfig.getPixels(20),
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                )
            ),
            SizedBox(height: sizeConfig.height * 40,),
            FlatButton(
              onPressed: (){
                localStorage.erase();
                //TODO add signout page
                //Get.to(SignInScreen());
              },
              color: Color(0xffC8102E),
              child: Container(
                height: sizeConfig.height * 65,
                width: double.infinity,
                child: Center(
                  child: Text(
                      'Logout',
                      style: TextStyle(
                        fontSize: sizeConfig.getPixels(20),
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      )
                  ),
                ),
              ),
            ),
            SizedBox(height: sizeConfig.height * 20,),
            FlatButton(
              onPressed: (){
                Get.back();
              },
              color: Colors.black,
              child: Container(
                height: sizeConfig.height * 65,
                width: double.infinity,
                child: Center(
                  child: Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: sizeConfig.getPixels(20),
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      )
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
