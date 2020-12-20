import 'package:andgarivara/User/view/homeScreen/homeScreen.dart';
import 'package:andgarivara/Utils/appConst.dart';
import 'package:andgarivara/Utils/controller/SizeConfigController.dart';
import 'package:andgarivara/Utils/stringResorces.dart';
import 'package:andgarivara/Utils/widgets/lightTextField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JourneyStatAndEndPointWidget extends StatelessWidget {
  final GetSizeConfig sizeConfig = Get.find();
  final TextEditingController startPointController = TextEditingController(text: pickUpAddress.addressLine);
  final TextEditingController endPointController = TextEditingController(text: dropOffAddress.addressLine);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: sizeConfig.height * 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            StringResources.getQuoteStartEnd,
            style: TextStyle(
                fontSize: sizeConfig.getPixels(22),
                color: AppConst.textBlue
            ),
          ),
          SizedBox(height: sizeConfig.height * 7,),
          LightTextField(
            hintText: 'From',
            controller: startPointController
          ),
          SizedBox(height: sizeConfig.height * 10,),
          LightTextField(
            hintText: 'To',
            controller: endPointController
          ),
          SizedBox(height: sizeConfig.height * 7,),
          /*Row(
            children: [
              Icon(
                Icons.location_on_rounded,
                color: Color(0xff707070),
              ),
              Text(
                StringResources.chooseLocationMapHint,
                style: TextStyle(
                    color: Color(0xff707070),
                    fontSize: sizeConfig.getPixels(16)
                ),
              ),
            ],
          )*/
        ],
      ),
    );
  }
}
