
import 'package:andgarivara_driver/General/view/IntroScreen.dart';
import 'package:andgarivara_driver/General/view/signInScreen.dart';
import 'package:andgarivara_driver/Utils/appConst.dart';
import 'package:andgarivara_driver/Utils/controller/SizeConfigController.dart';
import 'package:andgarivara_driver/Utils/controller/userLocation.dart';
import 'package:andgarivara_driver/Utils/widgets/wideRedButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  GetSizeConfig getSizeConfig = Get.find();

  double width;
  double height;

  bool firstLogin = true;

  final List<String> language = [
    'English',
    'Bangla'
  ];
  String selectedLanguage = 'English';

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
      getUserLocation();
      // GetStorage().erase();
      String fLogin = GetStorage().read('firstTimeStart');
      firstLogin = fLogin.isNull ? true : false;

    }
  }

  getUserLocation() async{
    GetUserLocation location = Get.find();
    Position position;
    position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    LatLng latLng;
    latLng = LatLng(position.latitude, position.longitude);
    location.updateLocation(latLng);
  }

  @override
  Widget build(BuildContext context) {
    setInitialScreenSize();
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/splashBG.png',
            height: Get.height,
            width: Get.width,
            fit: BoxFit.cover,
          ),
          Container(
            color: AppConst.appRed,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 100,vertical: height * 150),
            child: Column(
              children: [
                Center(
                  child: Card(
                    elevation: 5,
                    color: AppConst.appRed,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(width * 30)),
                    child: Container(
                      height: height * 200,
                      width: height * 200,
                      child: Container(
                          margin: EdgeInsets.all(height * 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(width * 30),
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/appLogo/app_logo_white.png'
                                  )
                              )
                          )
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height * 50,),
                AspectRatio(
                  aspectRatio: 289/72,
                  child: Image.asset(
                      'assets/images/appLogo/white.png'
                  ),
                ),
                SizedBox(height: height * 20,),
                Text(
                  'Safety and security is our concern',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      letterSpacing: 0.5
                  ),
                ),
                Spacer(),
                WideRedButton(
                  label: 'Go!',
                  color: Colors.white,
                  onPressed: (){
                    Get.offAll(firstLogin ? IntroScreenState() : SignInScreen());
                  },
                ),
                SizedBox(height: height * 15,),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Language : ',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16
                      ),
                    ),
                    PopupMenuButton(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            selectedLanguage,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(width: width * 10,),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 16,
                          )
                        ],
                      ),
                      onSelected: (value){
                        setState(() {selectedLanguage=value;});
                      },
                      itemBuilder: (_)=> language.map((e) => PopupMenuItem(
                        value: e,
                        child: Text(
                          e,
                          style: TextStyle(
                              color: AppConst.textLight,
                              fontSize: 16
                          ),
                        ),
                      )).toList(),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
