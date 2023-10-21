import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smg/model/profile_model.dart';
import 'package:smg/utils/app_icons.dart';
import 'package:smg/utils/color.dart';
import 'package:smg/utils/styles.dart';
import 'package:smg/view/Screen/SettingScreen/Screen/Education/Controller/education_controller.dart';
import 'package:smg/view/Screen/SettingScreen/Screen/Education/add_education.dart';
import 'package:smg/view/Widgets/custom_loader.dart';
import 'package:smg/view/Widgets/no_internet_screen.dart';

import '../../../../Widgets/delete_confirmation_dialog.dart';


class Education extends StatelessWidget {
   Education({super.key});
  final _controller=Get.put(EducationController());
  @override
  Widget build(BuildContext context) {
   _controller.getEducation();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Education"),
      ),
      body: Obx(()=>_controller.loading.value?const CustomLoader()
        :_controller.isNetworkError.value?NoInternetScreen(onTap:(){
          _controller.getEducation();
        }) :SingleChildScrollView(
          child: Column(
            children: [
              ///<---------------- education--------------->
              Row(
                children: [
                  Expanded(child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 16.w),
                    child: Text("Education",style: AppStyles.h1(fontWeight: FontWeight.w600,color: AppColors.greyColor),),
                  )),

                  TextButton(
                    onPressed:(){
                      Get.to(AddEducation());
                      },
                    child: Text("Add New",style: AppStyles.h4(color:Colors.redAccent),)),

              SizedBox(width:8.w,)

                ],
              ),
              SizedBox(height: 10.h,),
               ListView.separated(
                 itemCount:_controller.allEducation.length,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                   var degree=_controller.allEducation[index];
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal:10.w,vertical: 10.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.r),
                      color:Get.theme.cardColor,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 5,
                          color: Colors.black.withOpacity(0.06)
                        )
                      ]
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:  EdgeInsets.only(top: 2.h),
                          child: Image.asset(
                            AppIcons.university,
                            height: 40.h,
                            width: 40.h,
                            fit: BoxFit.fill,
                            color: AppColors.greyColor,
                          ),
                        ),
                        SizedBox(width: 10.w,),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      degree.name,
                                      style: AppStyles.h3(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    if(degree.pivot.scorePercentage!=null)
                                    Text(
                                      "Score Percentage : ${degree.pivot.scorePercentage}%",
                                      style: AppStyles.h4(color: AppColors.greyColor),
                                    ),
                                    if(degree.pivot.passingYear!=null)
                                    Text(
                                      "Passing year : ${degree.pivot.passingYear}",
                                      style: AppStyles.h4(color: AppColors.greyColor),
                                    ),
                                    if(degree.pivot.maxGpa!=null)
                                    Text(
                                      "Maximum Gpa :  ${degree.pivot.maxGpa}",
                                      style: AppStyles.h4(color: AppColors.greyColor),
                                    ),
                                    if(degree.pivot.minGpa!=null)
                                    Text(
                                      "Maximum Gpa : ${degree.pivot.minGpa}",
                                      style: AppStyles.h4(color: AppColors.greyColor),
                                    ),
                                    if(degree.pivot.gpa!=null)
                                    Text(
                                      "GPA :  ${degree.pivot.gpa}",
                                      style: AppStyles.h4(color: AppColors.greyColor),
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap:(){
                                  showDialog(context: context, builder:(context)=>DeleteConfirmationDialog(title:"Delete Education", subTitle: "Are you sure want to delete education", onTapYes:(){
                                    _controller.deleteEducation(degree.id, index);
                                  },));
                                },
                                child: Center(
                                  child: Container(
                                    padding: EdgeInsets.all(5.sp),
                                    alignment: Alignment.center,
                                    child: Icon(
                                      Icons.delete,
                                      size: 25.sp,
                                      color: Colors.red.withOpacity(0.7),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),


                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 15.h,);
                },
                )





            ],
          ),
        ),
      ),
    );
  }
}

