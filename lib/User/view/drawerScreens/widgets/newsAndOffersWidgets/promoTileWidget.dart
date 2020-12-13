import 'package:andgarivara/Utils/controller/SizeConfigController.dart';
import 'package:andgarivara/demo/demoData.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PromoTileWidget extends StatelessWidget {
  final DemoPromotion promo;
  PromoTileWidget({this.promo});
  final GetSizeConfig sizeConfig = Get.find();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: sizeConfig.height * 15),
      child: Stack(
        children: [
          Card(
            elevation: 10,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(sizeConfig.width * 25)),
            child: CachedNetworkImage(
              imageUrl: promo.image,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: sizeConfig.height * 20,
            left: sizeConfig.width * 30,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: sizeConfig.width * 25,vertical: sizeConfig.height * 7),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(sizeConfig.width *20),
                color: Colors.grey.withOpacity(.6),
              ),
              child: Center(
                child: Text(
                  promo.code,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
