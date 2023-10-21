import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../utils/app_icons.dart';
import '../../utils/color.dart';
import '../../utils/styles.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    this.prefixIcon,
    this.suffixIcon,
    required this.hintText,
    this.controller,
    this.validator,
    this.keyboardType,
    this.obscureText = false,
    this.readOnly=false,
    this.onTap,
    super.key,
  });

  Widget? prefixIcon;
  Widget? suffixIcon;
  bool obscureText;
  String hintText;
  TextInputType? keyboardType;
  TextEditingController? controller;
  String? Function(String?)? validator;
  bool readOnly;
  Function()? onTap;
  Function()? onTapPrefix;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            style: AppStyles.h3(),
            onTap:onTap,
            readOnly:readOnly,
            validator: validator,
            controller: controller,
            keyboardType:keyboardType ,
            obscureText: obscureText,
            decoration: InputDecoration(
              //fillColor: AppColors.bgColor,
              filled:false,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              labelStyle: AppStyles.h3(),
            //  labelStyle: AppStyles.h4(),
              labelText:readOnly?null:hintText,
             hintText:readOnly? hintText:null,
              contentPadding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 17.h),
              isDense: true,
            ),
          ),
        ),
        SizedBox(width:10.w,),
        GestureDetector(
          onTap:onTapPrefix,
          child: Container(
          padding: EdgeInsets.all(6.h),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape:BoxShape.circle,
              border: Border.all(
                color: Get.theme.dividerColor
              )
            ),
            child: Image.asset(AppIcons.iIcon,height:15.h,width: 15.h,color:Get.theme.iconTheme.color,),
          ),
        )
      ],
    );
  }


}



