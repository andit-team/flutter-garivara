import 'package:andgarivara/Utils/appConst.dart';
import 'package:andgarivara/Utils/controller/SizeConfigController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentMethodCardWidget extends StatelessWidget {
  final GetSizeConfig sizeConfig = Get.find();
  final String image;
  final String title;
  final String subtitle;
  final bool selected;
  PaymentMethodCardWidget({
    @required this.image,
    @required this.title,
    @required this.selected,
    this.subtitle
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: sizeConfig.height * 25),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [AppConst.shadow.scale(.2)]
            ),
            height: sizeConfig.getPixels(90),
            width: double.infinity,
            padding: EdgeInsets.all(sizeConfig.height * 25),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AspectRatio(
                    aspectRatio: 84/56,
                    child: Image.asset(
                      image,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(width: sizeConfig.width * 30,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: sizeConfig.getPixels(18),
                        color: AppConst.textBlue
                      ),
                    ),
                    subtitle != null ? Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: sizeConfig.getPixels(14),
                        color: AppConst.textLight
                      ),
                    ) : SizedBox(),
                  ],
                ),
              ],
            )
          ),
          selected ? Positioned(
            right: 20,
            top: 0,
            bottom: 0,
            child: Icon(
              Icons.check_circle_sharp,
              size: sizeConfig.getPixels(40),
              color: AppConst.appGreen,
            ),
          ) : SizedBox()
        ],
      ),
    );
  }
}
