import 'package:andgarivara/Utils/appConst.dart';
import 'package:andgarivara/Utils/controller/SizeConfigController.dart';
import 'package:andgarivara/Utils/stringResorces.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChooseFuelPackageTypeWidget extends StatelessWidget {
  final TextEditingController fuelTypeController;
  ChooseFuelPackageTypeWidget({this.fuelTypeController});

  final GetSizeConfig sizeConfig = Get.find();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: sizeConfig.height * 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            StringResources.getQuoteFuelPackage,
            style: TextStyle(
                fontSize: sizeConfig.getPixels(22),
                color: AppConst.textBlue
            ),
          ),
          SizedBox(height: sizeConfig.height * 7,),
          Row(
            children: [
              Expanded(
                flex: 8,
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
                          value: fuelTypeController.text,
                          onChanged: (value){
                            setState((){
                              fuelTypeController.text = value;
                            });
                          },
                          items: [
                            DropdownMenuItem(
                              value: 'Included Fuel',
                              child: Text(
                                'Included Fuel'
                              )
                            ),
                            DropdownMenuItem(
                              value: 'Excluded Fuel',
                              child: Text(
                                'Excluded Fuel'
                              )
                            )
                          ],
                        ),
                      ),
                    );
                  },),
              ),
              SizedBox(width: sizeConfig.width * 25,),
              Expanded(
                flex: 2,
                child: GestureDetector(
                  onTap: (){
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.INFO,
                      body: Image.asset('assets/demo/fuelInfo.png'),
                      btnCancelOnPress: (){}
                    )..show();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(sizeConfig.width * 20),
                      border: Border.all(color: Color(0xffD2D2D2)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: sizeConfig.height * 12),
                      child: Icon(
                        Icons.info_outline,
                        color: Color(0xff54545E),
                        size: sizeConfig.getPixels(30),
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
