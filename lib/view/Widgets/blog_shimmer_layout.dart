import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class BlogShimmerList extends StatelessWidget {
  const BlogShimmerList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16.w,vertical:15.h),
      itemBuilder:(context ,index){
      return Shimmer.fromColors(baseColor:Colors.grey.withOpacity(0.6),
    highlightColor:Colors.grey.withOpacity(0.3),
    child:Container(
      height: 120.h,

      padding: EdgeInsets.symmetric(horizontal: 10.h,vertical: 10.h),
      child: Row(
        children: [
          Container(
            height: 100.h,
            width: 100.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.r),
              color: Colors.grey.withOpacity(0.6)
            ),
          ),
          SizedBox(width:10.w,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height:20.h,
                  width:double.maxFinite ,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      color: Colors.grey.withOpacity(0.6)
                  ),
                ),

                Container(
                  height:20.h,
                  width:220.w ,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: Colors.grey.withOpacity(0.6)
                  ),
                ),

                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height:18.h,

                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            color: Colors.grey.withOpacity(0.6)
                        ),
                      ),
                    ),
                    SizedBox(width:10.w,),
                    Expanded(
                      child: Container(
                        height:18.h,

                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            color: Colors.grey.withOpacity(0.6)
                        ),
                      ),
                    ),
                    SizedBox(width:10.w,),
                    Expanded(
                      child: Container(
                        height:18.h,

                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            color: Colors.grey.withOpacity(0.6)
                        ),
                      ),
                    ),

                  ],
                )


              ],
            ),
          ),







        ],
      ),
    ));
    }, separatorBuilder:(context,index){
      return SizedBox(height: 20.h,);
    }, itemCount:5);
  }
}