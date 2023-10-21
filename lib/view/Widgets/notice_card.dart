import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smg/controller/theme_controller.dart';
import 'package:smg/model/notices_model.dart';
import 'package:smg/routes/routes.dart';
import 'package:smg/view/Screen/NoticesDetails/notice_details.dart';

import '../../utils/app_icons.dart';
import '../../utils/color.dart';
import '../../utils/styles.dart';
import 'cache_network_image_url.dart';

class NoticeCard extends StatelessWidget {
  const NoticeCard({
    super.key,
    required this.dataModel,
    this.onSaved
  });

  final Function()? onSaved;
  final NoticeModel dataModel;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(NoticeDetailsScreen(id:dataModel.id!));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),

        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            boxShadow: [
              BoxShadow(
                blurRadius:4,
                spreadRadius:0,
                offset: const Offset(0, 2),
                color: const Color(0xFF393F4A).withOpacity(0.15)
              )
            ],
            color: Get.theme.cardColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Text(
                  dataModel.title!,
                  style: AppStyles.h3(fontWeight: FontWeight.w500),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                )),
                InkWell(onTap:onSaved, child:Padding(
                  padding: EdgeInsets.all(5.sp),
                  child:dataModel.isSaved!?const Icon(Icons.favorite,color: Colors.redAccent,):const Icon(Icons.favorite_border_rounded,),
                ))
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              dataModel.description!,
              style: AppStyles.h5(color: AppColors.greyColor),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              height: 10.h,
            ),
            // Row(
            //   children: [
            //     ClipRRect(
            //         borderRadius: BorderRadius.circular(8.r),
            //         child: Image.network(
            //           "https://media.istockphoto.com/id/182797434/photo/bangladesh-flag.jpg?s=612x612&w=0&k=20&c=pTj5bWIMaZogv_ATRjqooxK9HHTME0AjAOXZtalKfE0=",
            //           height: 35.h,
            //           width: 60.h,
            //           fit: BoxFit.fill,
            //         )),
            //     SizedBox(
            //       width: 5.w,
            //     ),
            //     Text(
            //       "Canada",
            //       style: AppStyles.h3(fontWeight: FontWeight.w600),
            //     ),]
            //
            // ),
            // SizedBox(
            //   height: 10.h,
            // ),

            //
            // Wrap(
            //   children: List.generate(
            //       tagList.length +
            //           (countryImage == null ? 0 : 1) +
            //           (univercityName == null ? 0 : 1), (index) {
            //     if (countryImage != null && univercityName != null) {
            //       if (index == 0) {
            //         return Container(
            //             padding:
            //             EdgeInsets.symmetric( vertical: 5.h),
            //             margin:
            //             EdgeInsets.only(right: 10.w, bottom: 5.h, top: 5.h),
            //             child: Text(univercityName, style:AppStyles.h4(fontWeight: FontWeight.w700)));
            //
            //       } else if (index == 1) {
            //         return Container(
            //           margin: EdgeInsets.only(right: 10.w, bottom: 5.h, top: 5.h),
            //           child: ClipRRect(
            //               borderRadius: BorderRadius.circular(8.r),
            //               child: Image.network(
            //                 countryImage,
            //                 height: 35.h,
            //                 width: 50.w,
            //                 fit: BoxFit.fill,
            //               )),
            //         );
            //
            //       } else {
            //         return Container(
            //           margin: EdgeInsets.only(right: 10.w, bottom: 5.h, top: 5.h),
            //           padding:
            //               EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            //           decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(25.r),
            //               color: AppColors.activeColor),
            //           child: Text(
            //             tagList[index - 2],
            //             style: AppStyles.h4(color: AppColors.white),
            //           ),
            //         );
            //       }
            //     } else if (countryImage == null) {
            //       if (index == 0) {
            //         return Container(
            //             padding:
            //                 EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            //             margin:
            //                 EdgeInsets.only(right: 10.w, bottom: 5.h, top: 5.h),
            //             child: Text(univercityName,style: AppStyles.h4(fontWeight: FontWeight.w700),));
            //       } else {
            //         return Container(
            //           margin: EdgeInsets.only(right: 10.w, bottom: 5.h, top: 5.h),
            //           padding:
            //               EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            //           decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(25.r),
            //               color: AppColors.activeColor),
            //           child: Text(
            //             tagList[index - 1],
            //             style: AppStyles.h4(color: AppColors.white),
            //           ),
            //         );
            //       }
            //     } else {
            //       if (index == 0) {
            //         return Container(
            //           margin: EdgeInsets.only(right: 10.w, bottom: 5.h, top: 5.h),
            //           child: ClipRRect(
            //               borderRadius: BorderRadius.circular(8.r),
            //               child: Image.network(
            //                 countryImage,
            //                 height: 35.h,
            //                 width: 50.w,
            //                 fit: BoxFit.fill,
            //               )),
            //         );
            //       } else {
            //         return Container(
            //           margin: EdgeInsets.only(right: 10.w, bottom: 5.h, top: 5.h),
            //           padding:
            //               EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            //           decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(25.r),
            //               color: AppColors.activeColor),
            //           child: Text(
            //             tagList[index - 1],
            //             style: AppStyles.h4(color: AppColors.white),
            //           ),
            //         );
            //       }
            //     }
            //   }),
            // )

            Wrap(
              children: List.generate(
                  dataModel.tags!.length,
                  (index) => Container(
                        margin:
                            EdgeInsets.only(right: 10.w, bottom: 5.h, top: 5.h),
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 5.h),
                        decoration: BoxDecoration(
                          color:Get.theme.inputDecorationTheme.fillColor,
                            borderRadius: BorderRadius.circular(25.r),
                            border: Border.all(
                              width: 0.2,
                              color: const Color(0xFFE5E5E5).withOpacity(0.2),
                            )),
                        child: Text(
                          "# ${dataModel.tags![index].name}",
                          style: AppStyles.h5(color:Colors.blue,fontWeight: FontWeight.w700,),

                        ),
                      )),
            ),
            const Divider(),
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4.r),
                  child: CachedNetworkImage(
                      imageUrl:dataModel.thumbnail!,
                    height: 60.h,
                    width: 60.h,
                    fit: BoxFit.fill,
                    errorWidget: (context,status,data){
                        return Container(
                          color: Get.theme.inputDecorationTheme.fillColor,
                          height: 60.h,
                          width: 60.h,
                        );
                    },
                  ),
                ),

                // Image.asset(
                //   AppIcons.university,
                //   color:Get.isDarkMode?Colors.grey :AppColors.black.withOpacity(0.5),
                //   height: 60.h,
                //   width: 60.h,
                // ),
                SizedBox(width:10.w,),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                     dataModel.university!.title!,
                      style: AppStyles.h4(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      dataModel.country!.name!,
                      style: AppStyles.h5(color: AppColors.greyColor),
                    )
                  ],
                ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
