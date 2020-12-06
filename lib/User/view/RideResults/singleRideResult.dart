import 'package:andgarivara/Utils/controller/SizeConfigController.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SingleRideResult extends StatefulWidget {
  final String vehicleUrl;
  SingleRideResult({this.vehicleUrl});
  @override
  _SingleRideResultState createState() => _SingleRideResultState();
}

class _SingleRideResultState extends State<SingleRideResult> {

  final GetSizeConfig getSizeConfig = Get.find();
  double width;
  double height;

  setInitialScreenSize() {
    width = getSizeConfig.width.value;
    height = getSizeConfig.height.value;
  }

  @override
  void initState() {
    super.initState();
    setInitialScreenSize();
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Hero(
        tag: widget.vehicleUrl,
        child: CachedNetworkImage(
            imageUrl: widget.vehicleUrl,
            width: width * 260,
            height: height * 85),
      ),
    );
  }
}
