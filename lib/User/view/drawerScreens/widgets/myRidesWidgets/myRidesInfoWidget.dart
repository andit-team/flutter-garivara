import 'package:andgarivara/Utils/appConst.dart';
import 'package:andgarivara/Utils/controller/SizeConfigController.dart';
import 'package:andgarivara/Utils/stringResorces.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyRidesInfoWidget extends StatelessWidget {
  final GetSizeConfig sizeConfig = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: sizeConfig.height * 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '12 Dec 2020',
            style: TextStyle(
              color: AppConst.textLight,
              fontSize: sizeConfig.getPixels(16)
            ),
          ),
          SizedBox(height: sizeConfig.height * 10,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(
                      StringResources.driverImage
                    ),
                    radius: sizeConfig.getPixels(30),
                  ),
                  Icon(
                    Icons.verified_user_rounded,
                    color: AppConst.appGreen,
                  )
                ],
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(sizeConfig.width * 20)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Rooster Coou',
                                style: TextStyle(
                                  color: AppConst.textBlue,
                                  fontSize: sizeConfig.getPixels(18),
                                  fontFamily: 'Roboto-M'
                                ),
                              ),
                              Text(
                                'BDT 5478.54',
                                style: TextStyle(
                                    color: AppConst.textBlue,
                                    fontSize: sizeConfig.getPixels(16)
                                ),
                              ),
                            ],
                          ),
                          ListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            leading: Icon(
                              Icons.my_location_sharp,
                              color: AppConst.appRed,
                            ),
                            title: Text(
                              '32, Choto mirjapur ahsan ahmeed road',
                              maxLines: 1,
                              style: TextStyle(
                                color: AppConst.textBlue,
                                fontSize: sizeConfig.getPixels(16)
                              ),
                            ),
                            subtitle: Text(
                              '14 Dec 2020 - 10:00AM',
                              style: TextStyle(
                                color: AppConst.textBlue
                              ),
                            ),
                          ),
                          ListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            leading: Icon(
                              Icons.location_on_rounded,
                              color: AppConst.appRed,
                            ),
                            title: Text(
                              '32, Choto mirjapur ahsan ahmeed road',
                              maxLines: 1,
                              style: TextStyle(
                                color: AppConst.textBlue,
                                fontSize: sizeConfig.getPixels(16)
                              ),
                            ),
                            subtitle: Text(
                              '14 Dec 2020 - 10:00AM',
                              style: TextStyle(
                                color: AppConst.textBlue
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
