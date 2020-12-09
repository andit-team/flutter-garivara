import 'package:andgarivara/Utils/appConst.dart';
import 'package:andgarivara/Utils/controller/SizeConfigController.dart';
import 'package:andgarivara/Utils/stringResorces.dart';
import 'package:andgarivara/Utils/widgets/basicHeaderWidget.dart';
import 'package:andgarivara/Utils/widgets/drawerlessAPpBar.dart';
import 'package:andgarivara/Utils/widgets/lightTextField.dart';
import 'package:andgarivara/Utils/widgets/wideRedButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AddCreditCardScreen extends StatelessWidget {
  final GetSizeConfig sizeConfig = Get.find();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController ccvController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: DrawerLessAppBar(
          height: sizeConfig.height.value,
          width: sizeConfig.width.value,
        ),
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Container(
                height: sizeConfig.height * 470,
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
                    BasicHeaderWidget(title: StringResources.addCardTitle, subtitle:StringResources.addCardSubtitle),
                    LightTextField(
                      hintText: 'Enter your name',
                      controller: nameController,
                      enabled: true,
                    ),
                    SizedBox(height: sizeConfig.height * 20,),
                    LightTextField(
                      hintText: 'Enter card number',
                      controller: cardNumberController,
                      enabled: true,
                      textInputType: TextInputType.number,
                      inputFormatter: [
                        LengthLimitingTextInputFormatter(16),
                      ],
                    ),
                    SizedBox(height: sizeConfig.height * 20,),
                    Row(
                      children: [
                        Expanded(
                          child: LightTextField(
                            hintText: 'Expire date',
                            controller: expiryDateController,
                            enabled: true,
                            textInputType: TextInputType.numberWithOptions(),
                          ),
                        ),
                        SizedBox(width: sizeConfig.width * 30,),
                        Expanded(
                          child: LightTextField(
                            hintText: 'CCV',
                            controller: ccvController,
                            textInputType: TextInputType.number,
                            enabled: true,
                            inputFormatter: [
                              LengthLimitingTextInputFormatter(5)
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: sizeConfig.height * 60,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: WideRedButton(
                  label: 'Save',
                  onPressed: (){

                  }
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
