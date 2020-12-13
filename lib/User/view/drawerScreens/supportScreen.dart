import 'package:andgarivara/Utils/appConst.dart';
import 'package:andgarivara/Utils/controller/SizeConfigController.dart';
import 'package:andgarivara/Utils/stringResorces.dart';
import 'package:andgarivara/Utils/widgets/drawerlessAPpBar.dart';
import 'package:andgarivara/Utils/widgets/wideRedButton.dart';
import 'package:andgarivara/Utils/widgets/wideWhiteButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SupportScreen extends StatelessWidget {
  final GetSizeConfig sizeConfig = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DrawerLessAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: sizeConfig.getPixels(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              StringResources.supportTitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: sizeConfig.getPixels(28),
                  fontWeight: FontWeight.bold,
                  color: AppConst.textBlue
              ),
            ),
            SizedBox(height: sizeConfig.height * 10,),



            Text(
              StringResources.supportHeader1,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: sizeConfig.getPixels(22),
                  fontWeight: FontWeight.bold,
                  color: AppConst.textBlue
              ),
            ),
            Text(
              StringResources.loremIpsum,
              maxLines: 6,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: sizeConfig.getPixels(16),
                  color: AppConst.textLight,
                  height: 1.5
              ),
            ),
            SizedBox(height: sizeConfig.height * 10,),

            Text(
              StringResources.supportHeader2,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: sizeConfig.getPixels(22),
                  fontWeight: FontWeight.bold,
                  color: AppConst.textBlue
              ),
            ),
            Text(
              StringResources.loremIpsum,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: sizeConfig.getPixels(16),
                  color: AppConst.textLight,
                  height: 1.5
              ),
            ),
            SizedBox(height: sizeConfig.height * 10,),

            Text(
              StringResources.supportHeader3,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: sizeConfig.getPixels(22),
                  fontWeight: FontWeight.bold,
                  color: AppConst.textBlue
              ),
            ),
            Text(
              StringResources.loremIpsum,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: sizeConfig.getPixels(16),
                  color: AppConst.textLight,
                  height: 1.5
              ),
            ),
            SizedBox(height: sizeConfig.height * 10,),

            Text(
              StringResources.supportHeader4,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: sizeConfig.getPixels(22),
                  fontWeight: FontWeight.bold,
                  color: AppConst.textBlue
              ),
            ),
            Text(
              StringResources.loremIpsum,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: sizeConfig.getPixels(16),
                  color: AppConst.textLight,
                  height: 1.5
              ),
            ),
            SizedBox(height: sizeConfig.height * 10,),

            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: sizeConfig.width * 260,
                      height: sizeConfig.height * 5,
                      color: Color(0xff707070),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: sizeConfig.width * 10),
                      child: Text(
                        'Or connect with',
                        style: TextStyle(fontSize: sizeConfig.getPixels(18),
                            fontWeight: FontWeight.bold,
                            color: Color(0xff34415F)
                        ),
                      ),
                    ),
                    Container(
                      width: sizeConfig.width * 260,
                      height: sizeConfig.height * 5,
                      color: Color(0xff707070),
                    ),
                  ],
                ),
                SizedBox(height: sizeConfig.height * 10),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                          height: sizeConfig.height * 45,
                          width: sizeConfig.height * 45,
                          child: Image.asset('assets/images/signUpMethods/brands-and-logotypes.png')),
                    ),
                    GestureDetector(
                      onTap: (){},
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: sizeConfig.width * 35
                        ),
                        child: Container(
                            height: sizeConfig.height * 45,
                            width: sizeConfig.height * 45,
                            child: Image.asset('assets/images/signUpMethods/facebook.png')),
                      ),
                    ),
                    Container(
                        height: sizeConfig.height * 45,
                        width: sizeConfig.height * 45,
                        child: Image.asset('assets/images/signUpMethods/twitter.png')),
                  ],
                ),
                SizedBox(height: sizeConfig.height * 20),
                WideRedButton(
                  label: 'Call customer support',
                  onPressed: (){

                  },
                ),
                SizedBox(height: sizeConfig.height * 10),
                WideWhiteButton(
                  label: 'Send us mail',
                  onPressed: (){

                  },
                ),
              ],
            )

          ],
        ),
      ),
    );
  }
}
