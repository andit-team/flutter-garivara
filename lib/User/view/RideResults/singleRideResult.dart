import 'file:///C:/Users/AndIT-15/StudioProjects/GariVara/lib/demo/VehicleResultModel.dart';
import 'package:andgarivara/User/view/RideResults/widgets/singleRideResultWidgets/amenitiesWidget.dart';
import 'package:andgarivara/User/view/RideResults/widgets/singleRideResultWidgets/carDetails.dart';
import 'package:andgarivara/User/view/RideResults/widgets/singleRideResultWidgets/description.dart';
import 'package:andgarivara/User/view/RideResults/widgets/singleRideResultWidgets/driverDetails.dart';
import 'package:andgarivara/User/view/RideResults/widgets/singleRideResultWidgets/ratingAndReview.dart';
import 'package:andgarivara/Utils/appConst.dart';
import 'package:andgarivara/Utils/controller/SizeConfigController.dart';
import 'package:andgarivara/Utils/stringResorces.dart';
import 'package:andgarivara/Utils/widgets/drawerlessAPpBar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'getQuoteScreen.dart';

class SingleRideResult extends StatefulWidget {
  @override
  _SingleRideResultState createState() => _SingleRideResultState();
}

class _SingleRideResultState extends State<SingleRideResult> {

  final GetSizeConfig sizeConfig = Get.find();
  double width;
  double height;
  VehicleResultModel resultModel;
  setInitialScreenSize() {
    width = sizeConfig.width.value;
    height = sizeConfig.height.value;
  }

  @override
  void initState() {
    resultModel = Get.arguments;
    super.initState();
    setInitialScreenSize();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DrawerLessAppBar(
        height: height,
        width: width,
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: sizeConfig.getPixels(20)),
              child: Column(
                children: [
                  SizedBox(height: height * 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: width * 600,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              resultModel.vehicleName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: sizeConfig.getPixels(28),
                                  fontWeight: FontWeight.bold,
                                  color: AppConst.textBlue
                              ),
                            ),
                            Text(
                              resultModel.vehicleLocation,
                              style: TextStyle(
                                  fontSize: sizeConfig.getPixels(14),
                                  color: AppConst.themeGrey
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Get.to(GetQuoteScreen());
                        },
                        borderRadius: BorderRadius.circular(width*30),
                        child: Container(
                          height: height*50,
                          width: width * 250,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(width*30),
                              border: Border.all(
                                  color: AppConst.appBlue,
                                  width: 2
                              )
                          ),
                          child: Center(
                            child: Text(
                              StringResources.singeRideResultGetQuote,
                              style: TextStyle(
                                  color: AppConst.appBlue,
                                  fontSize: sizeConfig.getPixels(16)
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: height * 15,),
                  Stack(
                    children: [
                      AspectRatio(
                        aspectRatio: 334/160,
                        child: CachedNetworkImage(
                          imageUrl: StringResources.demoImageBg,
                          fit: BoxFit.cover,
                        ),
                      ),
                      AspectRatio(
                        aspectRatio: 334/160,
                        child: Hero(
                          tag: resultModel.vehicleImage,
                          child: CachedNetworkImage(
                            imageUrl: resultModel.vehicleImage,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        left: 10,
                        child: Container(
                          height: height * 40,
                          width: width * 320,
                          decoration: BoxDecoration(
                              color: Color(0xffEFF4FF).withOpacity(.85),
                              borderRadius: BorderRadius.circular(width*20)
                          ),
                          child: Center(
                            child: Text(
                              '4.9 / 58 ratings',
                              style: TextStyle(
                                  fontSize: sizeConfig.getPixels(14),
                                  fontFamily: 'Roboto-R'
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: height * 5,),
                ],
              ),
            ),
            DescriptionWidget(),
            AmenitiesWidget(),
            DriverDetailsWidget(),
            CarDetailsWidget(),
            RatingAndReviewWidget(),
            SizedBox(height: sizeConfig.height * 20,)
          ],
        ),
      ),
    );
  }
}
