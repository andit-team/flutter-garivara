import 'package:andgarivara/Utils/appConst.dart';
import 'package:andgarivara/Utils/controller/SizeConfigController.dart';
import 'package:andgarivara/Utils/stringResorces.dart';
import 'package:andgarivara/Utils/widgets/drawerlessAPpBar.dart';
import 'package:andgarivara/Utils/widgets/lightTextField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/promoCardWidget.dart';

class AddPromoCodeScreen extends StatelessWidget {
  final GetSizeConfig sizeConfig = Get.find();

  final TextEditingController promoCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    int selectedPromo;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: DrawerLessAppBar(
        height: sizeConfig.height.value,
        width: sizeConfig.width.value,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// top stuff
          Container(
            height: sizeConfig.height * 350,
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
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: sizeConfig.getPixels(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: double.infinity,height: AppBar().preferredSize.height + sizeConfig.height * 25,),
                  Text(
                    StringResources.addPromoTitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: sizeConfig.getPixels(28),
                        fontWeight: FontWeight.bold,
                        color: AppConst.textBlue
                    ),
                  ),
                  SizedBox(height: sizeConfig.height * 20,),
                  LightTextField(
                    hintText: 'Enter your promotional code',
                    controller: promoCodeController,
                    enabled: true,
                  ),
                  SizedBox(height: sizeConfig.height * 20,),
                  FlatButton(
                    onPressed: (){

                    },
                    height: sizeConfig.getPixels(45),
                    minWidth: double.infinity,
                    color: AppConst.appRed,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(sizeConfig.width* 15)
                    ),
                    child: Center(
                      child: Text(
                        'Apply code',
                        style: TextStyle(
                            fontSize: sizeConfig.getPixels(20),
                            fontFamily: 'Robot-M',
                            color: Colors.white
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),

          SizedBox(height: sizeConfig.height * 40,),
          ///bottom stuff
          StatefulBuilder(builder: (BuildContext context, void Function(void Function()) setState) {
            return Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: 10,
                itemBuilder: (_,index){
                  return GestureDetector(
                      onTap: (){
                        setState(() {
                          selectedPromo = index;
                        });
                      },
                      child: PromoCardWidget(selected: index == selectedPromo)
                  );
                },
              ),
            );
          },)
        ],
      ),
    );
  }
}