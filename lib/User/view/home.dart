import 'package:andgarivara_driver/User/view/homeScreen/homeScreen.dart';
import 'package:andgarivara_driver/Utils/appConst.dart';
import 'package:andgarivara_driver/Utils/controller/SizeConfigController.dart';
import 'package:andgarivara_driver/Utils/drawer/drawer.dart';
import 'package:andgarivara_driver/Utils/dummyPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final GetSizeConfig getSizeConfig = Get.find();

  final String assetName = 'assets/images/svg/Menu.svg';

  bool cupertinoValue = true;

  @override
  Widget build(BuildContext context) {
    final double width = getSizeConfig.width.value;
    final double height = getSizeConfig.height.value;
    Widget svgIcon = SvgPicture.asset(assetName,
        color: Color(0xffC8102E), width: width * 60);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: _scaffoldKey,
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          title: Center(
            child: Text(cupertinoValue?'Online':'Offline',
              style: TextStyle(
                  color: Colors.black,
                fontSize: getSizeConfig.getPixels(20),
              ),
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 4,
          leading: IconButton(
              onPressed: () => _scaffoldKey.currentState.openDrawer(),
              icon: svgIcon),
          actions: [
            Transform.scale(
              scale: 0.8,
              child: CupertinoSwitch(
                activeColor: AppConst.appRed,
                trackColor: AppConst.greyColor,
                value: cupertinoValue,
                onChanged: (bool value) {
                  setState(() {
                    cupertinoValue = value;
                  });
                },
              ),
            ),
          ],
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
