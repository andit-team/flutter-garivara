import 'package:andgarivara/User/view/RideResults/funcs/getQuotesFuncs.dart';
import 'package:andgarivara/Utils/appConst.dart';
import 'package:andgarivara/Utils/controller/SizeConfigController.dart';
import 'package:andgarivara/Utils/stringResorces.dart';
import 'package:andgarivara/Utils/widgets/lightTextField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PickJourneyDateWidget extends StatelessWidget {
  PickJourneyDateWidget({
    Key key,
    @required this.journeyDateController,
  }) : super(key: key);

  final GetSizeConfig sizeConfig = Get.find();
  final TextEditingController journeyDateController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: sizeConfig.height * 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            StringResources.getQuoteHeaderDate,
            style: TextStyle(
                fontSize: sizeConfig.getPixels(22),
                color: AppConst.textBlue
            ),
          ),
          SizedBox(height: sizeConfig.height * 7,),
          GestureDetector(
            onTap: () async{
              journeyDateController.text = await FuncGetQuotes.chooseJourneyDate(context);
            },
            child: LightTextField(
              hintText: 'Select Date',
              controller: journeyDateController,
            ),
          )
        ],
      ),
    );
  }
}