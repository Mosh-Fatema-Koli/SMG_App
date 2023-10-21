import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smg/controller/study_match_controller.dart';
import 'package:smg/utils/color.dart';
import 'package:smg/utils/styles.dart';
import 'package:smg/view/Screen/StudyMatchDetails/study_match_details.dart';
import 'package:smg/view/Widgets/no_internet_screen.dart';
import 'package:smg/view/Widgets/study_match_shimmer_layout.dart';

import '../../Widgets/bottom_menu.dart';
import '../../Widgets/custom_loader.dart';
import '../../Widgets/floating_button.dart';
import 'package:smg/model/study_match_model.dart';

class StudyMatch extends StatelessWidget {
  StudyMatch({super.key});
  final _controller = Get.put(StudyMatchController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Study Match"),
          leading: const SizedBox(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: const FabFloatingButton(),
        bottomNavigationBar: const BottomMenu(5),
        body: Obx(
          () => _controller.isFirstLoadRunning.value
              ? const StudyMatchShimmerList()
              :_controller.isNetWorkError.value?
          NoInternetScreen(onTap:(){
                _controller.fastLoad();
              })

              :RefreshIndicator(
                  onRefresh: () async {
                    await _controller.refreshData();
                  },
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if(_controller.isShowDialog.value)
                        Container(
                          margin: EdgeInsets.only(left: 16.w,right: 16.w,top: 10.h),
                          padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.r),
                            border: Border.all(
                                color:Get.theme.dividerColor
                            ),
                            color:AppColors.mainColor.withOpacity(0.2),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child:Text("Please update your profile to get university match",style: AppStyles.h3(),)),
                              GestureDetector(
                                  onTap: (){
                                    _controller.isShowDialog.value=false;
                                  },
                                  child: Icon(Icons.close,size:15.sp,))
                            ],
                          ),
                        ),
                       
                        ListView.separated(
                            controller: _controller.scrollController,
                            padding:
                                EdgeInsets.only(top: 15.h, left: 16.w, right: 16.w),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              if (index < _controller.groupedMatch.length) {
                                final date =
                                    _controller.groupedMatch.keys.elementAt(index);
                                final matchForDate = _controller.groupedMatch[date];
                                final now = DateTime.now();
                                final today = DateTime(now.year, now.month, now.day);

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        margin: EdgeInsets.symmetric(
                                          vertical: 3.h,
                                        ),
                                        child: Text(today == date
                                            ? "Today"
                                            : Jiffy.parseFromList(
                                                    [date.year, date.month, date.day])
                                                .yMMMMd)),
                                    Column(
                                      children: matchForDate!.map((value) {
                                        return studyMatchCard(value,(){
                                          Get.to(StudyMatchDetails(id:value.id!),transition: Transition.rightToLeft);
                                        });
                                      }).toList(),
                                    ),
                                  ],
                                );
                              } else {
                                if (_controller.isLoadMoreRunning.value) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else {
                                  return const SizedBox();
                                }
                              }
                            },
                            separatorBuilder: (context, index) {
                              return Container(
                                  // width: double.infinity,
                                  // height: 0.5,
                                  // color:Get.theme.dividerColor,
                                  );
                            },
                            itemCount: _controller.groupedMatch.length + 1),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  Widget studyMatchCard(MatchModel match, Function()? onTap ) {
    return GestureDetector(
      onTap:onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        margin: EdgeInsets.symmetric(vertical: 5.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.r),
            boxShadow: [
              BoxShadow(
                  blurRadius: 2,
                  spreadRadius: 0,
                  offset: const Offset(0, 1),
                  color: const Color(0xFF393F4A).withOpacity(0.15))
            ],
            color: Get.theme.cardColor),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl:
                 match.notice!.thumbnailFullUrl!,
              imageBuilder: (context, imageProvider) => Container(
                height: 55.h,
                width: 55.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.r),
                    image:
                        DecorationImage(image: imageProvider, fit: BoxFit.cover)),
              ),
              placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey.withOpacity(0.6),
                  highlightColor: Colors.grey.withOpacity(0.35),
                  child: Container(
                    height: 55.h,
                    width: 55.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.r),
                        color: Colors.grey.withOpacity(0.5)),
                  )),
              errorWidget: (context, url, error) => Container(
                height: 55.h,
                width: 55.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.r),
                    color: Colors.grey.withOpacity(0.4)),
              ),
            ),
            SizedBox(
              width: 16.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    match.notice!.department!.name!,
                    style: AppStyles.h3(fontWeight: FontWeight.w500),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    match.notice!.university!.title!,
                    style: AppStyles.h4(color: AppColors.greyColor),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height:5.h,),
                  Row(
                    children: [
                      CachedNetworkImage(
                        imageUrl:match.notice!.university!.country.flag,
                        placeholder:(context, url) => Shimmer.fromColors(
                            baseColor: Colors.grey.shade700,
                            highlightColor: Colors.grey.shade400,
                            child:Container(
                              height: 20.w,
                              width: 30.w,
                              decoration:  BoxDecoration(
                                borderRadius: BorderRadius.circular(4.r)
                              ),
                            )
                        ) ,
                        errorWidget: (context, url, error) => Container(
                          // height: 20.w,
                          // width: 30.w,
                          // decoration:  BoxDecoration(
                          //     borderRadius: BorderRadius.circular(4.r),
                          //     color: AppColors.greyColor.withOpacity(0.5)
                          // ),
                        ),
                        imageBuilder: (context, imageProvider) =>
                            Container(
                              height: 20.w,
                              width: 30.w,
                              margin: EdgeInsets.only(right: 10.w),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.r),
                                  color: AppColors.greyColor,
                                  border: Border.all(
                                    width: 0.5,

                                  ),
                                  image: DecorationImage(image: imageProvider,fit: BoxFit.cover)
                              ),
                            ),

                      ),

                      Expanded(child: Text(match.notice!.university!.country.name,style: AppStyles.h4(),maxLines: 1,overflow: TextOverflow.ellipsis,)),
                      Expanded(child:Text("${match.notice!.minBudget.toString()} USD/Year",textAlign: TextAlign.right,style: AppStyles.h4(color: AppColors.mainColor),))

                  ],)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
