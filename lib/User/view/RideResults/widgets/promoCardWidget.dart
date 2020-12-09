import 'package:andgarivara/Utils/Icons/ticket_icon_icons.dart';
import 'package:andgarivara/Utils/appConst.dart';
import 'package:andgarivara/Utils/controller/SizeConfigController.dart';
import 'package:andgarivara/Utils/widgets/checkbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ticketview/ticketview.dart';

class PromoCardWidget extends StatelessWidget {
  final bool selected;
  PromoCardWidget({this.selected});
  final GetSizeConfig sizeConfig = Get.find();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: sizeConfig.height * 20),
      child: TicketView(
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.symmetric(horizontal: sizeConfig.getPixels(20)),
        drawArc: true,
        borderRadius: .1,
        trianglePos: .35,
        child: Container(
          height: sizeConfig.getPixels(95),
          padding: EdgeInsets.symmetric(horizontal: sizeConfig.width * 20),
          child: Row(
            children: [
              Expanded(
                flex: 35,
                child: Center(
                  child: Material(
                    color: AppConst.appBlue.withOpacity(.15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1111)),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(13, 13, 15, 13),
                      child: Icon(
                        TicketIcon.ticket_alt,
                        size: sizeConfig.width * 60,
                        color: AppConst.appBlue,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 75,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: sizeConfig.width * 70,
                    right: sizeConfig.width * 15
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        '10% off the base rate of your rental',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: sizeConfig.getPixels(18),
                          color: AppConst.textBlue
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Valid till: 31 Dec 2020',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: sizeConfig.getPixels(14),
                              color: AppConst.textLight
                            ),
                          ),
                          Icon(
                            selected ? Icons.check_box : Icons.check_box_outline_blank,
                            color: selected ? AppConst.appRed : Colors.grey,
                            size: sizeConfig.getPixels(22),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}
