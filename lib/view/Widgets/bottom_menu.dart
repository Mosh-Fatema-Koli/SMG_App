import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smg/utils/color.dart';

import '../../routes/routes.dart';

class BottomMenu extends StatelessWidget {
  final int menuIndex;
  const BottomMenu(this.menuIndex, {super.key});
  Color colorByIndex(ThemeData theme, int index) {
    return index == menuIndex ? theme.primaryColor : theme.disabledColor;
  }

  BottomNavigationBarItem getItem(IconData selectIcon, IconData icon,
      String title, ThemeData theme, int index) {
    return BottomNavigationBarItem(
        label: title,
        icon: Icon(
          index == menuIndex ? selectIcon : icon,
          size: 24.h,
          color: colorByIndex(theme, index),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    List<BottomNavigationBarItem> menuItems = [

      getItem(Icons.home, Icons.home_outlined, 'Home', theme, 0),
    //  BottomNavigationBarItem(icon:SizedBox(),label: ""),
    //   getItem(,,'Inbox', theme,1),
     // getItem(Icons.account_balance, Icons.account_balance_outlined,
    //      'StudyMatch', theme, 1),
      getItem(Icons.settings, Icons.settings_outlined, 'Setting', theme, 2),

    ];

    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin:8,
       clipBehavior: Clip.antiAlias,
      color:Get.theme.canvasColor ,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: [
            Flexible(
              child: GestureDetector(
                onTap: (){
                  Get.toNamed(Routes.blogScreen);
                },
                child: Container(
                  padding:  EdgeInsets.symmetric(horizontal:15.w,vertical:15.h),
                //  margin: EdgeInsets.only(right: 15.w),
                  child:Icon(
                    menuIndex==0? Icons.home:Icons.home_outlined,
                    size: 30.h,
                    color: colorByIndex(theme, 0),
                  ),
                ),
              ),
            ),
            const SizedBox(),

            Flexible(
              child: GestureDetector(
                onTap: (){
                  Get.toNamed(Routes.settingScreen);
                },
                child: Container(
                  padding:  EdgeInsets.symmetric(horizontal:15.w,vertical:15.h),
                //  margin: EdgeInsets.only(left: 15.w),
                  child:  Icon(
                    menuIndex==1? Icons.settings:Icons.settings_outlined,
                    size: 30.h,
                    color: colorByIndex(theme, 1),
                  )
                ),
              ),
            ),


          ],
        ),
      // child: BottomNavigationBar(
      //   backgroundColor: Get.theme.canvasColor,
      //   type: BottomNavigationBarType.fixed,
      //   unselectedItemColor: AppColors.greyColor,
      //   selectedItemColor: Theme.of(context).primaryColor,
      //   currentIndex: menuIndex,
      //   onTap: (value) {
      //     switch (value) {
      //       case 0:
      //         Get.toNamed(Routes.blogScreen);
      //         break;
      //       // case 1:
      //       //   Get.toNamed(Routes.studyMatchScreen);
      //       //   break;
      //       case 2:
      //         Get.toNamed(Routes.settingScreen);
      //         break;
      //     // case 4:
      //     //   Get.offAndToNamed(Routes.profileScreen);
      //     //   break;
      //     }
      //   },
      //   items: menuItems,
      // )
    );
      // child: BottomNavigationBar(items:[
      //   BottomNavigationBarItem(icon:Icon(Icons.home,),label:""),
      // //  BottomNavigationBarItem(label: "", icon:SizedBox()),
      //   BottomNavigationBarItem(icon:Icon(Icons.settings),label: ""),
      // ]),
      // child: Row(
      //   children: [
      //     IconButton(onPressed: (){}, icon:Icon(Icons.home)),
      //     const Spacer(),
      //     IconButton(onPressed: (){}, icon:Icon(Icons.settings)),
      //
      //   ],
      // ),

    // );

    // return Container(
    //   decoration: BoxDecoration(
    //       borderRadius: BorderRadius.only(
    //           topRight: Radius.circular(15.r), topLeft: Radius.circular(15.r)),
    //       boxShadow: [
    //         BoxShadow(
    //             color: const Color(0xFF1D1E20).withOpacity(0.08),
    //             spreadRadius: 0,
    //             blurRadius: 20,
    //             offset: const Offset(0, -4))
    //       ]),
    //   child: ClipRRect(
    //     borderRadius: BorderRadius.only(
    //         topRight: Radius.circular(15.r), topLeft: Radius.circular(15.r)),
    //     child: Theme(
    //       data: ThemeData(
    //         splashColor: Colors.transparent,
    //         highlightColor: Colors.transparent,
    //       ),
    //       child: BottomNavigationBar(
    //         backgroundColor: Get.theme.canvasColor,
    //         type: BottomNavigationBarType.fixed,
    //         unselectedItemColor: AppColors.greyColor,
    //         selectedItemColor: Theme.of(context).primaryColor,
    //         currentIndex: menuIndex,
    //         onTap: (value) {
    //           switch (value) {
    //             case 0:
    //               Get.toNamed(Routes.blogScreen);
    //               break;
    //             case 1:
    //               Get.toNamed(Routes.studyMatchScreen);
    //               break;
    //             case 2:
    //               Get.toNamed(Routes.settingScreen);
    //               break;
    //             // case 4:
    //             //   Get.offAndToNamed(Routes.profileScreen);
    //             //   break;
    //           }
    //         },
    //         items: menuItems,
    //       ),
    //     ),
    //   ),
    // );
  }
}
