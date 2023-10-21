import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smg/model/study_match_model.dart';
import 'package:smg/utils/color.dart';
import 'package:smg/utils/styles.dart';

class MatchingReason extends StatelessWidget {
  const MatchingReason({super.key,required this.matchReason});
 final List<MatchReason>  matchReason;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Matching Reason"),),
      body:SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 15.h),
        child:Container(
          padding: EdgeInsets.symmetric(horizontal:10.w,vertical: 10.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.r),
            color:Get.theme.cardColor,
            boxShadow: [
              BoxShadow(
                blurRadius:5,
                color:Colors.black.withOpacity(0.15)
              )
            ]
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Your Matching Reason",style: AppStyles.h3(fontWeight: FontWeight.w700,color: AppColors.mainColor),),
              SizedBox(height:5.h,),
              ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder:(context,index){
                var data=matchReason[index];
                return Row(
                  children: [
                    Text("${data.reasonAttribute!} : ",style: AppStyles.h3(fontWeight: FontWeight.w600,color:AppColors.greyColor),),
                    Expanded(child:Text(data.reasonValue!,style: AppStyles.h4(),))
                  ],
                );

              }, separatorBuilder:(context,index){
                return SizedBox(height: 5.h,);
              }, itemCount:matchReason.length),
            ],
          ),


        )
        ,
      ),
    );
  }
}
