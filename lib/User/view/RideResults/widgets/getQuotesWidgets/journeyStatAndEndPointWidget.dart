import 'package:andgarivara/Utils/appConst.dart';
import 'package:andgarivara/Utils/controller/SizeConfigController.dart';
import 'package:andgarivara/Utils/stringResorces.dart';
import 'package:andgarivara/Utils/widgets/lightTextField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JourneyStatAndEndPointWidget extends StatelessWidget {
  final GetSizeConfig sizeConfig = Get.find();
  final TextEditingController endPointController;
  final TextEditingController startPointController;
  JourneyStatAndEndPointWidget({
    @required this.endPointController,
    @required this.startPointController
});
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
            suffix: true,
            controller: startPointController
          ),
          SizedBox(height: sizeConfig.height * 10,),
          LightTextField(
            hintText: 'To',
            suffix: true,
            controller: endPointController
          ),
          SizedBox(height: sizeConfig.height * 7,),
          Row(
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
          )
        ],
      ),
    );
  }
}
