import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smg/utils/color.dart';
import 'package:smg/utils/styles.dart';
import 'package:smg/view/Screen/SettingScreen/Screen/LanguageTest/add_english_test.dart';
import 'package:smg/view/Widgets/custom_loader.dart';
import 'package:smg/view/Widgets/delete_confirmation_dialog.dart';
import 'package:smg/view/Widgets/no_internet_screen.dart';
import 'Controller/english_test_controller.dart';

class LanguageScreen extends StatelessWidget {
   LanguageScreen({super.key});
   final _languageCtrl=Get.put(AddEnglishTestController());

  @override
  Widget build(BuildContext context) {
  //  _languageCtrl.getAllLanguage();
    return Scaffold(
      appBar: AppBar(title: const Text("Language Test"),),
      body: Obx(()=>_languageCtrl.isLoading.value?const CustomLoader()
        :_languageCtrl.isNetworkError.value?NoInternetScreen(onTap:(){
          _languageCtrl.getAllLanguage();
        }) :SingleChildScrollView(
          child: Column(
            children: [
              ///<---------------- English Test--------------->
              SizedBox(height:15.h,),
              Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Text(
                      "Add Language",
                      style: AppStyles.h1(
                          fontWeight: FontWeight.w600,
                          color: AppColors.greyColor),
                    ),
                  )),
                  TextButton(
                      onPressed:(){
                        Get.to(AddEnglishTest());
                      },
                      child: Text("Add New",style: AppStyles.h4(color:Colors.redAccent),)),


                ],
              ),

              ListView.separated(
                shrinkWrap: true,
                 itemCount: _languageCtrl.allLanguageTest.length,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 15.h),
                itemBuilder: (context,index){
                  var language= _languageCtrl.allLanguageTest[index];
                return Container(
                    padding: EdgeInsets.symmetric(horizontal:13.w,vertical: 10.h),
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
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 5.h,),
                              Text(
                                language.name,
                                style: AppStyles.h3(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              if(language.pivot.score!=null)
                              Text(
                                "Score : ${language.pivot.score}",
                                style: AppStyles.h4(color: AppColors.greyColor),
                              ),
                              if(language.pivot.level!="")
                              Text(
                                "Level : ${language.pivot.level}",
                                style: AppStyles.h4(color: AppColors.greyColor),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: (){

                            showDialog(context: context, builder:(context)=>DeleteConfirmationDialog(title:"Delete Language Test", subTitle:"Are you sure want to delete language test?", onTapYes:(){
                              _languageCtrl.deleteLanguage(language.id,index);
                            }));


                          },
                          child: Icon(
                            Icons.delete,
                            size: 25.sp,
                            color: Colors.red.withOpacity(0.7),
                          ),
                        )
                      ],
                    ),
                  );

              }, separatorBuilder: (context,index){
                return SizedBox(height:10.h,);
              }, ),




               ///<---------------- Other Test--------------->
              // Row(
              //   children: [
              //     Expanded(
              //         child: Padding(
              //       padding: EdgeInsets.symmetric(horizontal: 16.w),
              //       child: Text(
              //         "Other Language Test",
              //         style: AppStyles.h1(
              //             fontWeight: FontWeight.w600,
              //             color: AppColors.greyColor),
              //       ),
              //     )),
              //     TextButton(
              //         onPressed: () {
              //           Get.to(AddOtherLanguageTest());
              //         },
              //         child: Text(
              //           "Add New",
              //           style: AppStyles.h4(color: Colors.redAccent),
              //         )),
              //     SizedBox(
              //       width: 8.w,
              //     )
              //   ],
              // ),
              //    ListView.separated(
              //   shrinkWrap: true,
              //   physics: const NeverScrollableScrollPhysics(),
              //   padding: EdgeInsets.symmetric(horizontal: 16.w),
              //   itemBuilder: (context,index){
              //   return Container(
              //       padding: EdgeInsets.symmetric(horizontal:13.w,vertical: 10.h),
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(5.r),
              //         color:Get.theme.cardColor,
              //         boxShadow: [
              //           BoxShadow(
              //             blurRadius: 5,
              //             color: AppColors.black.withOpacity(0.06)
              //           )
              //         ]
              //       ),
              //       child: Row(
              //
              //         children: [
              //           Expanded(
              //             child: Column(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 SizedBox(height: 5.h,),
              //                 Text(
              //                   "IELTS",
              //                   style: AppStyles.h3(
              //                     fontWeight: FontWeight.w500,
              //                   ),
              //                 ),
              //                 Text(
              //                   "Score : 6",
              //                   style: AppStyles.h4(color: AppColors.greyColor),
              //                 ),
              //                 Text(
              //                   "Level : A1",
              //                   style: AppStyles.h4(color: AppColors.greyColor),
              //                 ),
              //
              //               ],
              //             ),
              //           ),
              //
              //           Icon(
              //             Icons.delete,
              //             size: 25.sp,
              //             color: Colors.red.withOpacity(0.7),
              //           )
              //         ],
              //       ),
              //     );
              //
              // }, separatorBuilder: (context,index){
              //   return SizedBox(height:10.h,);
              // }, itemCount: 2),


              SizedBox(
                height: 10.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
