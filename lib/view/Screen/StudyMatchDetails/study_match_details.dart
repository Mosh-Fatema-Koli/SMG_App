import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smg/utils/app_icons.dart';
import 'package:smg/utils/color.dart';
import 'package:smg/utils/styles.dart';
import 'package:smg/view/Screen/StudyMatchDetails/matching_reason.dart';
import 'package:smg/view/Widgets/custom_loader.dart';
import 'package:smg/view/Widgets/no_internet_screen.dart';

import '../../../controller/study_match_details_controller.dart';
import '../../../model/study_match_model.dart';
import '../WebView/web_view.dart';

class StudyMatchDetails extends StatelessWidget {
   StudyMatchDetails({super.key,required this.id});
 final  int  id;
 final _matchDetailsController =Get.put(StudyMatchDetailsController());

  @override
  Widget build(BuildContext context) {
    _matchDetailsController.getMatch(id);
    return Scaffold(
      appBar: AppBar(
        title:Obx(()=>_matchDetailsController.isLoading.value?Container():_matchDetailsController.isNetWorkError.value?Container(): Text(_matchDetailsController.matchData.value.notice!.university!.title!,maxLines:1,overflow: TextOverflow.ellipsis,)),
      ),
      bottomNavigationBar:Container(
        color: Get.theme.canvasColor,
        padding:  EdgeInsets.only(bottom: 5.h,top: 5.h),
        child: Obx(()=>
           Row(
            mainAxisAlignment:MainAxisAlignment.spaceAround,
            children: [

              Expanded(child:_rectRating(ontap:(){
                if(_matchDetailsController.matchData.value.isRated==1){
                  // unrated
                  _matchDetailsController.unRated(_matchDetailsController.matchData.value.id!);

                }else{
                  // rated
                  _matchDetailsController.rated(_matchDetailsController.matchData.value.id!, 1);
                }

              }, isRated:_matchDetailsController.matchData.value.isRated==1, icon:AppIcons.sed),
              ),
              Expanded(child:_rectRating(ontap:(){
                if(_matchDetailsController.matchData.value.isRated==2){
                  // unrated
                  _matchDetailsController.unRated(_matchDetailsController.matchData.value.id!);

                }else{
                  // rated
                  _matchDetailsController.rated(_matchDetailsController.matchData.value.id!, 2);
                }

              }, isRated: _matchDetailsController.matchData.value.isRated==2, icon:AppIcons.like),
              ),
              Expanded(child:_rectRating(ontap:(){
                if(_matchDetailsController.matchData.value.isRated==3){
                  // unrated
                  _matchDetailsController.unRated(_matchDetailsController.matchData.value.id!);

                }else{
                  // rated
                  _matchDetailsController.rated(_matchDetailsController.matchData.value.id!, 3);
                }

              }, isRated: _matchDetailsController.matchData.value.isRated==3, icon:AppIcons.happy),
              ),
              Expanded(child:_rectRating(ontap:(){
                if(_matchDetailsController.matchData.value.isRated==4){
                  // unrated
                  _matchDetailsController.unRated(_matchDetailsController.matchData.value.id!);

                }else{
                  // rated
                  _matchDetailsController.rated(_matchDetailsController.matchData.value.id!,4);
                }

              }, isRated: _matchDetailsController.matchData.value.isRated==4, icon:AppIcons.crazy),
              ),

            ],
          ),
        ),
      ),
      body: Obx(()=>_matchDetailsController.isLoading.value?const CustomLoader():_matchDetailsController.isNetWorkError.value?NoInternetScreen(onTap: (){
        _matchDetailsController.getMatch(id);
      }):
         SingleChildScrollView(
           physics: const AlwaysScrollableScrollPhysics(),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               CachedNetworkImage(
                 imageUrl: _matchDetailsController.matchData.value.notice!.thumbnailFullUrl!,
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
              GestureDetector(
                onTap: (){
                  Get.to( MatchingReason(matchReason:_matchDetailsController.matchData.value.matchReasons!,));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal:5.w,vertical: 10.h),
                    margin: EdgeInsets.symmetric(horizontal:10.w,vertical: 10.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.r),
                        color:Get.theme.cardColor,
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 0,
                              blurRadius:4,
                              offset: const Offset(0, 0),
                              color: const Color(0xFF000000).withOpacity(0.25))
                        ]),
                  child: Row(children: [
                    SizedBox(width: 5.w,),
                   Container(
                     padding: const EdgeInsets.all(3),
                       decoration: BoxDecoration(
                         shape: BoxShape.circle,
                         border: Border.all(
                           color:AppColors.borderColor,
                         )
                       ),
                       child: Image.asset( AppIcons.iIcon,height:20.h,width: 20.h,fit: BoxFit.fill,color: Get.theme.iconTheme.color,)),
                    SizedBox(width: 5.w,),
                    Expanded(child: Text("Why Am I Seeing This Match",style: AppStyles.h3(fontWeight: FontWeight.w500,color: AppColors.greyColor),maxLines: 1,overflow: TextOverflow.ellipsis,)),
                   Image.asset(AppIcons.doubleForword,height:15.h,width: 15.h,color:Get.theme.iconTheme.color,),
                    SizedBox(width: 8.w,)
                  ],),
                ),
              ),
             Padding(
               padding:EdgeInsets.symmetric(horizontal: 16.w),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Row(
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: [
                       Expanded(
                           child:Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text(_matchDetailsController.matchData.value.notice!.title!,style: AppStyles.h2(fontWeight: FontWeight.w700),),
                           Text(_matchDetailsController.matchData.value.notice!.university!.title!,style: AppStyles.h4(color:AppColors.greyColor),),
                         ],
                       )),
                       SizedBox(width: 10.w,),
                       ElevatedButton(onPressed:(){
                         Get.to(WebViewScreen(url:_matchDetailsController.matchData.value.notice!.university!.website!,));
                       },
                           child:Text("Visit",style: AppStyles.h4(fontWeight: FontWeight.w500,color:Colors.white),
                           )
                       )
                     ],
                   ),
                   SizedBox(height: 10.h,),
                   Text("Requirements",style: AppStyles.h2(color: AppColors.greyColor,fontWeight: FontWeight.w600),),
                   SizedBox(height: 10.h,),
                   _requirementList(title:"Tuition Fee",value:"${_matchDetailsController.matchData.value.notice!.minBudget!.toString()} USD/Year"),
                   SizedBox(height: 10.h,),
                   _requirementList(title:"Minimum CGPA",value:_matchDetailsController.matchData.value.notice!.minCgpa!.toString()),
                   SizedBox(height: 10.h,),
                   _requirementList(title:"Maximum Age",value:_matchDetailsController.matchData.value.notice!.maxAge!.toString()),
                   SizedBox(height: 10.h,),
                   ListView.separated(
                       physics: const NeverScrollableScrollPhysics(),
                       padding: EdgeInsets.symmetric(horizontal: 0.w),
                       shrinkWrap: true,
                       itemBuilder:(context,index){
                         var data=_matchDetailsController.matchData.value.notice!.requirements![index];
                         return  _requirementList(title: data.key.toString(), value: data.value.toString());
                       }, separatorBuilder:(context,index){
                     return SizedBox(
                       height: 5.h,
                     );
                   }, itemCount:_matchDetailsController.matchData.value.notice!.requirements!.length),
                   SizedBox(height: 10.h,),
                   Text("Summery ",style: AppStyles.h2(color: AppColors.greyColor,fontWeight: FontWeight.w600),),
                   SizedBox(height: 5.h,),
                   Text(_matchDetailsController.matchData.value.notice!.summery!,style: AppStyles.h4(),),
                   SizedBox(height: 10.h,),
                   Text("Description ",style: AppStyles.h2(color: AppColors.greyColor,fontWeight: FontWeight.w600),),
                   SizedBox(height: 5.h,),
                   Text(_matchDetailsController.matchData.value.notice!.description!,style: AppStyles.h4(),),



                 ],
               ),
             ),





             ],
           ),
         ),
      ),
    );
  }

   _rectRating({required Function() ontap,required bool isRated,required String icon}) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
                padding: EdgeInsets.symmetric(vertical:8.h),
                margin: EdgeInsets.symmetric(horizontal:10.w),
                decoration:isRated? BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color:  Colors.yellow.withOpacity(0.2)
                ):const BoxDecoration(),
                child:Image.asset(icon,height:25.h,width: 25.h,)),
    );
  }

  _requirementList({required  String title,required String value}) {
    return Row(
                  children: [
                    Text("$title : ",style: AppStyles.h3(fontWeight:FontWeight.w400),),
                    Expanded(child:Text(value,style: AppStyles.h3(fontWeight: FontWeight.w500,color: AppColors.mainColor),))
                  ],
                );
  }
}
