import 'package:andgarivara/User/repository/repoUserProfile.dart';
import 'package:andgarivara/User/view/drawerScreens/widgets/profileScreenWidgets/titleWithTextBoxWidget.dart';
import 'package:andgarivara/Utils/appConst.dart';
import 'package:andgarivara/Utils/widgets/screenLoader.dart';
import 'package:andgarivara/Utils/widgets/snackBar.dart';
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


  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return IsScreenLoading(
      isLoading: loading,
      child: Dialog(
        child: Padding(
          padding: const EdgeInsets.all(8),
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
                controller: oldPasswordController,
                enabled: true,
              ),
              TextBoxWithTitle(
                title: 'New Password',
                controller: newPasswordController,
                enabled: true,
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Expanded(
                    child: WideWhiteButton(label: 'Cancel', onPressed: (){
                      Get.back();
                    }),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: WideRedButton(label: 'Confirm', onPressed: () async{
                      setState(() {
                        loading = true;
                      });

                      bool error = await RepoUserProfile.changePassword(oldPasswordController.text, newPasswordController.text);

                      if(error){
                        Snack.top('Error', 'Failed to reset password');
                      }else{
                        Get.back();
                        Snack.bottom('Success', 'Password Changed');
                      }

                      setState(() {
                        loading = false;
                      });
                    }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
