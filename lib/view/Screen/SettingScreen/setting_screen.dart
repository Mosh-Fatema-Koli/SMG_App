import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:smg/controller/auth_controller.dart';
import 'package:smg/controller/data_controller.dart';
import 'package:smg/controller/profile_controller.dart';
import 'package:smg/controller/theme_controller.dart';
import 'package:smg/routes/routes.dart';
import 'package:smg/utils/app_icons.dart';
import 'package:smg/utils/color.dart';
import 'package:smg/utils/styles.dart';

import '../../Widgets/bottom_menu.dart';
import '../../Widgets/floating_button.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});
  final _themeController = Get.find<ThemeController>();
  final _dataController =Get.put(DataController());
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Setting"),
            leading: const SizedBox(),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton:   Obx(()=>FabFloatingButton(mode:_themeController.isDarkTheme.value,)),
          bottomNavigationBar: const BottomMenu(1),
          body:SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),

              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 10.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            color: _themeController.isDarkTheme.value
                                ? AppColors.darkCardColor
                                : AppColors.cardColor,
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 0,
                                  blurRadius: 25,
                                  offset: const Offset(0, 5),
                                  color: const Color(0xFF414138).withOpacity(0.2))
                            ]),
                        child: Row(
                          children: [
                           CachedNetworkImage(
                           imageUrl: _dataController.image.value,
                            imageBuilder: (context, imageProvider) => Container(
                                width: 40.w,
                              height: 40.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                    ),
                              ),
                            ),
                            placeholder:(context ,url){
                              return  Container(
                              width: 40.w,
                              height: 40.w,
                              decoration: BoxDecoration(
                                  image: DecorationImage(image: 
                                  AssetImage(AppIcons.person)),
                                  shape: BoxShape.circle
                                  
                                  ),
                             
                            );
                            },
                            errorWidget: (context, url, error) =>  Container(
                              width: 40.w,
                              height: 40.w,
                              decoration: BoxDecoration(
                                  image: DecorationImage(image: 
                                  AssetImage(AppIcons.person)),
                                  shape: BoxShape.circle
                                  
                                  ),
                             
                            ),
                          ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                          
                                Text(
                                  _dataController.name.value,
                                  style:
                                      AppStyles.h3(fontWeight: FontWeight.w500),
                                ),
                              ],
                            )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      _listTile(
                          onTap: () {
                            Get.toNamed(Routes.personalInformation);
                          },
                          title:'Personal Information',
                          icon: AppIcons.profileSvg),
                      _listTile(
                          onTap: () {
                            Get.toNamed(Routes.savedBlogScreen);
                          },
                          title:'Saved Blog',
                          icon: AppIcons.savedSvg),
                      _listTile(
                          onTap: () {
                              Get.toNamed(Routes.educationScreen);
                          },
                          title:'Education',
                          icon: AppIcons.education),
                      _listTile(
                          onTap: () {
                            Get.toNamed(Routes.destination);
                          },
                          title:'Desired Destination',
                          icon: AppIcons.destination),
                      _listTile(
                          onTap: () {
                            Get.toNamed(Routes.language);
                          },
                          title:'Language Test',
                          icon:AppIcons.language),
                      _listTile(
                          title:'Dark Mode',
                          onTap: () {
                            _themeController.setDarkTheme(
                                !_themeController.isDarkTheme.value);
                          },
                          icon: AppIcons.sunSvg,
                          trailing: Container(
                            height: 10,
                            width: 10,
                            margin: EdgeInsets.only(right: 15.w),
                            child: Switch(
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                value: _themeController.isDarkTheme.value,
                                onChanged: (val) {
                                  _themeController.setDarkTheme(val);
                                }),
                          )),
                      _listTile(
                          icon: AppIcons.privacyPolicySvg,
                          title:'Privacy & Policy'),
                      _listTile(
                          icon: AppIcons.helpSupportSvg, title: 'Help & Support'),
                      _listTile(title: "About Us", icon: AppIcons.aboutUsSvg),
                      _listTile(
                          onTap: () {
                        //    Get.put(AuthController()).signOut();
                            showDialog(context: context, builder: (context)=>AlertDialog(
                              title: Text("Confirm logout",style: AppStyles.h2(fontWeight: FontWeight.w600),),
                              content: Text("Do you want to log out?",style: AppStyles.h4(color: AppColors.greyColor),),
                              actions: [
                                OutlinedButton(onPressed:(){
                                  Get.back();
                                }, child:const Text("No")),
                                SizedBox(width:10.w,),
                                OutlinedButton(onPressed:(){
                                  Get.put(AuthController()).signOut();
                                  Get.back();
                                }, child:const Text("Yes"))
                              ],

                            ));
                          },
                          title: "Log Out",
                          icon: AppIcons.logoutSvg),
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }


  _listTile(
      {required String title,
      String? icon,
      Widget? trailing,
      Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        margin: EdgeInsets.symmetric(vertical: 5.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.r),
            color: _themeController.isDarkTheme.value
                ? AppColors.darkCardColor
                : AppColors.cardColor,
            boxShadow: [
              BoxShadow(
                  spreadRadius: 0,
                  blurRadius:8,
                  offset: const Offset(0, 3),
                  color: const Color(0xFF414138).withOpacity(0.1))
            ]),
        child: Row(
          children: [
            SvgPicture.asset(
              icon!,
              color: _themeController.isDarkTheme.value?AppColors.darkIconColor:AppColors.iconColor,
              height: 25.h,
              width: 25.h,
            ),
            SizedBox(
              width: 10.w,
            ),
            Expanded(
                child: Text(
              title,
              style: AppStyles.h3(
                fontWeight: FontWeight.w600,
              ),
            )),
            trailing == null ? const SizedBox() : trailing!,
          ],
        ),
      ),
    );
    // return ListTile(
    //   onTap: onTap,
    //   dense: true,
    //   contentPadding: EdgeInsets.zero,
    //   minLeadingWidth: 0,
    //   minVerticalPadding: 0,
    //   visualDensity: const VisualDensity(horizontal: 0,vertical: -4),
    //   title: Text(
    //     title,
    //     style: AppStyles.h4(fontWeight: FontWeight.w500),
    //   ),
    //   trailing: trailing ??
    //       Icon(
    //         Icons.arrow_forward_ios_rounded,
    //         color:Get.theme.iconTheme.color,
    //         size: 15.sp,
    //       ),
    //   leading: SvgPicture.asset(icon!,height: 25.h,width: 25.h,fit: BoxFit.fill,color:_themeController.isDarkTheme.value?AppColors.darkIconColor:AppColors.iconColor ),
    //
    // );
  }
}
