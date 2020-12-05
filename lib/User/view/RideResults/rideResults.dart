import 'package:andgarivara/User/model/VehicleResultModel.dart';
import 'package:andgarivara/Utils/controller/SizeConfigController.dart';
import 'package:andgarivara/Utils/widgets/drawerlessAPpBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get.dart';

class RideResults extends StatelessWidget {

  final GetSizeConfig getSizeConfig = Get.find();
  double width;
  double height;

  setInitialScreenSize() {
    width = getSizeConfig.width.value;
    height = getSizeConfig.height.value;
  }

  @override
  Widget build(BuildContext context) {
    setInitialScreenSize();
    return Scaffold(
      //extendBodyBehindAppBar: true,
      appBar: DrawerlessAppBar(
        width: width,
        height: height,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width*70),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric( vertical: height * 2),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Vehicle Search Result',
                    style: TextStyle(
                        fontSize: getSizeConfig.width * 60,
                        color: Colors.black
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric( vertical: height * 5),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '69 Vehicles found',
                    style: TextStyle(
                        fontSize: getSizeConfig.width * 40,
                        color: Colors.grey
                    ),
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: VehicleResultModel.vehicleResultModelData.length,
                  itemBuilder: (context, index){
                  var item = VehicleResultModel.vehicleResultModelData[index];
                    return Padding(
                      padding:EdgeInsets.symmetric(vertical: height*7),
                      child: Container(
                        color: Color(0xffE3E8F2),
                        child: Padding(
                          padding: EdgeInsets.all(width*35),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('${item.vehicleName}',style: TextStyle(color: Colors.black,fontSize: getSizeConfig.getPixels(18))),
                                  Text('${item.vehicleLocation}',style: TextStyle(color: Colors.black,fontSize: getSizeConfig.getPixels(14))),
                                  SizedBox(height: height*20,),
                                  RichText(
                                      text: TextSpan(
                                    children: [
                                      TextSpan(text: 'TK ${item.amount}',style: TextStyle(color: Colors.blue,fontSize: getSizeConfig.getPixels(16)),),
                                      TextSpan(text: '/per day',style: TextStyle(color: Colors.blue,fontSize: getSizeConfig.getPixels(14)),),
                                    ]
                                  ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [],
                              ),
                              Text('q221'),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
              ),
            ],
          ),
        ),
      ),
    );
  }


}
