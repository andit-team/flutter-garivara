import 'package:andgarivara/User/view/drawerScreens/widgets/profileScreenWidgets/titleWithTextBoxWidget.dart';
import 'package:andgarivara/Utils/appConst.dart';
import 'package:andgarivara/Utils/widgets/underLinedText.dart';
import 'package:andgarivara/Utils/widgets/wideRedButton.dart';
import 'package:andgarivara/Utils/widgets/wideWhiteButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordDialog extends StatefulWidget {

  @override
  _ChangePasswordDialogState createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<ChangePasswordDialog> {

  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                UnderLinedText(
                  text: 'Change Passwrod',
                  size: TextStyle(
                    fontSize: 22,
                    color: AppConst.textBlue
                  ),
                  color: AppConst.appRed,
                ),
                FloatingActionButton(
                  onPressed: ()=> Get.back(),
                  child: Icon(Icons.clear),
                )
              ],
            ),
            SizedBox(height: 10,),
            TextBoxWithTitle(
              title: 'Old Password',
              controller: oldPasswordController
            ),
            TextBoxWithTitle(
              title: 'New Password',
              controller: newPasswordController
            ),
            Row(
              children: [
                WideWhiteButton(label: 'Cancel', onPressed: (){
                  Get.back();
                }),
                WideRedButton(label: 'Confirm', onPressed: (){
                  Get.back(result: true);
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
