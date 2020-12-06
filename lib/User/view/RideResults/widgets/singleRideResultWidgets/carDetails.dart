import 'package:andgarivara/Utils/appConst.dart';
import 'package:andgarivara/Utils/controller/SizeConfigController.dart';
import 'package:andgarivara/Utils/stringResorces.dart';
import 'package:andgarivara/demo/demoData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarDetailsWidget extends StatelessWidget {
  final GetSizeConfig sizeConfig = Get.find();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: sizeConfig.getPixels(15)),
      child: Card(
        child: ExpansionTile(
          tilePadding: EdgeInsets.zero,
          initiallyExpanded: true,
          title: Padding(
            padding: EdgeInsets.only(left: sizeConfig.width * 30),
            child: Text(
              'Car Details',
              style: TextStyle(
                  fontSize: sizeConfig.getPixels(22),
                  color: AppConst.textBlue,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
          children: [
            Container(
              width: double.infinity,
              color: AppConst.containerBg,
              padding: EdgeInsets.all(sizeConfig.getPixels(12)),
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                primary: false,
                itemCount: DemoCarDetails.demoCarDetails.length,
                itemBuilder: (_,index){
                  DemoCarDetails details = DemoCarDetails.demoCarDetails[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: sizeConfig.height * 7),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            details.title,
                            style: TextStyle(
                              fontSize: sizeConfig.getPixels(16)
                            ),
                          ),
                        ),
                        Text(
                          ' : ',
                          style: TextStyle(
                            fontSize: sizeConfig.getPixels(16),
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Expanded(
                          child: Text(
                            details.data,
                            style: TextStyle(
                              fontSize: sizeConfig.getPixels(16)
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              )
            )
          ],
        ),
      ),
    );
  }
}
