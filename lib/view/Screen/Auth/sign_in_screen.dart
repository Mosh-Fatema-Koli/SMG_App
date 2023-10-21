import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smg/controller/auth_controller.dart';
import 'package:smg/utils/app_icons.dart';
import 'package:smg/utils/app_images.dart';
import 'package:smg/utils/color.dart';
import 'package:smg/utils/styles.dart';
import 'package:smg/view/Widgets/custom_button.dart';
import 'package:smg/view/Widgets/custom_loader.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});
  final _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Obx(() => _authController.isLoading.value
              ? const CustomLoader()
              : Stack(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      Image.asset("assets/images/login.jpg",height:Get.height,width: Get.width,fit: BoxFit.fill,)
                 , 
                  Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      SizedBox(height:120.h,),
                          Text(
                            "Welcome Back!",
                            style: AppStyles.customSize(
                                fontWeight: FontWeight.w700,
                               
                                size: 34.sp,color: Colors.black),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            "Sign in to continue",
                            style: AppStyles.h3(color: Colors.black),
                          ),
                          SizedBox(
                            height: 50.h,
                          ),
                          Center(
                            child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    minimumSize: Size(200.w, 50.h),
                                    maximumSize: Size(250.w, 50.h),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.r)),
                                    side: BorderSide(
                                        color: AppColors.borderColor)),
                                onPressed: () {
                                  _authController.handleSignIn();
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      AppIcons.google,
                                      height: 25.w,
                                      width: 25.w,
                                      fit: BoxFit.fill,
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Text(
                                      "Sign in with google",
                                      style: AppStyles.h4(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  ],
                                )))
                    
                  ],
                )
                ]
                )

          ),
    );
  }
}
