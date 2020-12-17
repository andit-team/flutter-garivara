import 'package:andgarivara/General/model/registerResponse.dart';
import 'package:andgarivara/General/model/registrationModel.dart';
import 'package:andgarivara/General/repository/repoRegister.dart';
import 'package:andgarivara/Utils/controller/SizeConfigController.dart';
import 'package:andgarivara/Utils/widgets/redButton.dart';
import 'package:andgarivara/Utils/widgets/screenLoader.dart';
import 'package:andgarivara/Utils/widgets/snackBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

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
  TextEditingController confPassword = TextEditingController();

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
  }

  setInitialScreenSize() {
    width = getSizeConfig.width.value;
    height = getSizeConfig.height.value;
  }


  final formKey = GlobalKey<FormState>();

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
                          Form(
                            key: formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                  EdgeInsets.symmetric(vertical: height * 10),
                                  child: TextFormField(
                                    validator: (val) => val.isEmpty ? 'Please Enter first name' : null,
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    controller: firstName,
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
                                  child: TextFormField(
                                    validator: (val) => val.isEmpty ? 'Please Enter last name' : null,
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    controller: lastName,
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
                                  child: TextFormField(
                                    validator: (val) => val.isEmpty ? 'Please Enter a valid mobile number' : null,
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    controller: mobile,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [LengthLimitingTextInputFormatter(11)],
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
                                      labelText: 'Mobile No.',
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                  EdgeInsets.symmetric(vertical: height * 10),
                                  child: TextField(
                                    controller: email,
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
                                  child: TextFormField(
                                    validator: (val) {
                                      if(val.length < 6){
                                        return 'Password must be at-least 6 character';
                                      }else if(confPassword.text != val){
                                        return 'Password do not match';
                                      }else{
                                        return null;
                                      }
                                    },
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    obscureText: true,
                                    controller: password,
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
                                Padding(
                                  padding:
                                  EdgeInsets.symmetric(vertical: height * 10),
                                  child: TextFormField(
                                    validator: (val) {
                                      if(val.length < 6){
                                        return 'Password must be at-least 6 character';
                                      }else if(password .text != val){
                                        return 'Password do not match';
                                      }else{
                                        return null;
                                      }
                                    },
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    obscureText: true,
                                    controller: confPassword,
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
                              ],
                            ),
                          ),

                          Padding(
                            padding:
                            EdgeInsets.symmetric(vertical: height * 40),
                            child: RedButton(
                              function: ()async{
                                if(formKey.currentState.validate()) {
                                  setState(() {
                                    loading = true;
                                  });

                                  RegisterModel newUser = RegisterModel(
                                    firstName: firstName.text,
                                    lastName: lastName.text,
                                    mobile: mobile.text,
                                    password: password.text,
                                    email: email.text.length > 1 ? email.text : ''
                                  );

                                  RegisterResponse response = await RepoRegister.registerUser(newUser);

                                  setState(() {
                                    loading = false;
                                  });
                                  if(response.error){

                                  }else{
                                    Get.back();
                                  }
                                  Snack.bottom(response.error ? 'Error' : 'Success', response.msg);


                                }
                              },
                              title: 'Sign up',
                            )
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
                              Get.back();
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
      ),
    );
  }
}
