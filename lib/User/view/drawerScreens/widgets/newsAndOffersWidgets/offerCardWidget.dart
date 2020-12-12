import 'package:andgarivara/Utils/appConst.dart';
import 'package:andgarivara/Utils/controller/SizeConfigController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class OfferCardWidget extends StatelessWidget {
  final GetSizeConfig sizeConfig = Get.find();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: sizeConfig.height * 20),
      child: GestureDetector(
        onTap: () async{
          Clipboard.setData(ClipboardData(text: 'V1H237S'));
          ClipboardData data = await Clipboard.getData(Clipboard.kTextPlain);
          Get.rawSnackbar(
            title: 'Done',
            message: 'Code "${data.text}" copied to clipboard'
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '12 Dec 2020',
              style: TextStyle(
                  color: AppConst.textLight,
                  fontSize: sizeConfig.getPixels(16)
              ),
            ),
            SizedBox(height: sizeConfig.height * 10,),
            Padding(
              padding: EdgeInsets.only(right: sizeConfig.getPixels(40)),
              child: AspectRatio(
                aspectRatio: 274.15/163.76,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(sizeConfig.width * 35),
                    color: Color(0xff80B00C)
                  ),
                       padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          width: sizeConfig.width * 250,
                          child: Image.asset(
                            'assets/images/appLogo/white.png'
                          ),
                        ),
                      ),
                      SizedBox(height: sizeConfig.height * 10,),
                      Text(
                        'R 1487',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Roboto-M',
                          fontSize: sizeConfig.getPixels(16)
                        ),
                      ),
                      Text(
                        'TRAVEL VOUCHER',
                        maxLines: 1,
                        style: TextStyle(
                          letterSpacing: 2,
                          color: Colors.white,
                          fontFamily: 'Roboto-M',
                          fontSize: sizeConfig.getPixels(32)
                        ),
                      ),
                      Text(
                        'VALID UNTIL 5 FEB  2022',
                        maxLines: 1,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: sizeConfig.getPixels(18)
                        ),
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: sizeConfig.width * 550,
                            child: Text(
                              'This VOUCHER CAN BE TRANSFERRED ONCE. FOR INSTRUCTIONS AND TERMS AND CONDITIONS VISIT WWW.FOODJOCKY.COM/VOUCHERS',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: sizeConfig.getPixels(10)
                              ),
                            ),
                          ),
                          Text(
                            'V1H237S',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: sizeConfig.getPixels(16)
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
