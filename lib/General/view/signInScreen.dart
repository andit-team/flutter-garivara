
import 'package:andgarivara_driver/General/repository/repoLogin.dart';
import 'package:andgarivara_driver/General/view/forgotPasswordScreen.dart';
import 'package:andgarivara_driver/User/view/home.dart';
import 'package:andgarivara_driver/Utils/controller/SizeConfigController.dart';
import 'package:andgarivara_driver/Utils/dummyPage.dart';
import 'package:andgarivara_driver/Utils/widgets/checkbox.dart';
import 'package:andgarivara_driver/Utils/widgets/redButton.dart';
import 'package:andgarivara_driver/Utils/widgets/screenLoader.dart';
import 'package:andgarivara_driver/Utils/widgets/snackBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  TextEditingController mobile = TextEditingController(text: '11111111111');
  TextEditingController password = TextEditingController(text: '123123');

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

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return IsScreenLoading(
      isLoading: loading,
      child: SafeArea(
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
        height: height * 170,
        width: width * 800,
        child: Image.asset(
          'assets/images/andGariVaraWithCar.png',
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
          'Connect to Andgarivara',
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
                    EdgeInsets.symmetric(vertical: height * 20),
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
        keyboardType: TextInputType.number,
        focusNode: mobileNode,
        inputFormatters: [LengthLimitingTextInputFormatter(11)],
        //autofocus: true,
        decoration: InputDecoration(
          prefixText: '+88',
          prefixStyle: TextStyle(
            color: Colors.black,
            fontSize: 16
          ),
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

  GestureDetector forgotPassword() {
    return GestureDetector(
      onTap:(){
        Get.to(ForgotPassword());
      },
      child: Text(
        "Forgot password?",
        style: TextStyle(
          fontSize: getSizeConfig.width * 40,
        ),
      ),
    );
  }

  Padding signInButton() {
    return Padding(
      padding:
      EdgeInsets.symmetric(vertical: height * 30),
      child: RedButton(
        title: 'Login',
        function: () async{
          if(mobile.text.isNotEmpty && password.text.isNotEmpty){

            setState(() {
              loading = true;
            });

            bool error = await RepoLogin.login(mobile.text, password.text);
            if(error){
              Snack.bottom('Error', 'Login failed');
            }else{
              Get.offAll(HomeBody());
            }
            setState(() {
              loading = false;
            });
          }else{
            Snack.top('Hey!!', 'Please fill up all the fields');
          }
        },
      ),
    );
  }
}

