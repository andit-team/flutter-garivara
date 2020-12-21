import 'package:andgarivara/User/viewModel/viewModelRideResutl.dart';
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
                            'Fuel Type',
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
                              value: 'Included',
                              child: Text(
                                'Included Fuel'
                              )
                            ),
                            DropdownMenuItem(
                              value: 'Excluded',
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
                      body: Column(
                        children: [
                          RowItem(label: 'Fuel Type', value: ViewModelRideResult.vehicleData.value.fuelTypeDetails[0].title),
                          RowItem(label: 'Fuel Rate', value: ViewModelRideResult.vehicleData.value.fuelTypeDetails[0].rate.toString()),
                          RowItem(label: 'Vehicle Mileage', value: ViewModelRideResult.vehicleData.value.millage),
                          RowItem(label: 'Cost per/Km', value: fuelTypeController.text == 'included' ? ViewModelRideResult.vehicleData.value.serviceDetails.perHourRentWithFuel : ViewModelRideResult.vehicleData.value.serviceDetails.perHourRentWithoutFuel),
                        ],
                      ),
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

class RowItem extends StatelessWidget {
  final String label;
  final String value;
  RowItem({this.label, this.value});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              label
            ),
          ),
          Text(' =  '),
          Expanded(
            flex: 1,
            child: Text(
              value
            ),
          ),
        ],
      ),
    );
  }
}
