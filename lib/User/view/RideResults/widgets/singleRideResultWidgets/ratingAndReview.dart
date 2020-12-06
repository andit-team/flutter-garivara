import 'package:andgarivara/Utils/appConst.dart';
import 'package:andgarivara/Utils/controller/SizeConfigController.dart';
import 'package:andgarivara/Utils/stringResorces.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_rating_bar/flutter_simple_rating_bar.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

class RatingAndReviewWidget extends StatelessWidget {
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
              'Rating and Review',
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '4.93/5',
                        style: TextStyle(
                          fontSize: sizeConfig.getPixels(42),
                          letterSpacing: 1.5,
                          fontFamily: 'Roboto-M ',
                          color: AppConst.textBlue
                        ),
                      ),
                      SizedBox(width: sizeConfig.width * 15,),
                      Text(
                        '88 ratings',
                        style: TextStyle(
                          fontSize: sizeConfig.getPixels(16),
                          color: AppConst.textLight
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: sizeConfig.height * 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      RatingColumn(icon: Icons.verified, value: '95.0%', label: 'Acceptance'),
                      RatingColumn(icon: Icons.stars, value: '4.93', label: 'Rating'),
                      RatingColumn(icon: Icons.cancel_presentation, value: '2.2%', label: 'Cancellation'),
                    ],
                  ),
                  Divider(
                    height: sizeConfig.height * 30,
                    color: Color(0xffAFB1B7),
                    thickness: 1.5,
                  ),
                  Container(
                    width: sizeConfig.width * 800,
                    height: sizeConfig.height * 150,
                    child: Swiper(
                      pagination: SwiperPagination(),
                      itemCount: 3,
                      itemBuilder: (_,index){
                        return Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: sizeConfig.getPixels(25),
                                backgroundImage: CachedNetworkImageProvider(
                                  StringResources.reviewerImage
                                ),
                              ),
                              SizedBox(width: sizeConfig.width * 22,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Marina Karimova',
                                    style: TextStyle(
                                      fontSize: sizeConfig.getPixels(24),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      RatingBar(
                                        rating: 5,
                                        icon:Icon(Icons.star,size:15,color: Colors.grey,),
                                        starCount: 5,
                                        spacing: 0.0,
                                        size: 15,
                                        isIndicator: false,
                                        allowHalfRating: true,
                                        color: AppConst.appBlue,
                                      ),
                                      SizedBox(width: sizeConfig.width * 12,),
                                      Text(
                                        '5 out of 5',
                                        style: TextStyle(
                                          fontSize: sizeConfig.getPixels(14),
                                          color: AppConst.textLight
                                        ),
                                      ),
                                    ],
                                  ),
                                  RichText(
                                    text: WidgetSpan(
                                      child: Row(
                                        children: [
                                          Transform(
                                              transform: Matrix4.rotationY(math.pi),
                                            child: Icon(Icons.format_quote_rounded,color: Colors.transparent,)),
                                          Transform(
                                              transform: Matrix4.rotationY(math.pi),
                                            child: Icon(Icons.format_quote_rounded)),
                                        ],
                                      )
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    ),
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

class RatingColumn extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  RatingColumn({
    Key key,
    this.value,
    this.label,
    this.icon
  }) : super(key: key);

  final GetSizeConfig sizeConfig = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: AppConst.appGreen,
          size: sizeConfig.getPixels(25),
        ),
        SizedBox(height: sizeConfig.height * 6,),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xff282F39),
            fontSize: sizeConfig.getPixels(18)
          ),
        ),
        SizedBox(height: sizeConfig.height * 4,),
        Text(
          label,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppConst.textLight,
              fontSize: sizeConfig.getPixels(14)
          ),
        )
      ],
    );
  }
}
