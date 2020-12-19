import 'package:andgarivara_driver/General/model/introViewModel.dart';
import 'package:andgarivara_driver/General/view/signInScreen.dart';
import 'package:andgarivara_driver/Utils/appConst.dart';
import 'package:andgarivara_driver/Utils/controller/SizeConfigController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intro_slider/dot_animation_enum.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';


class IntroScreenState extends StatefulWidget {
  @override
  _IntroScreenStateState createState() => _IntroScreenStateState();
}

class _IntroScreenStateState extends State<IntroScreenState> {

  final GetSizeConfig getSizeConfig = Get.find();
  double height;
  double width;

  List<Slide> slides =  List();

  Function goToTab;

  TextStyle titleStyle;

  TextStyle descStyle;

  DateTime currentBackPressTime;

  @override
  void initState() {
    super.initState();
    descStyle = TextStyle(fontSize: getSizeConfig.getPixels(14));
    titleStyle = TextStyle(fontSize: getSizeConfig.getPixels(24),
        color: AppConst.themeRed
    );
    introItems.forEach((element) {
      slides.add(
         Slide(
          title: element.title,
          styleTitle: titleStyle,
          description: element.text1 + '\n\n' +  element.text2,
          styleDescription: descStyle,
          pathImage: element.image,
        ),
      );
    });
  }

  void onDonePress() {
    Get.offAll(SignInScreen());
    GetStorage().write('firstTimeStart', 'hala luai');
  }

  void onTabChangeCompleted(index) {
    // Index of current tab is focused
  }

  Widget renderNextBtn() {
    return Icon(
      Icons.navigate_next,
      color: Color(0xffffcc5c),
      size: 35.0,
    );
  }

  Widget renderDoneBtn() {
    return Icon(
      Icons.done,
      color: AppConst.greenColor,
    );
  }

  Widget renderSkipBtn() {
    return Icon(
      Icons.skip_next,
      color: Color(0xffffcc5c),
    );
  }

  List<Widget> renderListCustomTabs() {
    List<Widget> tabs = List();
    for (int i = 0; i < slides.length; i++) {
      Slide currentSlide = slides[i];
      tabs.add(Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: width * 30, vertical: height * 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: <Widget>[
                Container(
                  height: height * 300,
                  width: width * 1000,
                  child: Image.asset('assets/images/intro/bg.png'),
                ),
                //-------------------------------------------------item
                Container(
                  width: width * 1000,
                  height: height * 300,
                  child: Image.asset(
                      currentSlide.pathImage
                  ),
                ),
              ],
            ),
            SizedBox(height: height * 30,),
            Container(
              padding: EdgeInsets.only(
                  left: width * 100
              ),
              child: Text(
                currentSlide.title,
                style: TextStyle(fontSize: getSizeConfig.getPixels(24),
                    color: AppConst.themeRed
                ),
              ),
            ),
            SizedBox(height: height * 20,),
            Container(
              padding: EdgeInsets.only(
                  left: width * 100
              ),
              child: Text(
                  currentSlide.description,
                  style: TextStyle(fontSize: getSizeConfig.getPixels(14),)
              ),
            ),
            SizedBox(height: height * 100,),
          ],
        ),
      ));
    }
    return tabs;
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null || now.difference(currentBackPressTime) > Duration(seconds: 3)) {
      currentBackPressTime = now;
      Get.dialog(
          Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: width * 60, vertical: height * 30),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Exit ?',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(height: 5,),
                      Text(
                        'Are you sure you want to close the app',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                              color: Colors.grey,
                              width: .8
                          )
                      )
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () => Get.back(),
                          child: Container(
                            height: 60,
                            child: Center(
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                    fontSize: 22,
                                    color: Color(0xff2699FB),
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                          },
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                                border: Border(
                                    left: BorderSide(
                                        color: Colors.grey,
                                        width: .8
                                    )
                                )
                            ),
                            child: Center(
                              child: Text(
                                'Yes',
                                style: TextStyle(
                                    fontSize: 22,
                                    color: Color(0xff2699FB),
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          barrierDismissible: true
      );
      return Future.value(false);
    } else {
      return Future.value(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    height = getSizeConfig.height.value;
    width = getSizeConfig.width.value;
    return WillPopScope(
      onWillPop: onWillPop,
      child: IntroSlider(
        // List slides
        slides: this.slides,

        // Skip button
        renderSkipBtn: this.renderSkipBtn(),
        colorSkipBtn: AppConst.themeRed.withOpacity(.15),
        highlightColorSkipBtn: Color(0xffffcc5c),

        // Next button
        renderNextBtn: this.renderNextBtn(),

        // Done button
        renderDoneBtn: this.renderDoneBtn(),
        onDonePress: this.onDonePress,
        colorDoneBtn: AppConst.themeRed.withOpacity(.15),
        highlightColorDoneBtn: AppConst.themeRed,

        // Dot indicator
        colorDot: AppConst.themeRed,
        sizeDot: 13.0,
        typeDotAnimation: dotSliderAnimation.SIZE_TRANSITION,

        // Tabs
        listCustomTabs: this.renderListCustomTabs(),
        backgroundColorAllSlides: Colors.white,
        refFuncGoToTab: (refFunc) {
          this.goToTab = refFunc;
        },

        // Show or hide status bar
        shouldHideStatusBar: true,

        // On tab change completed
        onTabChangeCompleted: this.onTabChangeCompleted,
      ),
    );
  }
}