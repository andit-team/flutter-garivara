import 'package:andgarivara/User/view/drawerScreens/widgets/profileScreenWidgets/title.dart';
import 'package:andgarivara/User/view/drawerScreens/widgets/profileScreenWidgets/titleWithTextBoxWidget.dart';
import 'package:andgarivara/User/view/drawerScreens/widgets/profileScreenWidgets/titleWithTextButton.dart';
import 'package:andgarivara/Utils/appConst.dart';
import 'package:andgarivara/Utils/controller/SizeConfigController.dart';
import 'package:andgarivara/Utils/stringResorces.dart';
import 'package:andgarivara/Utils/widgets/drawerlessAPpBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GetSizeConfig sizeConfig = Get.find();

  final TextEditingController nameEditingController = TextEditingController(text: 'Jhon Chicken');
  final TextEditingController emailEditingController = TextEditingController(text: 'chicken@pokpok.com');
  final TextEditingController mobileEditingController = TextEditingController(text: '+880 1711 123 789');

  final TextEditingController passwordEditingController = TextEditingController(text: 'Change Password');
  final TextEditingController securityQuestionEditingController = TextEditingController(text: 'Change security Question');

  bool edit = false;

  List<String> languages = [
    'English',
    'Bangla',
    'Urdu',
    'Kanji'
  ];
  String selectedLanguage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedLanguage = languages[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DrawerLessAppBar(
        widget: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton.extended(
            onPressed: (){
              setState(() {
                edit = !edit;
              });
            },
            icon: Icon(edit ? Icons.save : Icons.edit),
            label: Text(edit ? 'Save' : 'Edit'),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: sizeConfig.getPixels(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                  TextBoxWithTitle(
                    title: 'Name',
                    controller: nameEditingController,
                    enabled: edit,
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
                  TitleWithTextButton(
                    title: 'Security Question',
                    subtitle: 'Change security question',
                    onTap: (){

                    },
                  ),
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
      ),
    );
  }
}
