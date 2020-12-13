import 'package:andgarivara/Utils/appConst.dart';
import 'package:andgarivara/Utils/controller/SizeConfigController.dart';
import 'package:andgarivara/Utils/controller/rideStatusController.dart';
import 'package:andgarivara/Utils/enum.dart';
import 'package:andgarivara/Utils/stringResorces.dart';
import 'package:andgarivara/Utils/widgets/basicHeaderWidget.dart';
import 'package:andgarivara/Utils/widgets/drawerlessAPpBar.dart';
import 'package:andgarivara/Utils/widgets/lightTextField.dart';
import 'package:andgarivara/Utils/widgets/wideRedButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_rating_bar/flutter_simple_rating_bar.dart';
import 'package:get/get.dart';

class ReviewRideScreen extends StatelessWidget {
  final GetSizeConfig sizeConfig = Get.find();
  final TextEditingController editingController = TextEditingController();
  final TextEditingController editingController2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: DrawerLessAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: sizeConfig.getPixels(20)),
        child: Column(
          children: [
            BasicHeaderWidget(
              title: StringResources.rideReviewTitle,
              subtitle: StringResources.rideReviewSubtitle,
            ),
            Center(
              child: RatingBar(
                rating: 5,
                icon:Icon(Icons.star,size:35,color: Colors.grey,),
                starCount: 5,
                spacing: 5.0,
                size: 35,
                isIndicator: false,
                allowHalfRating: true,
                color: AppConst.appBlue,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: sizeConfig.height * 15),
              decoration: BoxDecoration(
                color: AppConst.containerBg,
                borderRadius: BorderRadius.circular(sizeConfig.width * 20),
              ),
              child: LightTextField(
                hintText: 'Say something...',
                controller: editingController,
                minLines: 4,
                hintColor: AppConst.textBlue,
              ),
            ),
            BasicHeaderWidget(
              title: StringResources.rideReviewDriverTitle,
              subtitle: StringResources.rideReviewDriverSubtitle,
            ),
            Center(
              child: RatingBar(
                rating: 5,
                icon:Icon(Icons.star,size:35,color: Colors.grey,),
                starCount: 5,
                spacing: 5.0,
                size: 35,
                isIndicator: false,
                allowHalfRating: true,
                color: AppConst.appBlue,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: sizeConfig.height * 15),
              decoration: BoxDecoration(
                color: AppConst.containerBg,
                borderRadius: BorderRadius.circular(sizeConfig.width * 20),
              ),
              child: LightTextField(
                hintText: 'Say something...',
                controller: editingController2,
                minLines: 4,
                hintColor: AppConst.textBlue,
              ),
            ),
            SizedBox(height: sizeConfig.height * 40,),
            WideRedButton(
              onPressed: (){
                GetRideStatusController gg = Get.find();
                gg.updateStatus(RideStatus.NONE);
                Get.back();
              },
              label: 'Submit',
            )
          ],
        ),
      ),
    );
  }
}
