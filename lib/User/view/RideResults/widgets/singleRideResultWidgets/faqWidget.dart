import 'package:andgarivara/User/model/vehicleDetails.dart';
import 'package:andgarivara/User/viewModel/viewModelRideResutl.dart';
import 'package:andgarivara/Utils/appConst.dart';
import 'package:andgarivara/Utils/controller/SizeConfigController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FaqWidget extends StatelessWidget {
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
              'FAQ',
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
                  itemCount: ViewModelRideResult.vehicleData.value.serviceDetails.faq.length,
                  itemBuilder: (_,index){
                    return FaqItem(index: index);
                  },
                )
            )
          ],
        ),
      ),
    );
  }
}

class FaqItem extends StatelessWidget {
  final GetSizeConfig sizeConfig = Get.find();
  final int index;
  FaqItem({
    @required this.index
  });
  @override
  Widget build(BuildContext context) {
    VehicleFaq faq = ViewModelRideResult.vehicleData.value.serviceDetails.faq[index];
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide()
        )
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: sizeConfig.height * 7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Q${index+1} : ${faq.question}'),
            Text('Answer : ${faq.answer}'),
          ],
        ),
      ),
    );
  }
}
