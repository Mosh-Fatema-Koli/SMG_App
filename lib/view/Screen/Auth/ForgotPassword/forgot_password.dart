import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:smg/view/Screen/Auth/ForgotPassword/verification_code.dart';

import '../../../../utils/app_images.dart';
import '../../../../utils/color.dart';
import '../../../../utils/styles.dart';
import '../../../Widgets/custom_button.dart';
import '../../../Widgets/auth_text_form_field.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
      ),
      backgroundColor: AppColors.bgColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            SizedBox(
              height: 30.h,
            ),
            Text(
              "Forget Password",
              style: AppStyles.h1(
                  fontWeight: FontWeight.w700, letterSpacing: -0.3),
            ),
            SizedBox(height:60.h,),
            SvgPicture.asset(
              AppImages.forgotPasswordImageSvg,
              fit: BoxFit.fill,
              height: 200.h,
              width: 225.w,
            ),
            SizedBox(height:40.h,),
            AuthTextFormField(
              hintText: "Enter your email",
              prefixIcon: Icon(
                Icons.email,
                color: AppColors.mainColor,
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            CustomButton(
                title: "Submit",
                width: double.infinity,
                height: 44.h,
                onPressed: () {
                  Get.to(VerificationCodeScreen());
                }),
          ],
        ),
      ),
    );
  }
}
