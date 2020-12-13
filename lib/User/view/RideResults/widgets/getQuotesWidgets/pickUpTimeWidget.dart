import 'package:andgarivara/User/view/RideResults/funcs/getQuotesFuncs.dart';
import 'package:andgarivara/Utils/appConst.dart';
import 'package:andgarivara/Utils/controller/SizeConfigController.dart';
import 'package:andgarivara/Utils/stringResorces.dart';
import 'package:andgarivara/Utils/widgets/lightTextField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class PickUptimeWidget extends StatelessWidget {
  PickUptimeWidget({
    Key key,
    @required this.pickUpTimeController,
  }) : super(key: key);

  final GetSizeConfig sizeConfig = Get.find();
  final TextEditingController pickUpTimeController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: sizeConfig.height * 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            StringResources.getQuoteHeaderPickupTime,
            style: TextStyle(
                fontSize: sizeConfig.getPixels(22),
                color: AppConst.textBlue
            ),
          ),
          SizedBox(height: sizeConfig.height * 7,),
          GestureDetector(
            onTap: () async{
              pickUpTimeController.text = await FuncGetQuotes.choosePickUpTime(context);
            },
            child: LightTextField(
              hintText: 'Select Time',
              controller: pickUpTimeController,
            ),
          )
        ],
      ),
    );
  }
}