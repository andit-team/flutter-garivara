import 'package:andgarivara/General/view/signInScreen.dart';
import 'package:andgarivara/User/view/RideResults/rideResults.dart';
import 'package:andgarivara/Utils/controller/SizeConfigController.dart';
import 'package:andgarivara/dummyPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

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


  GetSizeConfig getSizeConfig = Get.find();

  GetStorage localStorage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: width*800,
        child: Drawer(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Card(
                    elevation: 4,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: width * 10),
                      height: height * 150,
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: width * 110,
                            backgroundColor: Color(0xff2699FB),
                            child: CircleAvatar(
                              radius: width * 100,
                              backgroundImage: NetworkImage('https://4.bp.blogspot.com/-5BCTUS-qq9Y/T64C44H7nHI/AAAAAAAACuk/kjNsZ0B8fIc/s1600/car+image+gallery-6.jpg'),
                            ),
                          ),
                          SizedBox(width: width * 40,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Welcome To',
                                overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: getSizeConfig.getPixels(20),
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  )
                              ),
                              Container(
                                width:  width * 350,
                                child: Text(
                                 'Andgarivara',
                                    style: TextStyle(
                                      fontSize: getSizeConfig.getPixels(20),
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    )
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
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
                    ),
                  ),
                  for(var item in drawerItems)
                    drawerItem(item.navigation, item.icon, item.title),
                  ListTile(
                    onTap: () {
                      scaffoldKey.currentState.openEndDrawer();
                      showCupertinoDialog(
                          barrierDismissible: true,
                          context: context,
                          builder: (context) => Dialog(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: width*20,vertical: height*20),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Are you sure you want to\nLogout?',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: getSizeConfig.getPixels(20),
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    )
                                  ),
                                  SizedBox(height: height * 40,),
                                  FlatButton(
                                    onPressed: (){
                                      localStorage.erase();
                                      Get.to(SignInScreen());
                                    },
                                    color: Color(0xffC8102E),
                                    child: Container(
                                      height: height * 65,
                                      width: double.infinity,
                                      child: Center(
                                        child: Text(
                                          'Logout',
                                            style: TextStyle(
                                              fontSize: getSizeConfig.getPixels(20),
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            )
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: height * 20,),
                                  FlatButton(
                                    onPressed: (){
                                      Get.back();
                                    },
                                    color: Colors.black,
                                    child: Container(
                                      height: height * 65,
                                      width: double.infinity,
                                      child: Center(
                                        child: Text(
                                          'Cancel',
                                            style: TextStyle(
                                              fontSize: getSizeConfig.getPixels(20),
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            )
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                      );
                    },
                    leading: Icon(
                      Icons.power_settings_new,
                      color: Color(0xff2699FB),
                      size: height * 35,
                    ),
                    title: Text(
                      'Logout',
                        style: TextStyle(
                          fontSize: getSizeConfig.getPixels(20),
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
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

  drawerItem(navigation, icon, title) => Column(
    children: [
      ListTile(
        onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => navigation)),
        leading: Icon(
          icon,
          color: Color(0xff2699FB),
        ),
        title: Text(
          title,
            style: TextStyle(
              fontSize: getSizeConfig.getPixels(20),
              color: Colors.black,
              fontWeight: FontWeight.bold,
            )
        ),
        trailing: Icon(
            Icons.navigate_next
        ),
      ),
      //title=='App feedback'?SizedBox(height: height * 50):Container(),
      title=='App feedback'?Divider(color: Colors.black,):title=='Version 1.0.0'?Divider(color: Colors.black):Container(),

    ],
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
      navigation: RideResults(),
      icon: Icons.search_sharp,
      title: 'Ride Search'
  ),
  DrawerItems(
      navigation: DummyPage(),
      icon: Icons.info_outline,
      title: 'Version 1.0.0'
  ),
];