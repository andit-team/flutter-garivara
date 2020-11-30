import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_app/general/models/login_error_model.dart';
import 'package:flutter_app/general/models/sessionManagerModel.dart';
import 'package:flutter_app/general/repository/user_profile_data_repository.dart';
import 'package:flutter_app/general/view/loginPage.dart';
import 'package:flutter_app/member/models/user_model.dart';
import 'package:flutter_app/member/view/memberHomeScreen.dart';
import 'package:flutter_app/utils/getControllers/user_profile_view_model.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';

class AuthController extends GetxController {
  Stream<User> get currentUser => _auth.authStateChanges();

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseStorage storage = FirebaseStorage.instance;

  User user;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  final fb = FacebookLogin();

  var fbResult,googleResults;
  var logger = Logger();

  GetStorage localStorage = GetStorage();

  createUser(String name, String email, String password, File userPhoto,
      String userType, String loginType) async {
    print(userPhoto);
    try {
      var user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      try {
        Reference ref = storage.ref().child("${user.user.uid}");
        UploadTask uploadTask = ref.putFile(userPhoto);
        TaskSnapshot res = await uploadTask;
        if (res != null) {
          var photoURL = await res.ref.getDownloadURL();
          try {
            await addUserToDatabase(
                name, email, photoURL, userType, loginType, user.user.uid);
          } on FirebaseAuthException catch (e) {
            //Error on saving data to database
            logger.i(e.message);
            return e.message;
          }
        }
      } on FirebaseAuthException catch (e) {
        //Error on uploading picture to storage
        logger.i(e.message);
        return e.message;
      }
    } on FirebaseAuthException catch (e) {
      //Error on existing account of same email
      logger.i(e.message);
      return e.message;
    }
  }

  addUserToDatabase(name, email, userPhoto, userType, loginType, userID) async {
    try {
      Timestamp timestamp = Timestamp.now();
      //DateTime dateNow = now.toDate(); //TimeStamp to Date
      //DateTime.fromMicrosecondsSinceEpoch(time.microsecondsSinceEpoch) //TimeStamp to Date
      var data = UserModel(
        userID: _auth.currentUser.uid,
        userGroupID: '',
        userName: name,
        email: email,
        userPhoto: userPhoto,
        address: '',
        phoneNumber: '',
        userType: userType,
        userLoginType: loginType,
        checkInData: [],
        lastCheckIn: timestamp,
        facebookID: '',
        instagramID: '',
      );
      try {
        await UserProfileDataRepository().addNewUser(data);
      } on FirebaseAuthException catch (e) {
        // Error on adding data to firebase
        logger.i(e.message);
        return e.message;
      }
    } on FirebaseAuthException catch (e) {
      //Error on model class
      logger.i(e.message);
      return e.message;
    }
  }

  login(String email, String password) async {
    String userLoginType = 'regular';

    try {
      var isSuccess = await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password);
      print('Successfully logged in $isSuccess');

      if (isSuccess != null) {
        await UserProfileDataRepository()
            .getUserData(isSuccess.user.email, userLoginType);
        Get.offAll(MemberHomeScreen());
        return null;
      }
    } on FirebaseAuthException catch (eLogin) {
      // Error logging in
      var data = ErrorModel(
        message: '${eLogin.message} [Email: $email]',
        timestamp: Timestamp.now(),
      );
      try {
        await UserProfileDataRepository().loginFailed(data);
        logger.i(eLogin.message);
        return eLogin.message;
      } on FirebaseAuthException catch (eErrorData) {
        // Error on adding error data
        logger.i(eErrorData.message);
        return eErrorData.message;
      }
    }
  }

  signOut() async {
    try {
      if (_googleSignIn.currentUser != null) {
        _googleSignIn.signOut();
      } else {
        _auth.signOut();
      }
      await localStorage.erase();
      //localStorage.remove('userValues');
      Get.offAll(LoginPage());
    } catch (e) {
      Get.snackbar(
        "Error signing out",
        e.message,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future handleGoogleSignIn() async {

    String userType = 'member'; // if creating new account
    String userLoginType = 'google';

    try{
      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);


      var existingAccount = await UserProfileDataRepository().checkExistingFacebookEmail(googleSignInAccount.email, 'facebook');
      if (existingAccount == null) {
        //login result
        UserCredential result = await _auth.signInWithCredential(credential);
        if (result != null) {
          var dbHasException = await UserProfileDataRepository().getUserData(result.user.email, userLoginType);
          //check if there's same email in firebase
          if (dbHasException == null) {
            //if no email found in Firebase
            var hasException = await addUserToDatabase(
                result.user.displayName,
                result.user.email,
                result.user.photoURL,
                userType,
                userLoginType,
                _auth.currentUser.uid);
            if (hasException != null) {
              logger.i('error');
            } else {
              await UserProfileDataRepository().getUserData(result.user.email, userLoginType);
              //get user data after adding to Firebase
              Get.offAll(MemberHomeScreen());
              logger.i('success');
            }
          } else {
            Get.offAll(MemberHomeScreen());
          }
        }
      }
      else{
        return 'An account already exists with the same email address but different sign-in credentials. Sign in using a provider associated with this email address.';
      }
    }on FirebaseAuthException catch (eErrorData) {
      // Error on adding error data
      logger.i(eErrorData.message);
      googleResults = eErrorData.message;
      return googleResults;
    }
    return googleResults;
  }

  Future loginFacebook() async {
    print('Starting Facebook Login');

    final res = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);

    if (res.status == FacebookLoginStatus.Success) {
      // if creating new account
      String userType = 'member';
      String userLoginType = 'facebook';
      try {
        //Get Token
        final FacebookAccessToken fbToken = res.accessToken;
        //Convert to Auth Credential
        final AuthCredential credential = FacebookAuthProvider.credential(fbToken.token);
        //User Credential to Sign in with Firebase
        UserCredential result = await _auth.signInWithCredential(credential); //login result
        if (result != null) {
          //check if there's same email in firebase
          var dbHasException = await UserProfileDataRepository().getUserData(result.user.email, userLoginType);
          //if no email found in Firebase
          if (dbHasException == null) {
            var hasException = await addUserToDatabase(
                result.user.displayName,
                result.user.email,
                result.user.photoURL,
                userType,
                userLoginType,
                _auth.currentUser.uid);
            if (hasException != null) {
              logger.i('error');
            } else {
              //get user data after adding to Firebase
              await UserProfileDataRepository()
                  .getUserData(result.user.email, userLoginType);
              //after user is added
              Get.offAll(MemberHomeScreen());
              logger.i('success');
            }
          } else {
            //if user found
            Get.offAll(MemberHomeScreen());
          }
        }
      } on FirebaseAuthException catch (eErrorData) {
        // Error on adding error data
        logger.i(eErrorData.message);
        fbResult = eErrorData.message;
        return fbResult;
      }
      return fbResult;
    }
    else if (res.status == FacebookLoginStatus.Cancel) {
      return 'The user canceled the login';
    } else {
      return 'There was an error logging in';
    }
  }

  sessionNavigation(String userLoginType) {
    if (userLoginType == 'google') {
      Get.offAll(MemberHomeScreen());
    } else if (userLoginType == 'facebook') {
      Get.offAll(MemberHomeScreen());
    } else {
      Get.offAll(MemberHomeScreen());
    }
  }
}
