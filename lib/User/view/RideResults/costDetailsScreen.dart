import 'package:andgarivara/Payment/view/choosePaymentMethodScreen.dart';
import 'package:andgarivara/User/view/RideResults/addPromoCodeScreen.dart';
import 'package:andgarivara/User/view/RideResults/widgets/costDetailsScreen/finalCostRowDataWidget.dart';
import 'package:andgarivara/User/view/RideResults/widgets/costDetailsScreen/rowDataWidget.dart';
import 'package:andgarivara/Utils/appConst.dart';
import 'package:andgarivara/Utils/controller/SizeConfigController.dart';
import 'package:andgarivara/Utils/stringResorces.dart';
import 'package:andgarivara/Utils/widgets/basicHeaderWidget.dart';
import 'package:andgarivara/Utils/widgets/drawerlessAPpBar.dart';
import 'package:andgarivara/Utils/widgets/underLinedText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CostDetailsScreen extends StatelessWidget {
  final GetSizeConfig sizeConfig = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: DrawerLessAppBar(),
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
              height: sizeConfig.height * 430,
              decoration: BoxDecoration(
                color: AppConst.containerBg,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(sizeConfig.width * 20),
                  topLeft: Radius.circular(sizeConfig.width * 20),
                )
              ),
              child: Column(
                children: [
                  RowDataWidget(label: 'Your journey date', value: '15 Dec 2020'),
                  RowDataWidget(label: 'Pickup time', value: '10:00 pm'),
                  RowDataWidget(label: 'Journey duration (5daysX2000)', value: 'TK 10000'),
                  RowDataWidget(label: 'Fuel package(included) 254KmX35', value: 'TK 8890'),
                  /// total
                  CostCalculatedRowDataWidget(label: 'Total', cost: 'TK 18890'),
                  /// discount
                  CostCalculatedRowDataWidget(label: 'Discount', cost: '-TK 190',isBold: false,),
                  /// grandTotal
                  CostCalculatedRowDataWidget(label: 'Grand total', cost: 'TK 18700')
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
                    Get.to(AddPromoCodeScreen());
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
