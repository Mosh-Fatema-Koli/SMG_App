import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:smg/controller/theme_controller.dart';
import 'package:smg/utils/app_icons.dart';
import 'package:smg/utils/app_images.dart';
import 'package:smg/utils/color.dart';
import 'package:smg/utils/styles.dart';

class CustomDrawer extends StatelessWidget {
   CustomDrawer({super.key});
    final _themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(()=>Drawer(
      backgroundColor:_themeController.isDarkTheme.value?AppColors.darkBgColor:Colors.white,
      child:
         Column(
          children: [
        
            SizedBox(
              height:50.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AppIcons.appLogo,height: 50.w,width:50.w,),
                Text("Study Portal",style:TextStyle(fontWeight: FontWeight.w700,fontSize:20.sp,fontStyle:FontStyle.italic),)
              ],
            ),
            SizedBox(
              height:20.h,
            ),
            Container(
              height:100.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomRight,
                  colors: [ AppColors.mainColor,const Color(0xFF047dc4)],
                )
              ),
              child:Row(
               
                children: [
                 Container(
                  height: 60.w,
                  width: 60.w,
                  margin: EdgeInsets.symmetric(horizontal:16.w),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.darkBgColor.withOpacity(0.5),
                    border: Border.all(
                      color: AppColors.bgColor,
                      width: 3,
                      
                    ),
                    image: DecorationImage(image: AssetImage(AppIcons.person),fit: BoxFit.fill),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 25,
                        color:AppColors.shadowColor,
                      )
                    ]
      
                  ),
                 ),
                 Expanded(child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    
                    Text("Palash Chandra Barman",style:AppStyles.h4(fontWeight: FontWeight.w500,color:Colors.white),maxLines: 1,overflow: TextOverflow.ellipsis,),
                    Text("palash900202@gmail.com",style:AppStyles.h5(color:Colors.white),maxLines: 1,overflow: TextOverflow.ellipsis,),
                  ],
                 ))
      
      
                ],
              ),
            ),
            SizedBox(height:20.h,),
            _customListTile(icon:AppIcons.profileSvg, title:'My Profile'),
            _customListTile(
              icon:AppIcons.sunSvg, 
              title:'Dark Mode', 
             onTap:(){
                            _themeController.setDarkTheme(!_themeController.isDarkTheme.value);
                          },
            
            trailing: Switch(value:_themeController.isDarkTheme.value, onChanged: (val) {
                           _themeController.setDarkTheme(val);
                          })),
            _customListTile(icon:AppIcons.savedSvg, title:'Wishlist'),
            _customListTile(icon:AppIcons.helpSupportSvg, title: 'Help & Support'),
            _customListTile(icon:AppIcons.privacyPolicySvg, title: 'Privacy Policy'),
            _customListTile(icon:AppIcons.aboutUsSvg, title: 'About Us'),
            _customListTile(icon:AppIcons.logoutSvg, title: 'Log Out',isLogOut:true),
            
      
      
              const Spacer(),
               Container(
                height:90.h,
                width: double.infinity,
                decoration: BoxDecoration(
             image: DecorationImage(image:AssetImage(AppImages.drawerHeader,),fit: BoxFit.fill,)
              ),
              ),
      
            
      
      
      
      
          ],
        ),
      ),
    );
  }
  _customListTile({required String icon,required String title,Widget? trailing,Function()? onTap,bool isLogOut=false}) {
    return
          ListTile(
          onTap: onTap,
                dense: true,
                minVerticalPadding: 0,
                minLeadingWidth: 0,
                contentPadding: EdgeInsets.only(left: 16.w),
                horizontalTitleGap: 16.w,
                visualDensity: const VisualDensity(
                  vertical: -2
                ),
                leading: SvgPicture.asset(icon,height: 25.h,width: 25.h,fit: BoxFit.fill,color:isLogOut?Colors.redAccent :_themeController.isDarkTheme.value?AppColors.darkIconColor:AppColors.iconColor ),
                title:Text(title,style:isLogOut?AppStyles.h4(color: Colors.redAccent):AppStyles.h4(),),
                trailing:trailing,
       
           
       );
  }
}