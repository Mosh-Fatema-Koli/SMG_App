import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class StudyMatchShimmerList extends StatelessWidget {
  const StudyMatchShimmerList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16.w,vertical:15.h),
        itemBuilder:(context ,index){
          return Shimmer.fromColors(baseColor:Colors.grey.withOpacity(0.6),
              highlightColor:Colors.grey.withOpacity(0.3),
              child:SizedBox(
                height: 55.h,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 55.h,
                      width: 55.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          color: Colors.grey.withOpacity(0.6)
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height:14.h,
                            width:Get.width/1.5 ,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                color: Colors.grey.withOpacity(0.6)
                            ),
                          ),
                          SizedBox(
                            height:10.h,
                          ),
                          Container(
                            height:14.h,
                            width:Get.width/2,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                color: Colors.grey.withOpacity(0.6)
                            ),
                          ),

                        ],
                      ),
                    ),

                  ],
                ),
              ));
        }, separatorBuilder:(context,index){
      return SizedBox(height: 20.h,);
    }, itemCount:10);
  }
}