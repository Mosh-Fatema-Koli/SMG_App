import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:smg/controller/splash_controller.dart';
import 'package:smg/utils/app_icons.dart';
import 'package:smg/utils/color.dart';

class SplashScreen extends StatelessWidget {
   SplashScreen({super.key});
  final _splashController =Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    _splashController.jumpToNextPage();
    return Scaffold(
      body: Center(
        child: Padding(
          padding:EdgeInsets.all(16.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                AppIcons.splashLottie,
                fit: BoxFit.fill,
              ),
            ],
          ),
        ),
      ),
      // body: Container(
      //   height:Get.height,
      //   width: Get.width,
      //   decoration:  BoxDecoration(
      //     gradient: LinearGradient(
      //   colors:[
      //     AppColors.mainColor.withOpacity(0.5),
      //     AppColors.mainColor
      //     ])
      //   ),
      //   child: Center(
      //     child: Image.asset(AppIcons.appLogo,height:200.h,width: 200.h,fit: BoxFit.fill,),
      //   ),
      // ),

    );
  }
}
