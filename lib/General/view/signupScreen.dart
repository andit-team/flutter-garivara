import 'package:andgarivara/General/view/signInScreen.dart';
import 'package:andgarivara/Utils/controller/SizeConfigController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final GetSizeConfig getSizeConfig = Get.find();

  double width;
  double height;

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController password = TextEditingController();

  FocusNode firstNameNode = FocusNode();
  FocusNode lastNameNode = FocusNode();
  FocusNode emailNode = FocusNode();
  FocusNode mobileNode = FocusNode();
  FocusNode passwordNode = FocusNode();

  @override
  void initState() {
    super.initState();
    if (!mounted) {
      return;
    } else {
      setInitialScreenSize();
    }
  }

  void dispose() {
    super.dispose();
    firstName.dispose();
    lastName.dispose();
    email.dispose();
    mobile.dispose();
    password.dispose();

    firstNameNode.dispose();
    lastNameNode.dispose();
    emailNode.dispose();
    mobileNode.dispose();
    passwordNode.dispose();
  }

  setInitialScreenSize() {
    width = getSizeConfig.width.value;
    height = getSizeConfig.height.value;
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffffffff),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width*70),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric( vertical: height * 10),
                    child: Container(
                      height: height * 200,
                      width: width * 800,
                      child: Image.asset(
                        'assets/images/appLogo/andgarivara_hero.gif',
                        // fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric( vertical: height * 2),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Join Andgarivara',
                        style: TextStyle(
                            fontSize: getSizeConfig.width * 60,
                            color: Colors.black
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric( vertical: height * 30),
                    child: Column(
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                              EdgeInsets.symmetric(vertical: height * 10),
                              child: TextField(
                                controller: firstName,
                                focusNode: firstNameNode,
                                //autofocus: true,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: height * 5,
                                      horizontal: width * 30),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(width*20),
                                      borderSide: BorderSide(
                                        color: Color(0xff233F53),
                                      )),
                                  labelText: 'First Name',
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                              EdgeInsets.symmetric(vertical: height * 10),
                              child: TextField(
                                controller: lastName,
                                focusNode: lastNameNode,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: height * 5,
                                      horizontal: width * 30),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(width*20),
                                      borderSide: BorderSide(
                                        color: Color(0xff233F53),
                                      )),
                                  labelText: 'Last Name',
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                              EdgeInsets.symmetric(vertical: height * 10),
                              child: TextField(
                                controller: mobile,
                                focusNode: mobileNode,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: height * 5,
                                      horizontal: width * 30),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(width*20),
                                      borderSide: BorderSide(
                                        color: Color(0xff233F53),
                                      )),
                                  labelText: 'Mobile No.',
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                              EdgeInsets.symmetric(vertical: height * 10),
                              child: TextField(
                                controller: email,
                                focusNode: emailNode,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: height * 5,
                                      horizontal: width * 30),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(width*20),
                                      borderSide: BorderSide(

                                        color: Color(0xff233F53),
                                      )),
                                  labelText: 'Email (Optional)',
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                              EdgeInsets.symmetric(vertical: height * 10),
                              child: TextField(
                                controller: password,
                                obscureText: true,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: height * 5,
                                      horizontal: width * 30),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(width*20),
                                      borderSide: BorderSide(
                                        color: Color(0xff233F53),
                                      )),
                                  labelText: 'Password',
                                ),
                              ),
                            ),
                          ],
                        ),

                        Padding(
                          padding:
                          EdgeInsets.symmetric(vertical: height * 40),
                          child: Container(
                            width: width*1000,
                            height: height*70,
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(width*80),
                                  side: BorderSide(color: Colors.red)
                              ),
                              onPressed: () {
                                Get.back();
                                },
                              child: Text(
                                'Sign up',
                                style: TextStyle(color: Colors.white,fontSize: getSizeConfig.getPixels(20)),
                              ),
                              color: Color(0xffC8102E),
                              splashColor: Colors.grey,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: height*2),
                          child: Text('By clicking signup you agree to the ', style: TextStyle(
                            color: Colors.black,
                            fontSize: getSizeConfig.width * 40,
                          ),),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: height*2),
                          child: Text('Terms of Service and Privacy policy.', style: TextStyle(
                            color: Colors.blue,
                            fontSize: getSizeConfig.width * 35,
                            decoration: TextDecoration.underline,
                          ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: height*10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: TextStyle(
                            fontSize: getSizeConfig.width * 35,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.off(SignInScreen());
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: getSizeConfig.width * 40,
                                color: Color(0xff0A98FE)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
