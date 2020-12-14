import 'package:andgarivara/Utils/appConst.dart';
import 'package:andgarivara/Utils/controller/SizeConfigController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';

class ReferAFriendScreen extends StatelessWidget {
  final GetSizeConfig sizeConfig = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Refer a Friend',
          style: TextStyle(
            color: AppConst.textBlue
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: sizeConfig.getPixels(20),vertical: sizeConfig.height * 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: sizeConfig.height  *200,
              child: Image.asset(
                'assets/images/create-referral-program.jpg'
              ),
            ),
            Container(
              width: sizeConfig.width * 200,
              height: sizeConfig.height * 25,
              decoration: BoxDecoration(
                  color: AppConst.appBlue,
                  borderRadius: BorderRadius.circular(sizeConfig.width * 20)
              ),
              child: Center(
                child: Text(
                  'BDT 100',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            SizedBox(height: sizeConfig.height * 40,),
            Text(
              'Refer your friend and get a 100 TK voucher.',
              style: TextStyle(
                color: AppConst.textBlue,
                fontSize: sizeConfig.getPixels(22),
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: sizeConfig.height * 10,),
            Text(
              'When someone completes their first ride through your shared invitation link you will receive a 100TK voucher. You can use the voucher in any rides of your choice.',
              style: TextStyle(
                color: AppConst.textLight,
                fontSize: sizeConfig.getPixels(16),
              ),
            ),
            SizedBox(height: sizeConfig.height * 20,),
            Stack(
              children: [
                Image.asset('assets/images/Friends-Clipart-PNG-715x715.png',fit: BoxFit.cover,),
                RaisedButton(
                  onPressed: (){
                    Share.share('check out my website https://example.com', subject: 'Look what I made!');
                  },
                  color: AppConst.appBlue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(111)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: sizeConfig.width * 15,vertical: sizeConfig.height * 15),
                    child: Text(
                      'Share your link',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: sizeConfig.getPixels(20)
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
            Text(
              'Read Terms and Conditions',
              style: TextStyle(
                  color: AppConst.textLight,
                  fontSize: sizeConfig.getPixels(16),
                  decoration: TextDecoration.underline
              ),
            ),
          ],
        ),
      ),
    );
  }
}
