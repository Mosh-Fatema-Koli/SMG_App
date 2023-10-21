import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smg/utils/color.dart';
import 'package:smg/utils/styles.dart';
import 'package:smg/view/Screen/InboxScreeen/ChatScreen/chat_screen.dart';
import 'package:smg/view/Widgets/cache_network_image_url.dart';

import '../../Widgets/bottom_menu.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});
  final int i = 10;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:()async =>false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Inbox",
          ),
          leading: const SizedBox(),
        ),
        body: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: (){
                  Get.to(ChatScreen());
                },
                child: MessageTile(
                  senderName: 'John Doe',
                  message: 'Hey, how are you?',
                  time: '2h ago',
                  avatarUrl:
                      'https://imgv3.fotor.com/images/gallery/Realistic-Male-Profile-Picture.jpg', // Replace with actual URL
                  unseenCount: 1,
                  isActive: true,
                ),
              );

              // return MessageTile(
              //   senderName: 'John Doe',
              //   message: 'Hey, how are you?',
              //   time: '2h ago',
              //   avatarUrl: "https://imgv3.fotor.com/images/gallery/Realistic-Male-Profile-Picture.jpg",
              //   unseenCount: 3, // Replace with the actual unseen message count
              // );
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
            itemCount: 5),
        bottomNavigationBar: const BottomMenu(1),
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String senderName;
  final String message;
  final String time;
  final String avatarUrl;
  final int unseenCount; // Number of unseen messages
  final bool isActive; // User's online status

  MessageTile({
    required this.senderName,
    required this.message,
    required this.time,
    required this.avatarUrl,
    this.unseenCount =0,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          children: [
            Container(
              height: 50.h, width: 50.h,
              //   margin: EdgeInsets.all(5.h),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Get.theme.inputDecorationTheme.fillColor,
              ),
              child: CachedNetworkImage(imageUrl: avatarUrl,errorWidget: (context,url,body){
                return const SizedBox();
              },),
            ),
            Positioned(
                bottom: 2.h,
                right: 2.h,
                child: CircleAvatar(
                  backgroundColor: const Color(0xFF008A00),
                  radius: 5.r,
                ))
          ],
        ),
        SizedBox(
          width: 10.w,
        ),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: Text(
                  senderName,
                  style: AppStyles.h4(fontWeight: FontWeight.w700),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),),
                Text(time,style:AppStyles.h5(color: AppColors.greyColor),),

              ],
            ),

            SizedBox(height:5.h,),
            Row(
              children: [
                Expanded(child:  Text(
                  message,
                  style: AppStyles.h5(color: AppColors.greyColor),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),),
                if (unseenCount > 0)
                  Container(
                    margin: EdgeInsets.only(left: 8.w),
                    padding: EdgeInsets.symmetric(horizontal: 5.w, vertical:2.h),
                    decoration: unseenCount.toString().length == 1
                        ? const BoxDecoration(color: Colors.blue, shape: BoxShape.circle)
                        : BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(
                      '$unseenCount',
                      style: TextStyle(color: Colors.white, fontSize: 12.sp),
                    ),
                  ),


              ],
            )

          ],
        )),
      ],
    );
  }
}

// class MessageTile extends StatelessWidget {
//   final String senderName;
//   final String message;
//   final String time;
//   final String avatarUrl;
//   final int unseenCount;
//
//   MessageTile({
//     required this.senderName,
//     required this.message,
//     required this.time,
//     required this.avatarUrl,
//     this.unseenCount = 0,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       leading: CircleAvatar(
//         backgroundImage: NetworkImage(avatarUrl),
//       ),
//       title: Row(
//         children: [
//           Text(senderName),
//           if (unseenCount > 0)
//             Container(
//               margin: EdgeInsets.only(left: 8),
//               padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
//               decoration: BoxDecoration(
//                 color: Colors.blue,
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Text(
//                 '$unseenCount new',
//                 style: TextStyle(color: Colors.white, fontSize: 12),
//               ),
//             ),
//         ],
//       ),
//       subtitle: Text(message),
//       trailing: Text(time),
//     );
//   }
// }
