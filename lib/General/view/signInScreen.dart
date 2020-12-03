import 'package:andgarivara/General/view/signupScreen.dart';
import 'package:andgarivara/User/view/homeScreen.dart';
import 'package:andgarivara/Utils/controller/SizeConfigController.dart';
import 'package:andgarivara/Utils/widgets/checkbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:get/get.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GetSizeConfig getSizeConfig = Get.find();
  double width;
  double height;

  bool rememberMe = true;
  TextEditingController mobile = TextEditingController();
  TextEditingController password = TextEditingController();

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
    mobile.dispose();
    password.dispose();
    mobileNode.dispose();
    passwordNode.dispose();
  }

  setInitialScreenSize() {
    width = getSizeConfig.width.value;
    height = getSizeConfig.height.value;
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).unfocus();
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
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
                    logo(),
                    upperTitle(),
                    form(),
                    Padding(
                      padding: EdgeInsets.symmetric( vertical: height * 10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: width * 250,
                                height: height * 5,
                                color: Color(0xff707070),
                              ),
                              Text(
                                'Or connect with',
                                style: TextStyle(fontSize: getSizeConfig.getPixels(16),
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff34415F)
                                ),
                              ),
                              Container(
                                width: width * 250,
                                height: height * 5,
                                color: Color(0xff707070),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    socialMedia(),
                    haveAccount(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding logo() {
    return Padding(
      padding: EdgeInsets.symmetric( vertical: height * 10),
      child: Container(
        height: height * 250,
        width: width * 800,
        child: Image.asset(
          'assets/images/appLogo/andgarivara_hero.gif',
          // fit: BoxFit.cover,
        ),
      ),
    );
  }

  Padding upperTitle() {
    return Padding(
      padding: EdgeInsets.symmetric( vertical: height * 2),
      child: Container(
        alignment: Alignment.centerLeft,
        child: Text(
          'Ride with Andgarivara',
          style: TextStyle(
            fontSize: getSizeConfig.width * 60,
            color: Colors.black
          ),
        ),
      ),
    );
  }

  Padding form() {
    return Padding(
      padding: EdgeInsets.symmetric( vertical: height * 10),
      child: Container(
        child: Padding(
          padding: EdgeInsets.symmetric( vertical: height * 15),
          child: Column(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  mobileTextField(),
                  passwordTextField(),
                  Padding(
                    padding:
                    EdgeInsets.symmetric(vertical: height * 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        rememberMeCheckbox(),
                        forgotPassword(),
                      ],
                    ),
                  ),
                ],
              ),
              signInButton()
            ],
          ),
        ),
      ),
    );
  }

  Padding mobileTextField() {
    return Padding(
      padding:
      EdgeInsets.symmetric(vertical: height * 10),
      child: TextField(
        controller: mobile,
        focusNode: mobileNode,
        autofocus: true,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: height * 5,
              horizontal: width * 30),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(width*20),
              borderSide: BorderSide(
                color: Color(0xff233F53),
              )),
          labelText: 'Enter your mobile number',
        ),
      ),
    );
  }

  Padding passwordTextField() {
    return Padding(
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
          labelText: 'Enter your password',
        ),
      ),
    );
  }

  Row rememberMeCheckbox() {
    return Row(
      children: [
        NoPaddingCheckbox(
          isMarked: rememberMe,
          size: width * 70,
          onChange: (bool newValue) {
            setState(() {
              rememberMe = newValue;
            });
          },
        ),
        SizedBox(
          width: width * 10,
        ),
        Text(
          "Remember Me",
          style: TextStyle(
            fontSize: getSizeConfig.width * 40,
          ),
        ),
      ],
    );
  }

  Row forgotPassword() {
    return Row(
                                      children: [
                                        Text(
                                          "Forgot password?",
                                          style: TextStyle(
                                            fontSize: getSizeConfig.width * 40,
                                          ),
                                        ),
                                      ],
                                    );
  }

  Padding signInButton() {
    return Padding(
                            padding:
                            EdgeInsets.symmetric(vertical: height * 10),
                            child: Container(
                              width: width*1000,
                              height: height*70,
                              child: FlatButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(width*80),
                                    side: BorderSide(color: Colors.red)
                                ),
                                onPressed: () {
                                  Get.to(HomeScreen());},
                                child: Text(
                                  'Login',
                                  style: TextStyle(color: Colors.white,fontSize: getSizeConfig.getPixels(20)),
                                ),
                                color: Color(0xffC8102E),
                                splashColor: Colors.grey,
                              ),
                            ),
                          );
  }

  Padding socialMedia() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height*10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SignInButton(
            Buttons.Facebook,
            mini: false,
            onPressed: () {
              Get.snackbar('Facebook', 'LinkedIn Signed Up');
            },
          ),
          SignInButton(
            Buttons.Twitter,
            mini: false,
            onPressed: () {
              Get.snackbar('Twitter', 'Twitter Signed Up');
            },
          ),
          SignInButton(
            Buttons.Google,
            mini: false,
            onPressed: () {
              Get.snackbar('Google', 'Google Signed Up');
            },
          ),
        ],
      ),
    );
  }

  Row haveAccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Do not have an account? ",
          style: TextStyle(
            fontSize: getSizeConfig.width * 40,
          ),
        ),
        GestureDetector(
          onTap: () {
            Get.to(SignUpScreen());
          },
          child: Text(
            "Sign Up!",
            style: TextStyle(
                fontSize: getSizeConfig.width * 40,
                color: Color(0xff0A98FE)),
          ),
        ),
      ],
    );
  }


}

