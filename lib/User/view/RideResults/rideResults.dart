import 'package:andgarivara/User/model/vehicleSearchResult.dart';
import 'package:andgarivara/User/repository/repoRideResult.dart';
import 'package:andgarivara/User/view/RideResults/singleRideResult.dart';
import 'package:andgarivara/User/viewModel/viewModelRideResutl.dart';
import 'package:andgarivara/Utils/appConst.dart';
import 'package:andgarivara/Utils/controller/SizeConfigController.dart';
import 'package:andgarivara/Utils/widgets/drawerlessAPpBar.dart';
import 'package:andgarivara/Utils/widgets/loader.dart';
import 'package:andgarivara/Utils/widgets/overScroll.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RideResults extends StatefulWidget {
  @override
  _RideResultsState createState() => _RideResultsState();
}

class _RideResultsState extends State<RideResults> {
  final GetSizeConfig getSizeConfig = Get.find();

  double width;
  double height;

  String serviceType;
  String vehicleType;

  bool loader = true;

  LatLng pickUp;

  @override
  void initState() {
    serviceType = Get.arguments[0];
    vehicleType = Get.arguments[1];
    pickUp = Get.arguments[2];
    width = getSizeConfig.width.value;
    height = getSizeConfig.height.value;
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //extendBodyBehindAppBar: true,
      appBar: DrawerLessAppBar(),
      body: loader ? Loader() : Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 70),
        child: OverScroll(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: height * 2),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Vehicle Search Result',
                    style: TextStyle(
                        fontSize: getSizeConfig.width * 60,
                        color: Colors.black),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: height * 5),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${ViewModelRideResult.rideResults.length} Vehicles found',
                    style: TextStyle(
                        fontSize: getSizeConfig.width * 40, color: Colors.grey),
                  ),
                ),
              ),
              ViewModelRideResult.rideResults.length > 0 ? Expanded(
                child: ListView.builder(
                  // physics: ScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: ViewModelRideResult.rideResults.length,
                  itemBuilder: (context, index) {
                    SearchVehicleModel item = ViewModelRideResult.rideResults[index];
                    Color color;
                    if (index % 2 == 0) {
                      color = AppConst.containerBg;
                    } else {
                      color = Color(0xffffffff);
                    }
                    return GestureDetector(
                      onTap: ()=> Get.to(SingleRideResult(),arguments: item),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: height * 7),
                        child: Container(
                          decoration: BoxDecoration(
                            color: color,
                            border: index % 2 == 0 ? Border.all(color: Colors.transparent) : Border.all(color: AppConst.containerBg,width: 2),
                            borderRadius: BorderRadius.circular(width*20)
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: width * 20, vertical: height * 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  flex: 6,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${item.brandTitle}: ${item.model}',
                                        maxLines: 1,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: getSizeConfig.getPixels(18)
                                        )
                                      ),
                                      SizedBox(
                                        height: height * 10,
                                      ),Text(
                                        '${item.carAddress}',
                                        maxLines: 2,
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(0.8),
                                          fontSize: getSizeConfig.getPixels(14)
                                        )
                                      ),
                                      SizedBox(
                                        height: height * 10,
                                      ),
                                      RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                                            text: 'TK ${item.serviceDetails.perDayBodyRent}',
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: getSizeConfig
                                                    .getPixels(16)),
                                          ),
                                          TextSpan(
                                            text: '/per day',
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: getSizeConfig
                                                    .getPixels(14)),
                                          ),
                                        ]),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Hero(
                                    tag: item.thumbImage,
                                    child: Container(
                                      height: height * 120,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(width*20),
                                        image: DecorationImage(
                                          image: CachedNetworkImageProvider(
                                            item.thumbImage,
                                          ),
                                          fit: BoxFit.cover,
                                        )
                                      ),
                                    )
                                  )
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ) : Image.asset(
                'assets/images/emptyResult/no_ride_found.jpg',
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getData() async{

    await RepoRideResult.getRideResult(serviceType, vehicleType, pickUp);

    setState(() {
      loader = false;
    });
  }
}