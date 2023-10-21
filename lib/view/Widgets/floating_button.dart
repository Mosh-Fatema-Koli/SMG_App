import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smg/utils/color.dart';

import '../../routes/routes.dart';
import '../../utils/app_icons.dart';

class FabFloatingButton extends StatelessWidget {
  const FabFloatingButton({
    super.key,
    this.mode
  });
  final bool? mode;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Get.toNamed(Routes.studyMatchScreen);
      },
      elevation: 0,
      backgroundColor:Get.theme.canvasColor,
   //    foregroundColor: Colors.black,
      child: Container(
        height: 70.sp,
        width: 70.sp,
        padding: EdgeInsets.all(10.sp),
        decoration: BoxDecoration(
          color:mode==null?Get.theme.canvasColor:mode==true?const Color(0xFF2c2c2c):Colors.white,
         // borderRadius:  BorderRadius.all(Radius.circular(50.r)),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 3,
              blurRadius: 3,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Image.asset(AppIcons.studyMatch,fit: BoxFit.fill,),
      ),
    );
  }
}

