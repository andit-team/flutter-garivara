import 'package:andgarivara/Utils/appConst.dart';
import 'package:andgarivara/Utils/controller/SizeConfigController.dart';
import 'package:andgarivara/Utils/stringResorces.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_rating_bar/flutter_simple_rating_bar.dart';
import 'package:get/get.dart';

class DriverDetailsWidget extends StatelessWidget {
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
              'Driver Details',
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
              child: Row(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        backgroundImage: CachedNetworkImageProvider(
                          StringResources.driverImage
                        ),
                        radius: sizeConfig.getPixels(40),
                      ),
                      Icon(
                        Icons.verified_user,
                        color: AppConst.greenColor,
                        size: sizeConfig.getPixels(30),
                      )
                    ],
                  ),
                  SizedBox(width: sizeConfig.width * 20,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'Karim Molla',
                        style: TextStyle(
                          fontSize: sizeConfig.getPixels(20),
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(height: sizeConfig.height * 7,),
                      Row(
                        children: [
                          RatingBar(
                            rating: 3,
                            icon:Icon(Icons.star,size:20,color: Colors.grey,),
                            starCount: 5,
                            spacing: 0.0,
                            size: 20,
                            isIndicator: false,
                            allowHalfRating: true,
                            color: AppConst.appBlue,
                          ),
                          SizedBox(width: sizeConfig.width * 20,),
                          Text(
                            '(36 Rating)',
                            style: TextStyle(
                              fontSize: sizeConfig.getPixels(14),
                              color: AppConst.textLight
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: sizeConfig.height * 5,),
                      Text(
                        '(36 Rating)',
                        style: TextStyle(
                            fontSize: sizeConfig.getPixels(16),
                            color: AppConst.textBlue
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
