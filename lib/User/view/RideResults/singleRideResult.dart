import 'package:andgarivara/User/model/vehicleSearchResult.dart';
import 'package:andgarivara/User/repository/repoRideResult.dart';
import 'package:andgarivara/User/view/RideResults/widgets/singleRideResultWidgets/amenitiesWidget.dart';
import 'package:andgarivara/User/view/RideResults/widgets/singleRideResultWidgets/carDetails.dart';
import 'package:andgarivara/User/view/RideResults/widgets/singleRideResultWidgets/description.dart';
import 'package:andgarivara/User/view/RideResults/widgets/singleRideResultWidgets/driverDetails.dart';
import 'package:andgarivara/User/view/RideResults/widgets/singleRideResultWidgets/faqWidget.dart';
import 'package:andgarivara/User/view/RideResults/widgets/singleRideResultWidgets/ratingAndReview.dart';
import 'package:andgarivara/User/viewModel/viewModelRideResutl.dart';
import 'package:andgarivara/Utils/appConst.dart';
import 'package:andgarivara/Utils/controller/SizeConfigController.dart';
import 'package:andgarivara/Utils/stringResorces.dart';
import 'package:andgarivara/Utils/widgets/drawerlessAPpBar.dart';
import 'package:andgarivara/Utils/widgets/loader.dart';
import 'package:andgarivara/Utils/widgets/snackBar.dart';
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
  SearchVehicleModel resultModel;
  setInitialScreenSize() {
    width = sizeConfig.width.value;
    height = sizeConfig.height.value;
  }

  bool loading = true;

  @override
  void initState() {
    resultModel = Get.arguments;
    getData();
    super.initState();
    setInitialScreenSize();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DrawerLessAppBar(),
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
                            RichText(
                              text: TextSpan(
                                text: resultModel.brandTitle+': ',
                                style: TextStyle(
                                    fontSize: sizeConfig.getPixels(28),
                                    fontWeight: FontWeight.bold,
                                    color: AppConst.textBlue
                                ),
                                children: [TextSpan(
                                  text: resultModel.model
                                )]
                              ),
                            ),
                            Text(
                              resultModel.carAddress,
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
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(width*25),
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                StringResources.demoImageBg
                              ),
                              fit: BoxFit.cover
                            )
                          ),
                        ),
                      ),
                      AspectRatio(
                        aspectRatio: 334/160,
                        child: Hero(
                          tag: resultModel.thumbImage,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(width*25),
                              image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                  resultModel.thumbImage
                                ),
                                fit: BoxFit.cover
                              )
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        left: 10,
                        child: AnimatedCrossFade(
                          firstChild: SizedBox(),
                          secondChild: Container(
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
                          crossFadeState: loading ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                          duration: AppConst.duration
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: height * 5,),
                ],
              ),
            ),
            AnimatedCrossFade(
                firstChild: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Loader(),
                ),
                secondChild: Column(
                  children: [
                    ViewModelRideResult.vehicleData.value.description == null ? SizedBox() : DescriptionWidget(),
                    ViewModelRideResult.vehicleData.value.amenities == null ? SizedBox() : AmenitiesWidget(),
                    ViewModelRideResult.vehicleData.value.driverDetails == null ? SizedBox() : DriverDetailsWidget(),
                    CarDetailsWidget(),
                    RatingAndReviewWidget(),
                    ViewModelRideResult.vehicleData.value.serviceDetails == null ? SizedBox() : FaqWidget(),
                    SizedBox(height: sizeConfig.height * 20,)
                  ],
                ),
                crossFadeState: loading ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                duration: AppConst.duration
            )
          ],
        ),
      ),
    );
  }

  void getData() async{
    bool error = await RepoRideResult.getVehicleInfo(resultModel.id.oid);
    if(error){
      Get.back();
      Snack.bottom('Error', 'Could not fetch data');
    }else{
      setState(() {
        loading = false;
      });
    }
  }
}
