import 'package:andgarivara/User/repository/repoRideResult.dart';
import 'package:andgarivara/User/view/RideResults/widgets/getQuotesWidgets/chooseFuelPackageTypeWidget.dart';
import 'package:andgarivara/User/view/RideResults/widgets/getQuotesWidgets/floatingWidget.dart';
import 'package:andgarivara/User/view/RideResults/widgets/getQuotesWidgets/journeyDurationWidget.dart';
import 'package:andgarivara/User/view/RideResults/widgets/getQuotesWidgets/journeyStatAndEndPointWidget.dart';
import 'package:andgarivara/User/view/RideResults/widgets/getQuotesWidgets/pickJourneyDateWidget.dart';
import 'package:andgarivara/User/view/RideResults/widgets/getQuotesWidgets/pickUpTimeWidget.dart';
import 'package:andgarivara/User/viewModel/viewModelRideResutl.dart';
import 'package:andgarivara/Utils/appConst.dart';
import 'package:andgarivara/Utils/controller/SizeConfigController.dart';
import 'package:andgarivara/Utils/stringResorces.dart';
import 'package:andgarivara/Utils/widgets/basicHeaderWidget.dart';
import 'package:andgarivara/Utils/widgets/drawerlessAPpBar.dart';
import 'package:andgarivara/Utils/widgets/snackBar.dart';
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

  TextEditingController fuelTypeController = TextEditingController(text: 'Included');

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: DrawerLessAppBar(
          widget: Padding(
            padding: EdgeInsets.symmetric(horizontal: sizeConfig.getPixels(20)),
            child: InkWell(
              onTap: () async{
                if(journeyDateController.text.isEmpty){
                  Snack.top('Wait!', 'Please choose a date');
                }else if(pickUpTimeController.text.isEmpty){
                  Snack.top('Wait!', 'Please choose a pick up time');
                }else if(timeController.text.isEmpty){
                  Snack.top('Wait!', 'Please choose a time');
                }else if(fuelTypeController.text.isEmpty){
                  Snack.top('Wait!', 'Please choose a fuel type');
                }else{
                  await RepoRideResult.getQuote(ViewModelRideResult.vehicleData.value.id.oid, journeyDateController.text, pickUpTimeController.text, timeController.text, durationTypeController.text.toLowerCase(), fuelTypeController.text);
                  // Get.to(CostDetailsScreen());
                }
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
                    SizedBox(height: 20,),
                    BasicHeaderWidget(
                      title: StringResources.getQuoteTitle,
                      subtitle: StringResources.getQuoteSubtitle,
                    ),
                    PickJourneyDateWidget(journeyDateController: journeyDateController),
                    PickUptimeWidget(pickUpTimeController: pickUpTimeController),
                    JourneyDurationWidget(timeController: timeController, durationTypeController: durationTypeController),
                    ChooseFuelPackageTypeWidget(fuelTypeController: fuelTypeController),
                    JourneyStatAndEndPointWidget(),
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
