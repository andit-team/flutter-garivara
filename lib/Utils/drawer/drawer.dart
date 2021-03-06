import 'package:andgarivara/User/view/drawerScreens/favouritePlacesScreen.dart';
import 'package:andgarivara/User/view/drawerScreens/myRidesScreen.dart';
import 'package:andgarivara/User/view/drawerScreens/newsAndOffersScreen.dart';
import 'package:andgarivara/User/view/drawerScreens/notificationsScreen.dart';
import 'package:andgarivara/User/view/drawerScreens/profileScreen.dart';
import 'package:andgarivara/User/view/drawerScreens/referAFriendScreen.dart';
import 'package:andgarivara/User/view/drawerScreens/supportScreen.dart';
import 'package:andgarivara/User/viewModel/userData.dart';
import 'package:andgarivara/Utils/appConst.dart';
import 'package:andgarivara/Utils/controller/SizeConfigController.dart';
import 'package:andgarivara/Utils/drawer/widget/logoutDialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDrawer extends StatelessWidget {
  final double height;
  final double width;
  final context;
  final scaffoldKey;
  MyDrawer({
    @required this.context,
    @required this.width,
    @required this.height,
    @required this.scaffoldKey
  });


  final GetSizeConfig getSizeConfig = Get.find();


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: width*800,
        child: Drawer(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Obx(()=>DrawerHeader(
                    padding: EdgeInsets.only(right: 16),
                    child: Row(
                      children: [
                        SizedBox(width: 20,),
                        Expanded(
                          flex: 3,
                          child: CircleAvatar(
                            radius: width * 110,
                            backgroundColor: Color(0xff2699FB),
                            child: CircleAvatar(
                                radius: width * 100,
                                backgroundImage: ViewModelUserData.userData.value.profilePic.isNullOrBlank ?
                                AssetImage('assets/images/appLogo/app_logo.png') :
                                CachedNetworkImageProvider(ViewModelUserData.userData.value.profilePic)
                            ),
                          ),
                        ),
                        SizedBox(width: width * 15,),
                        Expanded(
                          flex: 7,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                child: Text(
                                    ViewModelUserData.userData.value.firstName[0].capitalize + '. ' + ViewModelUserData.userData.value.lastName.capitalize,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: getSizeConfig.getPixels(20),
                                      color: AppConst.textBlue,
                                    )
                                ),
                              ),
                              SizedBox(height: height * 15,),
                              Text(
                                  '+88' + ViewModelUserData.userData.value.phoneNo,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: getSizeConfig.getPixels(18),
                                    color: AppConst.textLight,
                                  )
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: (){
                                      scaffoldKey.currentState.openEndDrawer();
                                      Get.to(ProfileScreen());
                                    },
                                    child: Text(
                                        'View profile',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: getSizeConfig.getPixels(14),
                                            color: AppConst.appBlue,
                                            decoration: TextDecoration.underline
                                        )
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            GestureDetector(
                              onTap: () => scaffoldKey.currentState.openEndDrawer(),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: height * 10
                                ),
                                child: Icon(
                                  Icons.close,
                                  color: Color(0xff7C7D80),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
                  for(var item in drawerItems)
                    drawerItem(item.navigation, item.icon, item.title),
                  ListTile(
                    onTap: () {
                      scaffoldKey.currentState.openEndDrawer();
                      Get.dialog(LogoutDialog());
                    },
                    leading: Icon(
                      Icons.power_settings_new,
                      color: AppConst.appBlue,
                    ),
                    title: Text(
                      'Logout',
                        style: TextStyle(
                          fontSize: getSizeConfig.getPixels(16),
                          color: Colors.black,
                        )
                    ),
                  ),
                  Divider(color: Colors.black,)
                ],
              ),
            )
        ),
      ),
    );
  }

  drawerItem(navigation, icon, title) => ListTile(
    onTap: (){
      if(navigation != null){
        scaffoldKey.currentState.openEndDrawer();
        Get.to(navigation);
      }else{
        Get.snackbar('Unfortunate', 'Screen not ready');
      }
    },
    leading: Icon(
      icon,
      color: AppConst.appBlue,
    ),
    title: Text(
      title,
        style: TextStyle(
          fontSize: getSizeConfig.getPixels(16),
          color: Colors.black,
        )
    ),
    trailing: Icon(
        Icons.navigate_next
    ),
  );

}

class DrawerItems{
  Widget navigation;
  IconData icon;
  String title;

  DrawerItems({this.navigation,this.icon,this.title});
}

final List<DrawerItems> drawerItems = [
  DrawerItems(
    title: 'Notifications',
    icon: Icons.notifications,
    navigation: NotificationsScreen()
  ),
  DrawerItems(
    title: 'Settings',
    icon: Icons.settings
  ),
  DrawerItems(
    title: 'Refer a friend',
    icon: Icons.person,
    navigation: ReferAFriendScreen()
  ),
  DrawerItems(
    title: 'Payment',
    icon: Icons.account_balance_wallet
  ),
  DrawerItems(
    title: 'AndGarivara Support',
    icon: Icons.contact_support,
    navigation: SupportScreen()
  ),
  DrawerItems(
    title: 'My Rides',
    icon: Icons.car_repair,
    navigation: MyRidesScreen()
  ),
  DrawerItems(
    title: 'My favourite place',
    icon: Icons.favorite,
    navigation: MyFavouritePlacesScreen()
  ),
  DrawerItems(
    title: 'News and offers',
    icon: Icons.new_releases,
    navigation: NewsAndOffersScreen()
  ),
];