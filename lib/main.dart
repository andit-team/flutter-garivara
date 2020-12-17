import 'package:andgarivara/General/view/splashScreen.dart';
import 'package:andgarivara/Utils/appConst.dart';
import 'package:andgarivara/Utils/controller/SizeConfigController.dart';
import 'package:andgarivara/Utils/controller/userLocation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

import 'Utils/controller/rideStatusController.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await DotEnv().load('.env');
  runApp(InitiateApp());
}

class InitiateApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    Get.put(GetSizeConfig());
    Get.put(GetUserLocation());
    Get.put(GetRideStatusController());

    final newTextTheme = Theme.of(context).textTheme.apply(
      bodyColor: Colors.black,
      displayColor: Colors.black,
    );

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.cupertino,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Roboto-R',
        textTheme: newTextTheme,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          elevation: 0,
          color: Colors.transparent,
          iconTheme: IconThemeData(
            color: Colors.black
          )
        )
      ),
      home: SplashScreen(),
    );
  }
}