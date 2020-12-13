import 'package:andgarivara/Utils/appConst.dart';
import 'package:andgarivara/Utils/controller/SizeConfigController.dart';
import 'package:andgarivara/Utils/stringResorces.dart';
import 'package:andgarivara/Utils/widgets/lightTextField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JourneyDurationWidget extends StatelessWidget {

  final GetSizeConfig sizeConfig = Get.find();
  final TextEditingController timeController;
  final TextEditingController durationTypeController;

  JourneyDurationWidget({
    @required this.timeController,
    @required this.durationTypeController
});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: sizeConfig.height * 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            StringResources.getQuoteJourneyDuration,
            style: TextStyle(
                fontSize: sizeConfig.getPixels(22),
                color: AppConst.textBlue
            ),
          ),
          SizedBox(height: sizeConfig.height * 7,),
          Row(
            children: [
              Expanded(
                child: LightTextField(
                  hintText: 'Select Time',
                  controller: timeController,
                  enabled: true,
                  textInputType: TextInputType.number,
                ),
              ),
              SizedBox(width: sizeConfig.width * 30,),
              Expanded(
                child: StatefulBuilder(
                  builder: (BuildContext context, void Function(void Function()) setState) {
                    return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(sizeConfig.width * 20),
                          border: Border.all(color: Color(0xffD2D2D2))
                      ),
                      padding: EdgeInsets.symmetric(horizontal: sizeConfig.width * 20),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          hint: Text(
                            'Days',
                            style: TextStyle(
                              color: Color(0xffD2D2D2)
                            ),
                          ),
                          value: durationTypeController.text,
                          onChanged: (value){
                            setState((){
                              durationTypeController.text = value;
                            });
                          },
                          items: [
                            DropdownMenuItem(
                              value: 'Days',
                              child: Text(
                                'Days'
                              )
                            ),
                            DropdownMenuItem(
                              value: 'Hours',
                              child: Text(
                                'Hours'
                              )
                            )
                          ],
                        ),
                      ),
                    );
                },),
              ),
            ],
          )
        ],
      ),
    );
  }
}
