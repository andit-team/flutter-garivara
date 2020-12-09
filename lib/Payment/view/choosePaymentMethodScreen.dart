import 'package:andgarivara/Payment/view/addCardScreen.dart';
import 'package:andgarivara/User/view/RideResults/widgets/paymentMethodCardWidget.dart';
import 'package:andgarivara/Utils/appConst.dart';
import 'package:andgarivara/Utils/controller/SizeConfigController.dart';
import 'package:andgarivara/Utils/stringResorces.dart';
import 'package:andgarivara/Utils/widgets/basicHeaderWidget.dart';
import 'package:andgarivara/Utils/widgets/drawerlessAPpBar.dart';
import 'package:andgarivara/Utils/widgets/wideRedButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChoosePaymentMethodScreen extends StatelessWidget {
  final GetSizeConfig sizeConfig = Get.find();
  @override
  Widget build(BuildContext context) {

    String chosenMethod = 'cash';

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: DrawerLessAppBar(
        height: sizeConfig.height.value,
        width: sizeConfig.width.value,
        widget: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FlatButton(
            onPressed: (){
              Get.to(AddCreditCardScreen());
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.add_circle_outline,
                  color: AppConst.appBlue,
                  size: sizeConfig.getPixels(22),
                ),
                SizedBox(width: sizeConfig.width * 10,),
                Text(
                  'Add',
                  style: TextStyle(
                    color: AppConst.appBlue,
                    fontSize: sizeConfig.getPixels(18)
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: sizeConfig.height * 800,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(sizeConfig.width * 70),
                bottomRight: Radius.circular(sizeConfig.width * 70),
              ),
              boxShadow: [
                AppConst.shadow
              ],
              color: Colors.white,
            ),
            padding: EdgeInsets.symmetric(horizontal: sizeConfig.getPixels(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BasicHeaderWidget(title: StringResources.paymentMethodTitle, subtitle: StringResources.paymentMethodSubtitle),

                /// payment methods

                StatefulBuilder(builder: (BuildContext context, void Function(void Function()) setState) {
                  return Column(
                    children: [
                      /// master card
                      InkWell(
                        onTap: (){
                          setState((){
                            chosenMethod = 'master';
                          });
                        },
                        child: PaymentMethodCardWidget(
                          image: 'assets/images/paymentMethods/master_card.png',
                          title: '**** **** **** 4457',
                          subtitle: 'Expires: 12/21',
                          selected: chosenMethod == 'master',
                        ),
                      ),
                      /// visa card
                      InkWell(
                        onTap: (){
                          setState((){
                            chosenMethod = 'visa';
                          });
                        },
                        child: PaymentMethodCardWidget(
                          image: 'assets/images/paymentMethods/visa_card.png',
                          title: '**** **** **** 8745',
                          subtitle: 'Expires: 02/22',
                          selected: chosenMethod == 'visa',
                        ),
                      ),
                      /// bKash
                      InkWell(
                        onTap: (){
                          setState((){
                            chosenMethod = 'bkash';
                          });
                        },
                        child: PaymentMethodCardWidget(
                          image: 'assets/images/paymentMethods/bkash.jpg',
                          title: '+88014152578963',
                          selected: chosenMethod == 'bkash',
                        ),
                      ),
                      /// cash
                      InkWell(
                        onTap: (){
                          setState((){
                            chosenMethod = 'cash';
                          });
                        },
                        child: PaymentMethodCardWidget(
                          image: 'assets/images/paymentMethods/taka.png',
                          title: 'Cash',
                          selected: chosenMethod == 'cash',
                        ),
                      ),
                    ],
                  );
                },)
              ],
            ),
          ),
          SizedBox(height: sizeConfig.height * 65,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: sizeConfig.getPixels(20)),
            child: WideRedButton(
              label: 'Confirm request',
              onPressed: (){

              },
            ),
          )
        ],
      ),
    );
  }
}
