import 'package:andgarivara/Utils/controller/SizeConfigController.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawerLessAppBar extends StatelessWidget implements PreferredSizeWidget{
  final Widget widget;
  DrawerLessAppBar({
    this.widget
  });
  final String assetName = 'assets/images/svg/back.svg';

  final GetSizeConfig sizeConfig = Get.find();

  @override
  Widget build(BuildContext context) {
    final Widget svgIcon = SvgPicture.asset(
      assetName,
      color: Color(0xffC8102E),width: sizeConfig.width*60,
    );
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
          onPressed: () {
            FocusScope.of(context).unfocus();
            Get.back();
          },
          icon: svgIcon
      ),
      actions: [
        widget == null ? SizedBox() :
            widget
      ],
    );
  }

  @override
  Size get preferredSize => Size(sizeConfig.width*1000, sizeConfig.height*70);
}
