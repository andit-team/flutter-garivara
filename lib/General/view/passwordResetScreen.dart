import 'package:andgarivara_driver/General/view/signInScreen.dart';
import 'package:andgarivara_driver/Utils/controller/SizeConfigController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPassword extends StatelessWidget {

  final GetSizeConfig getSizeConfig = Get.find();

  final TextEditingController newPassword = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final FocusNode newPasswordNode = FocusNode();
  final FocusNode confirmPasswordNode = FocusNode();

  void dispose() {
    newPassword.dispose();
    newPasswordNode.dispose();

    confirmPassword.dispose();
    newPasswordNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = getSizeConfig.width.value;
    final double  height = getSizeConfig.height.value;
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width*70),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric( vertical: height * 10),
                  child: Container(
                    height: height * 250,
                    width: width * 800,
                    child: Image.asset(
                      'assets/images/appLogo/andgarivara_hero.gif',
                      // fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric( vertical: height * 5),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Reset Password',
                      style: TextStyle(
                          fontSize: getSizeConfig.width * 70,
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                  EdgeInsets.symmetric(vertical: height * 15),
                  child: TextField(
                    controller: newPassword,
                    focusNode: newPasswordNode,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: height * 5,
                          horizontal: width * 30),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(width*20),
                          borderSide: BorderSide(
                            color: Color(0xff233F53),
                          )),
                      labelText: 'New Password',
                    ),
                  ),
                ),
                Padding(
                  padding:
                  EdgeInsets.symmetric(vertical: height * 15),
                  child: TextField(
                    controller: confirmPassword,
                    focusNode: confirmPasswordNode,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: height * 5,
                          horizontal: width * 30),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(width*20),
                          borderSide: BorderSide(
                            color: Color(0xff233F53),
                          )),
                      labelText: 'Confirm Password',
                    ),
                  ),
                ),
                Padding(
                  padding:
                  EdgeInsets.symmetric(vertical: height * 30),
                  child: Container(
                    width: width*1000,
                    height: height*70,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(width*80),
                          side: BorderSide(color: Colors.red)
                      ),
                      onPressed: () {
                        Get.offAll(SignInScreen());
                      },
                      child: Text(
                        'Reset Password',
                        style: TextStyle(color: Colors.white,fontSize: getSizeConfig.getPixels(20)),
                      ),
                      color: Color(0xffC8102E),
                      splashColor: Colors.grey,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
