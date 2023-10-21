import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smg/controller/notification_controller.dart';
import 'package:smg/controller/theme_controller.dart';
import 'package:smg/model/notification_model.dart';
import 'package:smg/utils/app_icons.dart';
import 'package:smg/utils/color.dart';
import 'package:smg/utils/styles.dart';
import 'package:smg/view/Screen/NoticesDetails/notice_details.dart';
import 'package:smg/view/Screen/StudyMatchDetails/study_match_details.dart';
import 'package:smg/view/Widgets/empty_screen.dart';
import 'package:smg/view/Widgets/no_internet_screen.dart';
import 'package:smg/view/Widgets/notification_shimmer_layout.dart';
import 'package:timeago/timeago.dart' as timeago;


class NotificationScreen extends StatelessWidget {
   NotificationScreen({super.key});
  final _controller = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
      _controller.fastLoad();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification"),
      ),
      body: Obx(()=>
         RefreshIndicator(
          onRefresh: ()async {
         await   _controller.refreshData();
          },
          child:_controller.isFirstLoadRunning.value?const NotificationShimmerList():_controller.isNetworkError.value?NoInternetScreen(onTap:(){}):_controller.notificationList.isEmpty?EmptyScreeen(image:AppIcons.emptyNotificationIcon,des:"You have no notifications right now.\nCome back later.",):ListView.separated(
              controller: _controller.scrollController,
              padding: EdgeInsets.only(top: 15.h),
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                if (index < _controller.notificationList.length) {
                  // return _notificationCard(_controller.notificationList[index]);
                  // final date = _controller.groupedNotifications.keys.elementAt(index);
                  // final notificationForDate = _controller.groupedNotifications[date];
                  // final now = DateTime.now();
                  // final today = DateTime(now.year, now.month, now.day);
                  //

                  // return Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Container(
                  //       margin: EdgeInsets.symmetric(vertical:3.h,horizontal: 10.w),
                  //       padding: EdgeInsets.symmetric(horizontal:5.w,vertical: 2.h),
                  //
                  //         child: Text(today==date?"Today":Jiffy.parseFromList([date.year, date.month, date.day]).yMMMMd)),
                  //
                  //     Column(
                  //       children:notificationForDate!.map((value) {
                  //         return _notificationCard(value);
                  //       }).toList(),
                  //     ),
                  //   ],
                  // );

                  return _notificationCard(_controller.notificationList[index]);
                } else {
                  if (_controller.isLoadMoreRunning.value) {
                    return const Center(child: CircularProgressIndicator());
                  }else{
                    return const SizedBox();
                  }
                }
              },
              separatorBuilder: (context, index) {
                return  Container(
                  // width: double.infinity,
                  // height: 0.5,
                  // color:Get.theme.dividerColor,
                );
              },
              itemCount:_controller.notificationList.length+1),
        ),
      ),
    );
  }
   Widget _notificationCard(NotificationModel model ) {
    return InkWell(
      onTap: ()async{
        if(model.type=="NEW_MATCH_FOUND"){
          Get.to(StudyMatchDetails(id:model.objectId!,),transition: Transition.rightToLeft);
          _controller.seenNotification(model.id!);
          // await   _controller.fastLoad();
        }
      },
      child: Container(
              color:Get.find<ThemeController>().isDarkTheme.value?model.seenAt==null? const Color(0xFF2c2c2c):AppColors.darkBgColor: model.seenAt==null?Colors.blue.withOpacity(0.1):AppColors.bgColor,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical:10.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if(model.thumbnailFullUrl != null)
                  CachedNetworkImage(imageUrl:model.thumbnailFullUrl!,
                  imageBuilder: (context, imageProvider) => Container(
                    height: 55.h,
                    width: 55.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      image: DecorationImage(image: imageProvider,fit: BoxFit.cover)
                    ),
                  ),
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor:Colors.grey.shade800,
                     highlightColor: Colors.grey.shade700,
                      child:Container(
                    height: 55.h,
                    width: 55.h,
                    decoration:BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: Colors.grey.withOpacity(0.5)
                    ),
                  )),
                  errorWidget: (context, url, error) =>  Container(
                    height: 55.h,
                    width: 55.h,
                    decoration:BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: Colors.grey.withOpacity(0.5)
                    ),
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
                      Text(
                        model.title!,
                        style: AppStyles.h4(
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        model.description!,
                        style:AppStyles.h5(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        timeago.format(model.createdAt!),
                        style: AppStyles.h4(
                            fontWeight: FontWeight.w500,color:model.seenAt==null? Colors.blue:AppColors.greyColor),
                      )
                    ],
                  ))
                ],
              ),
            ),
    );
  }
}
