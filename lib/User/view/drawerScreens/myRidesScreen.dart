import 'package:andgarivara/User/view/drawerScreens/widgets/myRidesWidgets/myRidesInfoWidget.dart';
import 'package:andgarivara/Utils/appConst.dart';
import 'package:andgarivara/Utils/controller/SizeConfigController.dart';
import 'package:andgarivara/Utils/widgets/drawerlessAPpBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyRidesScreen extends StatelessWidget {
  final GetSizeConfig sizeConfig = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DrawerLessAppBar(),
      body: DefaultTabController(
        length: 3,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: sizeConfig.getPixels(20)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey
                    )
                  )
                ),
                child: TabBar(
                  indicatorColor: AppConst.textBlue,
                  labelColor: AppConst.textBlue,
                  unselectedLabelColor: AppConst.textLight,
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold
                  ),
                  unselectedLabelStyle: TextStyle(
                    fontWeight: FontWeight.normal
                  ),
                  tabs: [
                    Tab(child: Text('Completed'),),
                    Tab(child: Text('Upcoming'),),
                    Tab(child: Text('Cancelled'),),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: 10,
                      itemBuilder: (_,index){
                        return MyRidesInfoWidget();
                      },
                    ),
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: 10,
                      itemBuilder: (_,index){
                        return MyRidesInfoWidget();
                      },
                    ),
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: 10,
                      itemBuilder: (_,index){
                        return MyRidesInfoWidget();
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}