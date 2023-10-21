import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smg/utils/color.dart';
import 'package:smg/utils/styles.dart';
import 'package:smg/view/Widgets/custom_button.dart';
import 'package:smg/view/Widgets/auth_text_form_field.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
      ),
      backgroundColor:AppColors.bgColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal:16.w),
        child: Column(
          children: [
            SizedBox(height: 83.h,),
            Text("Create Account",style:AppStyles.h1(fontWeight:FontWeight.w700,letterSpacing: -0.3 ),),
            SizedBox(height:29.h,),
            AuthTextFormField(hintText:"Enter your name",prefixIcon:Icon(Icons.person,color: AppColors.mainColor,),),
            SizedBox(height:15.h,),
            AuthTextFormField(hintText:"Enter your email",prefixIcon:Icon(Icons.email,color: AppColors.mainColor,),),
            SizedBox(height:15.h,),
            AuthTextFormField(hintText:"Enter your password",
              obscureText: true,
              prefixIcon:Icon(Icons.lock,color: AppColors.mainColor,),),
            SizedBox(height:15.h,),
            AuthTextFormField(hintText:"Enter your confirm password",obscureText: true,prefixIcon:Icon(Icons.lock,color: AppColors.mainColor,),),
            SizedBox(height:40.h,),
            CustomButton(title:"Sign up",
                width:double.infinity,
                height: 44.h,
                onPressed:(){

            }),
            SizedBox(
              height: 25.h,
            ),
            RichText(text:TextSpan(
                text:"Already have an account? ",style: AppStyles.h4(color:Colors.black),
                children: [
                  TextSpan(
                      text: "Sign In!",
                      style: AppStyles.h4(fontWeight: FontWeight.w500,color:AppColors.mainColor),
                      recognizer:TapGestureRecognizer()..onTap=(){
                        Get.back();
                      }
                  ),
                ]
            ),

            )


          ],
        ),
      ),

    );
  }
}
