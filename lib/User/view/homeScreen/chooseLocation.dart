import 'package:andgarivara/User/view/homeScreen/chooseLocationFromMap.dart';
import 'package:andgarivara/Utils/appConst.dart';
import 'package:andgarivara/Utils/controller/SizeConfigController.dart';
import 'package:andgarivara/Utils/stringResorces.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:get/get.dart';

class ChooseLocationScreen extends StatefulWidget {
  @override
  _ChooseLocationScreenState createState() => _ChooseLocationScreenState();
}

class _ChooseLocationScreenState extends State<ChooseLocationScreen> {

  final GetSizeConfig sizeConfig = Get.find();

  String meh;
  Address location;

  TextEditingController addressController = TextEditingController(text: '32, Choto mirjapur, Ahsan ahmed road...');

  @override
  void initState() {
    meh = Get.arguments;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(location);
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            top(),
            bottom(),
          ],
        ),
      ),
    );
  }

  Widget top(){
    return Container(
      height: sizeConfig.height * 460,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(sizeConfig.width * 70),
          bottomRight: Radius.circular(sizeConfig.width * 70),
        ),
        boxShadow: [
          BoxShadow(
              color: Colors.grey,
              spreadRadius: 5,
              blurRadius: 15
          )
        ],
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: sizeConfig.getPixels(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: AppBar().preferredSize.height,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: sizeConfig.width *  150,vertical: 5),
              child: AspectRatio(
                aspectRatio: 209/53,
                child: Image.asset(
                  'assets/images/andGariVaraWithCar.png'
                ),
              ),
            ),
            SizedBox(height: sizeConfig.height * 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  meh == 'p' ? StringResources.chooseLocationHeader1 : StringResources.chooseLocationHeader1,
                  style: TextStyle(
                    fontSize: sizeConfig.getPixels(32),
                    color: AppConst.themeBlue,
                    fontFamily: 'Roboto-M'
                  ),
                ),
                IconButton(
                  onPressed: (){
                    Get.back(result: location);
                  },
                  icon: Icon(
                    Icons.clear,
                    size: 30,
                  ),
                )
              ],
            ),
            SizedBox(height: sizeConfig.height * 20,),
            Stack(
              children: [
                TextField(
                  controller: addressController,
                  style: TextStyle(
                    fontSize: sizeConfig.getPixels(16),
                    color: AppConst.themeBlue
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(right: sizeConfig.width * 85,left: sizeConfig.width * 30),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(sizeConfig.width * 30)
                    )
                  ),
                ),
                Positioned(
                  right: sizeConfig.width * 20,
                  top: 0,
                  bottom: 0,
                  child: InkWell(
                    onTap: (){
                      addressController.clear();
                    },
                    child: Icon(
                      Icons.cancel,
                      color: Color(0xff707070),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: sizeConfig.height * 20,),
            InkWell(
              onTap: () async{
                location = await Get.to(ChooseLocationFromMap());
                if(location == null){

                }else{
                  addressController.text = location.addressLine;
                }
              },
              child: Row(
                children: [
                  Icon(
                    Icons.location_on_rounded,
                    color: Color(0xff707070),
                  ),
                  Text(
                    StringResources.chooseLocationMapHint,
                    style: TextStyle(
                      color: Color(0xff707070),
                      fontSize: sizeConfig.getPixels(16)
                    ),
                  ),
                  Spacer(),
                  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1111)),
                    color: AppConst.themeRed,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: sizeConfig.getPixels(40),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget bottom(){
    return Container(
      height: sizeConfig.height * 590,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: sizeConfig.getPixels(20)),
        child: ListView(
          padding: EdgeInsets.zero,
          primary: true,
          shrinkWrap: true,
          children: [
            SizedBox(height: sizeConfig.height *30,width: double.infinity,),
            Text(
              StringResources.chooseLocationFavPlace,
              style: TextStyle(
                fontSize: sizeConfig.getPixels(32),
                fontFamily: 'Roboto-M',
                color: AppConst.themeBlue
              ),
            ),
            ListView.builder(
              itemCount: 3,
              padding: EdgeInsets.symmetric(vertical: sizeConfig.height * 10),
              shrinkWrap: true,
              itemBuilder: (_, index){
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.favorite,
                      color: AppConst.themeBlue,
                    ),
                    SizedBox(width: sizeConfig.width * 15,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Office',
                          style: TextStyle(
                            color: AppConst.themeBlue,
                            fontSize: sizeConfig.getPixels(16),
                            fontFamily: 'Roboto-M',
                          ),
                        ),
                        Text(
                          '32, Choto mirjapur, Ahsan ahmed road...',
                          style: TextStyle(
                              color: Color(0xff54545E),
                              fontSize: sizeConfig.getPixels(14)
                          ),
                        )
                      ],
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: (){

                      },
                      icon: Icon(
                        Icons.remove_circle_outline,
                        color: AppConst.themeRed,
                      ),
                    )
                  ],
                );
              },
            ),
            Text(
              StringResources.chooseLocationRecentlyPlace,
              style: TextStyle(
                fontSize: sizeConfig.getPixels(32),
                fontFamily: 'Roboto-M',
                color: AppConst.themeBlue
              ),
            ),
            ListView.builder(
              itemCount: 3,
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemBuilder: (_, index){
                return Row(
                  children: [
                    Icon(
                      Icons.edit_location_sharp,
                      color: AppConst.themeBlue,
                    ),
                    SizedBox(width: sizeConfig.width * 15,),
                    Text(
                      '32, Choto mirjapur, Ahsan ahmed road...',
                      style: TextStyle(
                        color: AppConst.themeBlue,
                        fontSize: sizeConfig.getPixels(16),
                        fontFamily: 'Roboto-R',
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: (){

                      },
                      icon: Icon(
                        Icons.remove_circle_outline,
                        color: AppConst.themeRed,
                      ),
                    )
                  ],
                );
              },
            ),
          ],
        )
      ),
    );
  }
}
