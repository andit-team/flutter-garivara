import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawerLessAppBar extends StatelessWidget implements PreferredSizeWidget{
  final double height;
  final double width;
  final Widget widget;
  const DrawerLessAppBar({
    @required this.height,
    @required this.width,
    this.widget
  });
  final String assetName = 'assets/images/svg/back.svg';

  @override
  Widget build(BuildContext context) {
    final Widget svgIcon = SvgPicture.asset(
      assetName,
      color: Color(0xffC8102E),width: width*60,
    );
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
          onPressed: () => Get.back(),
          icon: svgIcon
      ),
      actions: [
        widget == null ? SizedBox() :
            widget
      ],
    );
  }

  @override
  Size get preferredSize => Size(width*1000, height*70);
}
