import 'dart:convert';
import 'dart:ffi';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smg/controller/splash_controller.dart';
import 'package:smg/helper/di.dart' as di;
import 'package:smg/helper/prefs_helper.dart';
import 'package:smg/routes/routes.dart';
import 'package:smg/services/api_check.dart';
import 'package:smg/services/api_client.dart';
import 'package:smg/services/api_constant.dart';
import 'package:smg/services/new_api_constant.dart';
import 'package:smg/utils/app_constant.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  final splashController = Get.put(SplashController());
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future handleSignIn() async {
    isLoading(true);

    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        var deviceToken = await PrefsHelper.getString(AppConstant.deviceToken);

        var headers = {
          'x-device-token': deviceToken,
          'Content-Type': 'application/json'
        };
        Map<String, dynamic> data = {
          "uid": userCredential.user!.uid,
          "email": userCredential.user!.email,
          "displayName": userCredential.user!.displayName,
          "properties": {"user_nick_name": "No Name"}
        };
        Response response = await ApiClient.postData(
            NewApiConstant.googleLogin, json.encode(data),
            headers: headers);
        if (response.statusCode == 200) {
          await PrefsHelper.setString(AppConstant.sessionToken,
              response.body['data']['session']['session_token']);
          await PrefsHelper.setBool(AppConstant.appLogged,true);

          await PrefsHelper.setString(
              AppConstant.userId,response.body['data']['user']['user_id']);
          if (response.body['data']['user']['kind'] == "RECYCLED") {
            Get.defaultDialog(
                title: "Alerts",
                content: Text(
                    "You are already logged in to ${response.body['data']['user']['email']} , do you want to login to this email?"),
                actions: [
                  ElevatedButton(onPressed: () {
                    if(response.body['data']['user_personal_information']==null){
                      Get.offNamed(Routes.setupProfile1);
                    }else if(response.body['data']['user_educational_information']==null){
                      Get.offNamed(Routes.setupProfile2);
                    } else if(response.body['data']['user_desire']==null){
                      Get.offNamed(Routes.setupProfile3);
                    }else{
                      Get.offNamed(Routes.blogScreen);
                    }
                  }, child: const Text("NO")),
                  ElevatedButton(onPressed: () {
                    if(response.body['data']['user_personal_information']==null){
                      Get.offNamed(Routes.setupProfile1);
                    }else if(response.body['data']['user_educational_information']==null){
                      Get.offNamed(Routes.setupProfile2);
                    } else if(response.body['data']['user_desire']==null){
                      Get.offNamed(Routes.setupProfile3);
                    }else{
                      Get.offNamed(Routes.blogScreen);
                    }
                  }, child: const Text("Yes")),
                ]);
          }else{
           if(response.body['data']['user_personal_information']==null){
             Get.offNamed(Routes.setupProfile1);
           }else if(response.body['data']['user_educational_information']==null){
             Get.offNamed(Routes.setupProfile2);
           } else if(response.body['data']['user_desire']==null){
             Get.offNamed(Routes.setupProfile3);
           }else{
            Get.offNamed(Routes.blogScreen);
           }

          }
        } else {
          debugPrint("error : ${response.statusText}");
        }
      }
      isLoading(false);
    } catch (error) {
      debugPrint("Error during Google Sign-In: $error");
      isLoading(false);
    }
  }

  Future<void> signOut() async {
    Response response =
        await ApiClient.postData(ApiConstant.logOut, json.encode({}));
    if (response.statusCode == 200) {
      await _auth.signOut();
      await _googleSignIn.signOut();

      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.clear();
      await Get.offAllNamed(Routes.signInScreen);
      // Navigator.pushReplacementNamed(Get.context!, Routes.splashScreen);
      await di.init();
    } else {
      ApiChecker.checkApi(response);
    }
  }

  clearSharedData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    await _auth.signOut();
    await _googleSignIn.signOut();
  }
}
