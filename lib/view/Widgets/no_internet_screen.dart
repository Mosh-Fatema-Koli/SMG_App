
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:smg/utils/color.dart';
import 'package:smg/utils/styles.dart';
import 'package:smg/view/Widgets/drawer.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key,required this.onTap});

    final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/icons/no_internet.json',
            width: 200.h,
            height: 200.h,
            fit: BoxFit.fill,
          ),
          Text(
            "Whoops!!",
            style: AppStyles.h1(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child: Text(
              "No Internet connection was found. Check your connection or try again.",
              style: AppStyles.h3(),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 40.h,
          ),
          GestureDetector(
            onTap: onTap,
            child: Container(
              height: 44.h,
              width: Get.width * 0.8,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.r),
                      topRight: Radius.circular(12.r),
                      bottomLeft: Radius.circular(12.r),
                      bottomRight: Radius.circular(30.r)),
                      boxShadow: [
                       BoxShadow(
                      color:Get.theme.primaryColor.withOpacity(0.3),
                      blurRadius: 4.0,
                      offset: const Offset(0.0, 5.0)),
                      ],
                  color: AppColors.mainColor),
                  alignment: Alignment.center,
                  child: Text("Try again",style: AppStyles.h3(fontWeight: FontWeight.w500,color: Colors.white),),
            ),
          )
        ],
      ),
    );
  }
}
