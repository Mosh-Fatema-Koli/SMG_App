
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../utils/app_icons.dart';
import '../../utils/color.dart';
import '../../utils/styles.dart';

class PremiumLogo extends StatelessWidget {
  const PremiumLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.goldenColor, width:1.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              height: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.r),
                    bottomLeft: Radius.circular(10.r)),
                color:
                AppColors.darkBgColor
                ,
              ),
              padding: EdgeInsets.symmetric(
                  horizontal: 3.w, vertical:2.h),
              child: Image.asset(
                AppIcons.crownIcon,
                height:40.h,
                width: 40.h,
              )),

          Container(
            height:double.infinity,
            width:1.5,
            color: AppColors.goldenColor,
          ),
          Container(
            height: double.infinity,
            decoration: BoxDecoration(
                color: Get.isDarkMode
                    ? AppColors.darkBgColor
                    : AppColors.goldenColor,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.r),
                    bottomRight: Radius.circular(10.r)
                )
            ),
            alignment: Alignment.center,
            child: Padding(
                padding: EdgeInsets.only(right: 8.w, left: 8.w),
                child: Text("Premium",
                    style: AppStyles.h3(
                      fontWeight: FontWeight.w600,
                      color: Get.isDarkMode
                          ? const Color(0xFFFFD700)
                          : Colors.black,
                    ))),
          )
        ],
      ),
    );
  }
}


