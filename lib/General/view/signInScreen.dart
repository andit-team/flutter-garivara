import 'package:andgarivara/General/view/signupScreen.dart';
import 'package:andgarivara/Utils/controller/SizeConfigController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
    return Scaffold(
      backgroundColor: Color(0xffF7F8FA),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Thank you for coming back",
                style: TextStyle(
                  fontSize: getSizeConfig.width * 60,
                ),
              ),
              SizedBox(
                height: height * 20,
              ),
              Container(
                height: height * 250,
                width: width * 800,
                child: Image.asset(
                  'assets/images/appLogo/andgarivara_hero.gif',
                  // fit: BoxFit.cover,
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width * 50, vertical: height * 30),
                child: Card(
                  color: Color(0xffFFFFFF),
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 50, vertical: height * 30),
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
                                  controller: mobile,
                                  focusNode: mobileNode,
                                  autofocus: true,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: height * 5,
                                        horizontal: width * 30),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                      color: Color(0xff233F53),
                                    )),
                                    labelText: 'Mobile',
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height * 20,
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
                                        borderSide: BorderSide(
                                      color: Color(0xff233F53),
                                    )),
                                    labelText: 'Password',
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height * 20,
                              ),
                              Row(
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
                                    "Keep me signed in",
                                    style: TextStyle(
                                      fontSize: getSizeConfig.width * 40,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height * 20,
                          ),
                          Container(
                            child: FlatButton(
                              onPressed: () {},
                              child: Text(
                                'Sign In',
                                style: TextStyle(color: Colors.white),
                              ),
                              color: Color(0xff233F53),
                              splashColor: Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Row(
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
                      "Sign up now!",
                      style: TextStyle(
                          fontSize: getSizeConfig.width * 40,
                          color: Color(0xff0A98FE)),
                    ),
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

class NoPaddingCheckbox extends StatelessWidget {
  final bool isMarked;
  final Function(bool newValue) onChange;
  final double size;

  NoPaddingCheckbox({
    @required this.isMarked,
    @required this.onChange,
    this.size = 24,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: size, maxWidth: size),
      child: RawMaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        child: Icon(_getIconData(), size: size),
        onPressed: () => onChange(!isMarked),
      ),
    );
  }

  IconData _getIconData() {
    if (isMarked) {
      return Icons.check_box;
    }

    return Icons.check_box_outline_blank;
  }
}
