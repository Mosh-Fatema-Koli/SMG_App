

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_icons.dart';
import '../../utils/color.dart';

class PremiumIcon extends StatelessWidget {
  const PremiumIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.goldenColor),
          borderRadius: BorderRadius.circular(5.r),
          color:  AppColors.darkBgColor.withOpacity(0.6),
        ),
        padding: EdgeInsets.symmetric(horizontal:3.h, vertical:3.h),
        child: Image.asset(
          AppIcons.crownIcon,
          height:15.h,
          width: 15.h,
        ));
  }
}


