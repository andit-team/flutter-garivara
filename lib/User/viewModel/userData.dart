import 'package:andgarivara/User/model/userModel.dart';
import 'package:get/get.dart';

class ViewModelUserData{
  static var userData = UserModel().obs;
  static var userToken = ''.obs;
}