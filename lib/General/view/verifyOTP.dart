import 'dart:async';
import 'dart:math';

import 'package:andgarivara_driver/General/view/passwordResetScreen.dart';
import 'package:andgarivara_driver/Utils/controller/SizeConfigController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pinput/pin_put/pin_put.dart';


class VerifyOTP extends StatefulWidget {

  final String phoneNumber;
  VerifyOTP({this.phoneNumber});

  @override
  _VerifyOTPState createState() => _VerifyOTPState();
}

class _VerifyOTPState extends State<VerifyOTP> {
  final _formKey = GlobalKey<FormState>();

  final GetSizeConfig getSizeConfig = Get.find();

  double width;

  double height;

  final TextEditingController _pinPutController = TextEditingController();

  final FocusNode _pinPutFocusNode = FocusNode();

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Colors.black),
      borderRadius: BorderRadius.circular(width*5),
    );
  }

  BoxDecoration get _pinErrorDecoration {
    return BoxDecoration(
      border: Border.all(color: Colors.red),
      borderRadius: BorderRadius.circular(width*5),
    );
  }

  bool error = false;


  String pin;


  @override
  void initState() {

    if(!mounted){
      return;
    }else{
      super.initState();
      startTimer();
      _pinPutFocusNode.addListener(() {
        if(_pinPutFocusNode.hasFocus){
          setState(() {
            error = false;
          });
        }
      });
    }
  }

  void dispose() {
    super.dispose();
    _pinPutController.dispose();
    _pinPutFocusNode.dispose();
    _timer.cancel();
  }

  setInitialScreenSize() {
    width = getSizeConfig.width.value;
    height = getSizeConfig.height.value;
  }

  Timer _timer;
  int _start;

  void startTimer() {
    getPin();
    _start = 15;
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) => setState(
            () {
          if (_start < 1) {
            timer.cancel();
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  getPin(){
    int min = 1000;
    int max = 9999;
    Random random = Random();
    pin = (min + random.nextInt(max - min)).toString();
    print(pin);

  }

  @override
  Widget build(BuildContext context) {
    setInitialScreenSize();
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
                      'Verify OTP',
                      style: TextStyle(
                          fontSize: getSizeConfig.width * 70,
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: height * 10),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Enter 4 digit code to reset your password',
                      style: TextStyle(
                          fontSize: getSizeConfig.width * 35,
                          color: Colors.black
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Get.back();
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: height * 10),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Text(
                            '${widget.phoneNumber}',
                            style: TextStyle(
                                fontSize: getSizeConfig.width * 35,
                                color: Colors.black
                            ),
                          ),
                          Text(
                            '(Edit)',
                            style: TextStyle(
                                fontSize: getSizeConfig.width * 35,
                                color: Colors.black
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: height * 15),
                  child:  Container(
                    color: Colors.white,
                    child: PinPut(
                      key: _formKey,
                  /*    validator: (s){
                       if(s.contains('0')){
                        print(s);
                         return null;
                        }
                       return null;
                      },*/
                      //autovalidateMode: AutovalidateMode.onUserInteraction,
                      //onSubmit: (String pin) => Get.snackbar('title', pin),
                      eachFieldWidth: width*200,
                      fieldsCount: 4,
                      focusNode: _pinPutFocusNode,
                      controller: _pinPutController,
                      submittedFieldDecoration: error? _pinErrorDecoration:_pinPutDecoration.copyWith(borderRadius: BorderRadius.circular(width*5)),
                      selectedFieldDecoration: error? _pinErrorDecoration:_pinPutDecoration.copyWith(
                        borderRadius: BorderRadius.circular(width*25),
                        border: Border.all(color: Colors.black.withOpacity(.5),),
                      ),
                      followingFieldDecoration: error? _pinErrorDecoration:_pinPutDecoration.copyWith(
                        borderRadius: BorderRadius.circular(width*25),
                        border: Border.all(color: Colors.grey.withOpacity(.5),),
                      ),
                      textStyle: TextStyle(
                        fontSize: getSizeConfig.getPixels(25)
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: height * 5),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: _start != 0? Text(
                      'Resend code in: 00:${_start.toString().padLeft(2, '0')}',
                      style: TextStyle(
                          fontSize: getSizeConfig.width * 35,
                          color: Colors.black
                      ),
                    ):GestureDetector(
                      onTap: (){
                        startTimer();
                    },
                      child: Text(
                        'Resend Code',
                        style: TextStyle(
                            fontSize: getSizeConfig.width * 35,
                            color: Colors.blue
                        ),
                      ),
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
                        FocusScope.of(context).unfocus();
                        if(_pinPutController.text.length < 4){
                          setState(() {
                            error = true;
                          });
                          Get.snackbar('Field Error', 'Please input all 4 digits',backgroundColor: Colors.black,colorText: Colors.white,
                          margin: EdgeInsets.only(bottom: height*20,left: width*15,right:width*15),snackPosition: SnackPosition.BOTTOM);
                        }else{
                          if(pin != _pinPutController.text){
                            setState(() {
                              error = true;
                            });
                            Get.snackbar('Verification Error', 'Incorrect Pin number',backgroundColor: Colors.black,colorText: Colors.white,
                                margin: EdgeInsets.only(bottom: height*20,left: width*15,right:width*15),snackPosition: SnackPosition.BOTTOM);
                          }else{
                            Get.off(ResetPassword());
                          }
                        }
                      },
                      child: Text(
                        'Verify OTP',
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
