import 'package:andgarivara/Payment/view/choosePaymentMethodScreen.dart';
import 'package:andgarivara/User/model/costDetailsModel.dart';
import 'package:andgarivara/User/view/RideResults/addPromoCodeScreen.dart';
import 'package:andgarivara/User/view/RideResults/widgets/costDetailsScreen/finalCostRowDataWidget.dart';
import 'package:andgarivara/User/view/RideResults/widgets/costDetailsScreen/rowDataWidget.dart';
import 'package:andgarivara/User/view/homeScreen/homeScreen.dart';
import 'package:andgarivara/User/viewModel/viewModelRideResutl.dart';
import 'package:andgarivara/Utils/appConst.dart';
import 'package:andgarivara/Utils/controller/SizeConfigController.dart';
import 'package:andgarivara/Utils/stringResorces.dart';
import 'package:andgarivara/Utils/widgets/basicHeaderWidget.dart';
import 'package:andgarivara/Utils/widgets/drawerlessAPpBar.dart';
import 'package:andgarivara/Utils/widgets/snackBar.dart';
import 'package:andgarivara/Utils/widgets/underLinedText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CostDetailsScreen extends StatefulWidget {
  @override
  _CostDetailsScreenState createState() => _CostDetailsScreenState();
}

class _CostDetailsScreenState extends State<CostDetailsScreen> {
  final GetSizeConfig sizeConfig = Get.find();

  CostDetailsModel data;
  double bodyRate;
  double totalFare;

  @override
  void initState() {
    data = Get.arguments;
    if(data.durationType == 'days'){
      if(data.duration > 1){
        bodyRate = double.parse(ViewModelRideResult.vehicleData.value.serviceDetails.perDayBodyRentNightStay);
      }else{
        bodyRate = double.parse(ViewModelRideResult.vehicleData.value.serviceDetails.perDayBodyRent);
      }
    }else{
      if(data.fuelType == 'included'){
        bodyRate = double.parse(ViewModelRideResult.vehicleData.value.serviceDetails.perHourRentWithFuel);
      }else{
        bodyRate = double.parse(ViewModelRideResult.vehicleData.value.serviceDetails.perHourRentWithoutFuel);
      }
    }
    totalFare = (bodyRate*data.duration) + (dis*fuelCost);
    super.initState();
  }

  double fuelCost = ViewModelRideResult.vehicleData.value.fuelTypeDetails[0].rate/double.parse(ViewModelRideResult.vehicleData.value.millage);
  double dis = distance/1000;

  double voucher = 0;
  double grandTotal;

  @override
  Widget build(BuildContext context) {
      grandTotal = totalFare - voucher;
      return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: sizeConfig.getPixels(20),vertical: sizeConfig.height * 15),
        child: Column(
          children: [
            BasicHeaderWidget(
              title: StringResources.costDetailsTitle,
              subtitle: StringResources.costDetailsSubTitle
            ),
            /// cost details
            Container(
              width: double.infinity,
              height: sizeConfig.height * 450,
              decoration: BoxDecoration(
                color: AppConst.containerBg,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(sizeConfig.width * 20),
                  topLeft: Radius.circular(sizeConfig.width * 20),
                )
              ),
              child: Column(
                children: [
                  RowDataWidget(label: 'Your journey date', value: data.journeyDate),
                  RowDataWidget(label: 'Pickup time', value: data.pickUpTime),
                  RowDataWidget(label: 'Journey duration (${data.duration}${data.durationType.capitalize}X$bodyRate)', value: 'TK ${bodyRate*data.duration}'),
                  data.fuelType == 'included' ? RowDataWidget(label: 'Fuel package(${data.fuelType.capitalize})\n${dis.toStringAsFixed(2)} KmX${fuelCost.toStringAsFixed(2)}', value: 'TK ${(dis*fuelCost).toStringAsFixed(2)}') : SizedBox(),
                  /// total
                  CostCalculatedRowDataWidget(label: 'Total', cost: 'TK ${totalFare.toStringAsFixed(2)}'),
                  /// discount
                  CostCalculatedRowDataWidget(label: 'Discount', cost: '-TK ${voucher.toStringAsFixed(2)}',isBold: false,),
                  /// grandTotal
                  CostCalculatedRowDataWidget(label: 'Grand total', cost: 'TK ${grandTotal.toStringAsFixed(2)}')
                ],
              ),
            ),
            SizedBox(height: sizeConfig.height * 10,),
            /// promo code
            Row(
              children: [
                Spacer(),
                InkWell(
                  onTap: (){
                    Snack.top('Sorry!', 'Vouchers are currently disabled');
                    //TODO promo disabled
                    // Get.to(AddPromoCodeScreen());
                  },
                  child: UnderLinedText(
                    text: 'Do you have a Promo-Code?',
                    size: TextStyle(
                      fontSize: sizeConfig.getPixels(12),
                      color: AppConst.appBlue
                    ),
                    color: AppConst.appBlue,
                  ),
                )
              ],
            ),
            SizedBox(height: sizeConfig.height * 40,),
            /// Buttons
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: (){
                      Get.back();
                    },
                    borderRadius: BorderRadius.circular(sizeConfig.width * 10),
                    child: Container(
                      height: sizeConfig.getPixels(45),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(sizeConfig.width * 10),
                        border: Border.all(
                          color: AppConst.appRed
                        )
                      ),
                      child: Center(
                        child: Text(
                          'Edit Request',
                          style: TextStyle(
                            fontSize: sizeConfig.getPixels(18),
                            fontFamily: 'Robot-M',
                            color: AppConst.textBlue
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: sizeConfig.width * 30,),
                Expanded(
                  child: InkWell(
                    onTap: (){
                      Get.to(ChoosePaymentMethodScreen());
                    },
                    borderRadius: BorderRadius.circular(sizeConfig.width * 10),
                    child: Container(
                      height: sizeConfig.getPixels(45),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(sizeConfig.width * 10),
                        color: AppConst.appRed
                      ),
                      child: Center(
                        child: Text(
                          'Send Request',
                          style: TextStyle(
                              fontSize: sizeConfig.getPixels(18),
                              fontFamily: 'Robot-M',
                              color: Colors.white
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: sizeConfig.height * 60,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '* ',
                  style: TextStyle(
                      fontSize: sizeConfig.getPixels(14),
                      color: AppConst.appRed
                  ),
                ),
                Expanded(
                  child: Text(
                    StringResources.costDetailsFooter,
                    style: TextStyle(
                        fontSize: sizeConfig.getPixels(14),
                        color: AppConst.textLight
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
