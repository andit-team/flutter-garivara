import 'dart:io';
import 'package:andgarivara/User/functions/userProfileFunctions.dart';
import 'package:andgarivara/User/model/userModel.dart';
import 'package:andgarivara/User/repository/repoUserProfile.dart';
import 'package:andgarivara/User/view/drawerScreens/widgets/profileScreenWidgets/title.dart';
import 'package:andgarivara/User/view/drawerScreens/widgets/profileScreenWidgets/titleWithTextBoxWidget.dart';
import 'package:andgarivara/User/view/drawerScreens/widgets/profileScreenWidgets/titleWithTextButton.dart';
import 'package:andgarivara/User/viewModel/userData.dart';
import 'package:andgarivara/Utils/appConst.dart';
import 'package:andgarivara/Utils/controller/SizeConfigController.dart';
import 'package:andgarivara/Utils/stringResorces.dart';
import 'package:andgarivara/Utils/widgets/drawerlessAPpBar.dart';
import 'package:andgarivara/Utils/widgets/screenLoader.dart';
import 'package:andgarivara/Utils/widgets/snackBar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GetSizeConfig sizeConfig = Get.find();

  TextEditingController fNameEditingController;
  TextEditingController lNameEditingController;
  TextEditingController emailEditingController;
  TextEditingController mobileEditingController;

  TextEditingController passwordEditingController;
  TextEditingController securityQuestionEditingController;

  bool edit = false;

  List<String> languages = [
    'English',
    'Bangla',
    'Urdu',
    'Kanji'
  ];
  String selectedLanguage;

  File image;



  UserModel user;

  @override
  void initState() {
    user = ViewModelUserData.userData.value;
    super.initState();
    selectedLanguage = languages[0];
    fNameEditingController = TextEditingController(text: user.firstName);
    lNameEditingController = TextEditingController(text: user.lastName);
    emailEditingController = TextEditingController(text: user.email.isNullOrBlank ? 'Not Given' : user.email);
    mobileEditingController = TextEditingController(text: user.phoneNo);
  }

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return IsScreenLoading(
      isLoading: loading,
      child: Scaffold(
        appBar: DrawerLessAppBar(
          // widget: Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: FloatingActionButton.extended(
          //     onPressed: (){
          //       setState(() {
          //         edit = !edit;
          //       });
          //     },
          //     icon: Icon(edit ? Icons.save : Icons.edit),
          //     label: Text(edit ? 'Save' : 'Edit'),
          //   ),
          // ),
        ),
        body: Obx(()=>Padding(
          padding: EdgeInsets.symmetric(horizontal: sizeConfig.getPixels(20)),
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: CircleAvatar(
                      radius: sizeConfig.getPixels(65),
                      backgroundColor: AppConst.appGreen,
                      child: CircleAvatar(
                        radius: sizeConfig.getPixels(60),
                        backgroundImage: user.profilePic.isNullOrBlank ?
                        image == null ? AssetImage('assets/images/appLogo/app_logo.png') : FileImage(image) :
                        CachedNetworkImageProvider(ViewModelUserData.userData.value.profilePic)
                      ),
                    ),
                  ),
                  SizedBox(width: sizeConfig.width * 30,),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FlatButton.icon(
                        onPressed: (){
                          selectImage();
                        },
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(sizeConfig.width * 30)),
                        icon: Icon(
                          Icons.upload_file,
                          color: Colors.white,
                        ),
                        label: Text('Select Image',style: TextStyle(color: Colors.white),),
                      ),
                      image != null ? FlatButton.icon(
                        onPressed: () async{
                          setState(() {
                            loading = true;
                          });
                          bool error = await RepoUserProfile.uploadImage(image);
                          Snack.bottom(error ? 'Error' : 'Success', error ? 'Failed to upload' : 'Image uploaded');
                          setState(() {
                            loading = false;
                          });
                        },
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(sizeConfig.width * 30)),
                        icon: Icon(
                          Icons.upload_file,
                          color: Colors.white,
                        ),
                        label: Text('Upload Image',style: TextStyle(color: Colors.white),),
                      ) : SizedBox(),
                    ],
                  ),
                ],
              ),
              SizedBox(height: sizeConfig.height * 15,),
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: Colors.grey,
                            width: .7
                        )
                    )
                ),
                padding: EdgeInsets.only(bottom: sizeConfig.height * 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleText(
                      title: StringResources.profileScreenContact,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextBoxWithTitle(
                            title: 'First Name',
                            controller: fNameEditingController,
                            enabled: edit,
                          ),
                        ),
                        SizedBox(width: sizeConfig.width * 20,),
                        Expanded(
                          child: TextBoxWithTitle(
                            title: 'Last Name',
                            controller: lNameEditingController,
                            enabled: edit,
                          ),
                        ),
                      ],
                    ),
                    TextBoxWithTitle(
                      title: 'Email',
                      controller: emailEditingController,
                      enabled: edit,
                    ),
                    TextBoxWithTitle(
                      title: 'Mobile',
                      controller: mobileEditingController,
                      enabled: edit,
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: Colors.grey,
                            width: .7
                        )
                    )
                ),
                padding: EdgeInsets.symmetric(vertical: sizeConfig.height * 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: double.infinity,),
                    TitleText(
                      title: StringResources.profileScreenSecurity,
                    ),
                    TitleWithTextButton(
                      title: 'Password',
                      subtitle: 'Change password',
                      onTap: (){

                      },
                    ),
                    // TitleWithTextButton(
                    //   title: 'Security Question',
                    //   subtitle: 'Change security question',
                    //   onTap: (){
                    //
                    //   },
                    // ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: sizeConfig.height * 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleText(
                      title: StringResources.profileScreenLanguage,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: sizeConfig.height * 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Select language',
                            style: TextStyle(
                                fontSize: sizeConfig.getPixels(16),
                                color: AppConst.textLight
                            ),
                          ),
                          SizedBox(height: sizeConfig.height * 10,),
                          DropdownButtonHideUnderline(
                            child: DropdownButton(
                              onChanged: (value){
                                setState(() {
                                  selectedLanguage = value;
                                });
                              },
                              isExpanded: true,
                              value: selectedLanguage,
                              items: languages.map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(
                                  e,
                                  style: TextStyle(
                                      fontSize: sizeConfig.getPixels(18),
                                      color: AppConst.textBlue
                                  ),
                                ),
                              )).toList(),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }

  void selectImage() async{
    File temp = await FuncUserProfile.selectImage();
    setState(() {
      image=temp;
    });
  }
}
