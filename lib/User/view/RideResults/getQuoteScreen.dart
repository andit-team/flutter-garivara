import 'package:andgarivara/User/view/RideResults/widgets/getQuotesWidgets/chooseFuelPackageTypeWidget.dart';
import 'package:andgarivara/User/view/RideResults/widgets/getQuotesWidgets/floatingWidget.dart';
import 'package:andgarivara/User/view/RideResults/widgets/getQuotesWidgets/journeyDurationWidget.dart';
import 'package:andgarivara/User/view/RideResults/widgets/getQuotesWidgets/journeyStatAndEndPointWidget.dart';
import 'package:andgarivara/User/view/RideResults/widgets/getQuotesWidgets/pickJourneyDateWidget.dart';
import 'package:andgarivara/User/view/RideResults/widgets/getQuotesWidgets/pickUpTimeWidget.dart';
import 'package:andgarivara/Utils/appConst.dart';
import 'package:andgarivara/Utils/controller/SizeConfigController.dart';
import 'package:andgarivara/Utils/stringResorces.dart';
import 'package:andgarivara/Utils/widgets/drawerlessAPpBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'costDetailsScreen.dart';

class GetQuoteScreen extends StatefulWidget {
  @override
  _GetQuoteScreenState createState() => _GetQuoteScreenState();
}

class _GetQuoteScreenState extends State<GetQuoteScreen> {
  final GetSizeConfig sizeConfig = Get.find();

  TextEditingController journeyDateController = TextEditingController();

  TextEditingController pickUpTimeController = TextEditingController();

  TextEditingController timeController = TextEditingController();
  TextEditingController durationTypeController = TextEditingController(text: 'Days');

  TextEditingController fuelTypeController = TextEditingController(text: 'Included Fuel');

  TextEditingController startPointController = TextEditingController();
  TextEditingController endPointController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: DrawerLessAppBar(
          height: sizeConfig.height.value,
          width: sizeConfig.width.value,
          widget: Padding(
            padding: EdgeInsets.symmetric(horizontal: sizeConfig.getPixels(20)),
            child: InkWell(
              onTap: (){
                Get.to(CostDetailsScreen());
              },
              borderRadius: BorderRadius.circular(sizeConfig.width * 25),
              child: Container(
                margin: EdgeInsets.only(top: sizeConfig.height * 20),
                width: sizeConfig.width * 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(sizeConfig.width * 25),
                  color: AppConst.appRed
                ),
                child: Center(
                  child: Text(
                    'Send Request',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: sizeConfig.getPixels(16)
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: sizeConfig.getPixels(20),vertical: sizeConfig.height * 15),
              child: SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      StringResources.getQuoteTitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: sizeConfig.getPixels(28),
                        fontWeight: FontWeight.bold,
                        color: AppConst.textBlue
                      ),
                    ),
                    SizedBox(height: sizeConfig.height * 10,),
                    Text(
                      StringResources.getQuoteSubtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: sizeConfig.getPixels(18),
                        color: AppConst.textLight
                      ),
                    ),
                    SizedBox(height: sizeConfig.height * 10,),
                    PickJourneyDateWidget(journeyDateController: journeyDateController),
                    PickUptimeWidget(pickUpTimeController: pickUpTimeController),
                    JourneyDurationWidget(timeController: timeController, durationTypeController: durationTypeController),
                    ChooseFuelPackageTypeWidget(fuelTypeController: fuelTypeController),
                    JourneyStatAndEndPointWidget(startPointController: startPointController, endPointController: endPointController),
                  ],
                ),
              ),
            ),
            FloatingWidget()
          ],
        ),
      ),
    );
  }
}
