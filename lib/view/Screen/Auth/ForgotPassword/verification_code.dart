
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:smg/controller/forgot_password_controller.dart';
import 'package:smg/utils/app_images.dart';

import '../../../../utils/color.dart';
import '../../../../utils/styles.dart';
import '../../../Widgets/custom_button.dart';


class VerificationCodeScreen extends StatelessWidget {
  VerificationCodeScreen({super.key});
  final _forgotController=Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    _forgotController.startTimer();
    // const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);


    final defaultPinTheme = PinTheme(
      width:50.w,
      height: 50.w,
      textStyle:  TextStyle(
        fontSize: 22.sp,

      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color:AppColors.borderColor),
      ),
    );
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal:20.w),
        child: Column(
          children: [
            SizedBox(height:15.h,),
            Text(
              "Verification Code",
              style: AppStyles.customSize(
                  size: 28.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(height:60.h,),
            SvgPicture.asset(
              AppImages.forgotPasswordImageSvg,
              fit: BoxFit.fill,
              height: 200.h,
              width: 225.w,
            ),
           SizedBox(height:60.h,),
            Directionality(
              // Specify direction if desired
              textDirection: TextDirection.ltr,
              child: Pinput(
                controller:_forgotController.pinController,
                focusNode:_forgotController.focusNode,
                defaultPinTheme: defaultPinTheme,
                // validator: (value) {
                //   return value == '2222' ? null : 'Pin is incorrect';
                // },
                // onClipboardFound: (value) {
                //   debugPrint('onClipboardFound: $value');
                //   pinController.setText(value);
                // },
                hapticFeedbackType: HapticFeedbackType.lightImpact,
                onCompleted: (pin) {

                  debugPrint('onCompleted: $pin');
                },
                onChanged: (value) {
                  debugPrint('onChanged: $value');
                },


              ),
            ),

            SizedBox(height:60.h,),
            Obx(
                  () => RichText(
                  text: TextSpan(
                      text: " ${_forgotController.timeShow.value}",
                      style: AppStyles.h5(fontWeight: FontWeight.w500,color:Colors.black),

                      children: [
                        TextSpan(
                          text:" resend confirmation code.",
                          style: AppStyles.h5(color: AppColors.greyColor),


                        ),

                      ])),
            ),
            SizedBox(height: 25.h,),
            CustomButton(title:"Confirm Code", onPressed: (){

            })

          ],
        ),
      ),
    );
  }
}