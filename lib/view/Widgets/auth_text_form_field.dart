import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../utils/color.dart';
import '../../utils/styles.dart';

class AuthTextFormField extends StatelessWidget {
  AuthTextFormField({
    this.prefixIcon,
    required this.hintText,
    this.controller,
    this.validator,
    this.obscureText = false,
    super.key,
  });

  Widget? prefixIcon;
  bool obscureText;
  String hintText;
  TextEditingController? controller;
  String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: AppStyles.h4(),
      validator: validator,
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        fillColor: AppColors.bgColor,
        filled: false,
        prefixIcon: prefixIcon,
        labelStyle: AppStyles.h4(),
        labelText: hintText,
       contentPadding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 12.h),
       isDense: true,
        constraints: BoxConstraints(
          maxHeight: 44.h
        ),
        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(50.r), // Adjust the border radius as needed
          borderSide: BorderSide.none, // Remove the border
        ),
      ),
    );
  }
}
