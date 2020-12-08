import 'package:andgarivara/User/model/VehicleResultModel.dart';
import 'package:andgarivara/User/view/RideResults/singleRideResult.dart';
import 'package:andgarivara/Utils/controller/SizeConfigController.dart';
import 'package:andgarivara/Utils/widgets/drawerlessAPpBar.dart';
import 'package:andgarivara/Utils/widgets/overScroll.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get.dart';

class RideResults extends StatelessWidget {
  final GetSizeConfig getSizeConfig = Get.find();

  @override
  Widget build(BuildContext context) {

    double width = getSizeConfig.width.value;
    double height = getSizeConfig.height.value;
    return Scaffold(
      //extendBodyBehindAppBar: true,
      appBar: DrawerLessAppBar(
        width: width,
        height: height,
      ),
      body: Padding(
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
                    '69 Vehicles found',
                    style: TextStyle(
                        fontSize: getSizeConfig.width * 40, color: Colors.grey),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  // physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: VehicleResultModel.vehicleResultModelData.length,
                  itemBuilder: (context, index) {
                    VehicleResultModel item = VehicleResultModel.vehicleResultModelData[index];
                    Color color;
                    if (index % 2 == 0) {
                      color = Color(0xffE3E8F2);
                    } else {
                      color = Color(0xffffffff);
                    }
                    return GestureDetector(
                      onTap: ()=> Get.to(SingleRideResult(),arguments: item),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: height * 7),
                        child: Container(
                          color: color,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: width * 20, vertical: height * 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('${item.vehicleName}',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize:
                                                getSizeConfig.getPixels(18))),
                                    Text('${item.vehicleLocation}',
                                        style: TextStyle(
                                            color: Colors.black.withOpacity(0.8),
                                            fontSize:
                                                getSizeConfig.getPixels(14))),
                                    SizedBox(
                                      height: height * 20,
                                    ),
                                    Row(
                                      children: [
                                        RichText(
                                          text: TextSpan(children: [
                                            TextSpan(
                                              text: 'TK ${item.amount}',
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
                                        SizedBox(
                                          width: width * 70,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons
                                                  .supervised_user_circle_outlined,
                                              size: getSizeConfig.getPixels(18),
                                            ),
                                            SizedBox(
                                              width: width * 10,
                                            ),
                                            Text('${item.minCap}-',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: getSizeConfig
                                                        .getPixels(12))),
                                            Text('${item.maxCap}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: getSizeConfig
                                                        .getPixels(12))),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Hero(
                                  tag: item.vehicleImage,
                                    child: CachedNetworkImage(
                                        imageUrl: item.vehicleImage,
                                        width: width * 260,
                                        height: height * 85),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
