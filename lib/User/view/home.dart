import 'package:andgarivara/User/view/homeScreen/homeScreen.dart';
import 'package:andgarivara/Utils/controller/SizeConfigController.dart';
import 'package:andgarivara/Utils/drawer/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeBody extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GetSizeConfig getSizeConfig = Get.find();

  final String assetName = 'assets/images/svg/Menu.svg';

  @override
  Widget build(BuildContext context) {
    final double width = getSizeConfig.width.value;
    final double height = getSizeConfig.height.value;
    Widget svgIcon = SvgPicture.asset(assetName, color: Color(0xffC8102E),width: width*60);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: _scaffoldKey,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
              onPressed: () => _scaffoldKey.currentState.openDrawer(),
              icon: svgIcon
          ),
        ),
        drawer: MyDrawer(
          height: height,
          width: width,
          scaffoldKey: _scaffoldKey,
          context: context,
        ),
        body: HomeScreen(),
      ),
    );
  }
}
