import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smg/controller/notice_details_controller.dart';
import 'package:smg/utils/app_icons.dart';
import 'package:smg/utils/color.dart';
import 'package:smg/utils/styles.dart';
import 'package:smg/view/Widgets/custom_button.dart';
import 'package:smg/view/Widgets/custom_loader.dart';

class NoticeDetailsScreen extends StatelessWidget {
  NoticeDetailsScreen({super.key, required this.id, this.alertId});
  int id;
  int? alertId;
  final _noticeDetailsCtrl = Get.put(NoticesDetailsController());

  @override
  Widget build(BuildContext context) {
    print("=====> id = $id; alert id = $alertId");
    _noticeDetailsCtrl.getNoticeDetails(id, alertId);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
        // actions: [
        //   IconButton(
        //       onPressed: () {},
        //       icon: Image.asset(
        //         AppIcons.saveIcon,
        //         height: 20.h,
        //         width: 20.h,
        //         fit: BoxFit.fill,
        //       ))
        // ],
      ),
      body: Obx(
        () => _noticeDetailsCtrl.isLoading.value
            ? const CustomLoader():_noticeDetailsCtrl.dataModel==null?Container()
            : SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CachedNetworkImage(
                      imageUrl: _noticeDetailsCtrl.dataModel!.thumbnailFullUrl!,
                      height: 150.h,
                      width: double.infinity,
                      fit: BoxFit.fill,
                      placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: Colors.grey.shade800,
                          highlightColor: Colors.grey.shade700,
                          child: Container(
                            height: 150.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                color: Colors.grey.withOpacity(0.5)),
                          )),
                      errorWidget: (context, url, error) => Container(
                        height: 150.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            color: Colors.grey.withOpacity(0.5)),
                            child: Icon(Icons.error,color:Colors.red.withOpacity(0.9),),
                      ),
                    ),
                     SizedBox(
                      height: 10.h,
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _noticeDetailsCtrl.dataModel!.title!,
                            style: AppStyles.h1(fontWeight: FontWeight.w500),
                          ),
                          Text(
                            _noticeDetailsCtrl.dataModel!.university!.title!,
                            style: AppStyles.h3(
                                fontWeight: FontWeight.w500,
                                color: AppColors.greyColor),
                          ),
                          Text(
                            _noticeDetailsCtrl.dataModel!.country!.name!,
                            style: AppStyles.h4(
                                fontWeight: FontWeight.w500,
                                color: AppColors.greyColor),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),

                          ///< ------------ Cgpa -------------->
                          Row(
                            children: [
                              Image.asset(
                                AppIcons.gradeIcon,
                                height: 25.sp,
                                width: 25.sp,
                                color: Get.theme.iconTheme.color,
                                fit: BoxFit.fill,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                "Minimum CGPA : ${_noticeDetailsCtrl.dataModel!.minCgpa}",
                                style: AppStyles.h4(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blue),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 8.h,
                          ),

                          ///< ------------ Age -------------->
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_month_outlined,
                                size: 25.sp,
                              ),
                              // Image.asset(AppIcons.gradeIcon,height:25.sp,width:25.sp,color: Get.theme.iconTheme.color,fit: BoxFit.fill,),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                "Maximum Age : ${_noticeDetailsCtrl.dataModel!.maxAge} years",
                                style: AppStyles.h4(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blue),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 8.h,
                          ),

                          ///< ------------ minimum_budget -------------->
                          Row(
                            children: [
                              Icon(
                                Icons.monetization_on_outlined,
                                size: 25.sp,
                              ),
                              // Image.asset(AppIcons.gradeIcon,height:25.sp,width:25.sp,color: Get.theme.iconTheme.color,fit: BoxFit.fill,),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                "Education cost per year : ${_noticeDetailsCtrl.dataModel!.minBudget} USD",
                                style: AppStyles.h4(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blue),
                              )
                            ],
                          ),

                          SizedBox(
                            height: 15.h,
                          ),
                          Text(
                            "Summary",
                            style: AppStyles.h2(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            _noticeDetailsCtrl.dataModel!.summery!,
                            style: AppStyles.h4(color: AppColors.greyColor),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Text(
                            "Description",
                            style: AppStyles.h2(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            _noticeDetailsCtrl.dataModel!.description!,
                            style: AppStyles.h4(color: AppColors.greyColor),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          TextButton(
                              onPressed: () {},
                              child: Text(
                                "Visit the website",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.mainColor,
                                    decoration: TextDecoration.underline),
                              ))

                          // CustomButton(
                          //     title: "Visit the website", onPressed: () {
                          //       _noticeDetailsCtrl.launchURL(_noticeDetailsCtrl.dataModel.link);
                          // })
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
