import 'package:andgarivara/General/view/IntroScreen.dart';
import 'package:andgarivara/General/view/signInScreen.dart';
import 'package:andgarivara/Utils/controller/SizeConfigController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  GetSizeConfig getSizeConfig = Get.find();

  double width;
  double height;

  bool firstLogin = true;

  double circle1 = 1;
  double circle2 = 1;
  double circle3 = 1;
  double circle4 = 1;

  Duration duration1 = Duration(milliseconds: 1200);
  Duration duration2 = Duration(milliseconds: 1000);
  Duration duration3 = Duration(milliseconds: 800);
  Duration duration4 = Duration(milliseconds: 500);

  double opacity = 0;

  double position = -1000;

  Color colorCircles = Color(0xffffffff);
  Color colorBackground = Color(0xffEBEBEB);
  Color colorButton = Color(0xff455A64);

  increaseRadius() {
    Future.delayed(Duration(milliseconds: 10), () {
      setState(() {
        circle1 = height * 370;
        circle2 = height * 650;
        circle3 = height * 1205;
        circle4 = height * 1418;
      });
    });
    Future.delayed(Duration(milliseconds: 1400), () {
      setState(() {
        position = width * 180;
        opacity = 1;
      });
    });
  }

  setInitialScreenSize(){

    getSizeConfig.setSize(
      (Get.width - (Get.mediaQuery.padding.left + Get.mediaQuery.padding.right)) / 1000,
      (Get.height - (Get.mediaQuery.padding.top + Get.mediaQuery.padding.bottom)) / 1000,
    );
    width = getSizeConfig.width.value;
    height = getSizeConfig.height.value;
}

  @override
  void setState(fn) {
    if(mounted){
      super.setState(fn);
    }
  }

  @override
  void initState() {
    if (!mounted) {
      return;
    } else {
      super.initState();
     // GetStorage().erase();
      String fLogin = GetStorage().read('firstTimeStart');
      firstLogin = fLogin.isNull ? true : false;
    }
  }

  @override
  Widget build(BuildContext context) {
    setInitialScreenSize();
    increaseRadius();
    return Scaffold(
      //backgroundColor: Color(0xffC8102E),
      backgroundColor: colorBackground,
      body: Stack(
        children: [
          backGroundCircle1(),
          backGroundCircle2(),
          backGroundCircle3(),
          backGroundCircle4(),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: width * 1000,
              ),
              AnimatedOpacity(
                duration: Duration(milliseconds: 1200),
                opacity: opacity,
                child: Container(
                  height: height * 260,
                  width: width * 800,
                  child: Image.asset(
                    'assets/images/appLogo/andgarivara_hero.gif',
                    // fit: BoxFit.cover,
                  ),
                ),
              ),
              InkWell(
                onTap: () => Get.offAll(
                    firstLogin ? IntroScreenState() : SignInScreen()),
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 1200),
                  opacity: opacity,
                  child: Stack(
                    children: [
                      Container(
                        width: width * 630,
                        height: height * 65,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(11111),
                            border: Border.all(color: colorButton)),
                        child: Center(
                          child: Text(
                            'Welcome',
                            style: TextStyle(
                                fontSize: getSizeConfig.getPixels(20),
                                color: colorButton,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 1,
                        child: Container(
                          height: height * 65,
                          width: height * 65,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: colorButton,
                              )),
                          child: Center(
                            child: Icon(
                              Icons.arrow_forward,
                              color: colorButton,
                              size: height * 40,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          // logo(),
          // btn(),
        ],
      ),
    );
  }

  backGroundCircle1() => Positioned(
        top: height * 20,
        left: -width * 270,
        child: AnimatedContainer(
          duration: duration1,
          height: circle1,
          width: circle1,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
              border: Border.all(color: colorCircles, width: width * 100)),
        ),
      );

  backGroundCircle2() => Positioned(
        top: -height * 160,
        left: -width * 500,
        child: AnimatedContainer(
          duration: duration2,
          height: circle2,
          width: circle2,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
              border: Border.all(color: colorCircles, width: width * 10)),
        ),
      );

  backGroundCircle3() => Positioned(
        top: -height * 608,
        left: -width * 1000,
        child: AnimatedContainer(
          duration: duration3,
          height: circle3,
          width: circle3,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
              border: Border.all(color: colorCircles, width: width * 10)),
        ),
      );

  backGroundCircle4() => Positioned(
        top: -height * 690,
        left: -width * 1070,
        child: AnimatedContainer(
          duration: duration4,
          height: circle4,
          width: circle4,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
              border: Border.all(color: colorCircles, width: width * 10)),
        ),
      );
}
