import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smg/controller/data_controller.dart';
import 'package:smg/utils/app_icons.dart';
import 'package:smg/view/Widgets/premium_icon.dart';
import '../../model/blog_model.dart';
import '../../utils/color.dart';
import '../../utils/styles.dart';
import '../Screen/BlogTagScreen/blog_tag_screen.dart';
//
// class BlogCard extends StatelessWidget {
//   const BlogCard({super.key, required this.blogModel, this.onTap,this.onTapFav,  this.isBlogScreen=true, this.onTapTag});
//   final BlogModel blogModel;
//   final Function()? onTap;
//   final Function()? onTapFav;
//   final Function? onTapTag;
//   final bool  isBlogScreen ;
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Stack(
//
//         children: [
//           Container(
//             padding: EdgeInsets.all(8.w),
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8.r),
//                 boxShadow: [
//                   BoxShadow(
//                       blurRadius: 4,
//                       spreadRadius: 0,
//                       offset: const Offset(0, 2),
//                       color: const Color(0xFF393F4A).withOpacity(0.15))
//                 ],
//                 color: Get.theme.cardColor),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(8.r),
//                   child: CachedNetworkImage(
//                     imageUrl: blogModel.thumbnailFullUrl == null ? "" : blogModel.thumbnailFullUrl!,
//                     fit: BoxFit.fill,
//                     height: 130.h,
//                     width: double.infinity,
//                     placeholder: (context, index) {
//                       return Shimmer.fromColors(
//                           baseColor: Colors.grey.withOpacity(0.5),
//                           highlightColor: Colors.grey.withOpacity(0.4),
//                           child: Container(
//                             height: 130.h,
//                             width: double.infinity,
//                             color: Colors.grey.shade700,
//                           ));
//                     },
//                     errorWidget: (context, imageUrl, data) {
//                       return Container(
//                         height: 130.h,
//                         width: double.infinity,
//                         color: Colors.grey.withOpacity(0.3),
//                       );
//                     },
//                   ),
//                 ),
//                 SizedBox(
//                   height: 5.h,
//                 ),
//                 if(blogModel.subscriptionKind!="Free")
//                 Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(15.r),
//                    // color: const Color(0xFFFFD700)
//                   ),
//                   child: Row(
//                    crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Image.asset(AppIcons.premium,height:30.sp,width:40.sp,fit: BoxFit.fill,),
//                       SizedBox(width: 3.w,),
//                       Text("Premium",style:AppStyles.h4(color: const Color(0xFFFFD700),fontWeight: FontWeight.w500),)
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 5.h,
//                 ),
//                 Padding(
//                   padding:  EdgeInsets.only(right:45.w ),
//                   child: Text(
//                     blogModel.title!,
//                     style: AppStyles.h4(
//                       fontWeight: FontWeight.w600,
//                     ),
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//                 SizedBox(height: 5.h,),
//                 Text(
//                   blogModel.summery!,
//                   style: AppStyles.h5(color: AppColors.greyColor),
//                   maxLines:3,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 SizedBox(
//                   height: 8.h,
//                 ),
//                 Wrap(
//                   children: List.generate(
//                       blogModel.tags!.length,
//                           (index) => GestureDetector(
//                         onTap: (){
//                           if(isBlogScreen){
//                             Get.to(BlogTagScreen(tagIds:blogModel.tags![index].id!, tagName:blogModel.tags![index].name!,),transition:Transition.rightToLeft);
//                           }else{
//                             onTapTag!({
//                               "id":blogModel.tags![index].id!,
//                               "name":blogModel.tags![index].name!
//                             });
//                           }
//                         },
//                         child: Container(
//                           margin:
//                           EdgeInsets.only(right: 10.w, bottom: 5.h, top: 5.h),
//                           padding:
//                           EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
//                           decoration: BoxDecoration(
//                               color: Get.theme.inputDecorationTheme.fillColor,
//                               borderRadius: BorderRadius.circular(25.r),
//                               border: Border.all(
//                                 width: 0.2,
//                                 color: const Color(0xFFE5E5E5).withOpacity(0.2),
//                               )),
//                           child: Text(
//                             "# ${blogModel.tags![index].name}",
//                             style: AppStyles.h5(
//                               color: Colors.blue.withOpacity(0.8),
//                               fontWeight: FontWeight.w700,
//                             ),
//                           ),
//                         ),
//                       )),
//                 ),
//               ],
//             ),
//           ),
//           //  if(blogModel.subscriptionKind!="Free")
//           // Positioned(
//           //     top:8.w,
//           //     left: 8.w,
//           //     child:Container(
//           //       padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 5.h),
//           //
//           //   decoration: BoxDecoration(
//           //     borderRadius: BorderRadius.only(topLeft: Radius.circular(8.r),bottomRight: Radius.circular(18.r)),
//           //    // color:const Color(0xFFFFD700)
//           //     color: AppColors.bgColor
//           //   ),
//           //   child: Row(
//           //     children: [
//           //       Image.asset(AppIcons.premium,height:30.sp,width:40.sp,fit: BoxFit.fill,),
//           //       SizedBox(width: 3.w,),
//           //       Text("PRO",style: AppStyles.h5(color:Colors.black,fontWeight: FontWeight.w600),),
//           //     ],
//           //   ),
//           // )),
//
//
//           Positioned(
//               top: 120.h,
//               right: 5,
//               child:GestureDetector(
//                 onTap: onTapFav,
//                 child: Container(
//                   height: 40.h,
//                   width: 40.h,
//                   padding: EdgeInsets.all(blogModel.isSaved!?6.h:10.h),
//                   decoration:  BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Get.theme.cardColor,
//                     boxShadow: [
//                       BoxShadow(
//                         spreadRadius: 0,
//                         blurRadius:8,
//                         color:const Color(0xFF000000).withOpacity(0.1),
//                         offset: const Offset(0, 8)
//                       )
//                     ]
//                   ),
//                   child:Image.asset(blogModel.isSaved!? AppIcons.saveIcon:AppIcons.unsaveIcon,color:blogModel.isSaved!? Colors.redAccent : Get.theme.iconTheme.color,fit: BoxFit.fill,),
//
//                         ),
//               ))
//
//         ],
//       ),
//     );
//   }
// }


class BlogCard extends StatelessWidget {
   BlogCard({
    super.key,
    required this.onFav,
    required this.data,
    required this.onTap,
  });

final  Function() onTap;
 final Function() onFav;
 final BlogModel data;
 final _dataController=Get.put(DataController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:  onTap,
      child: Container(
        height: 120.h,
        padding: EdgeInsets.symmetric(
            horizontal: 10.w, vertical: 10.h),
        decoration: BoxDecoration(
            borderRadius:
            BorderRadius.circular(5.r),
            color: Get.theme.cardColor,
            border: Border.all(
                color: const Color(0xFFFFD700)
                    .withOpacity(0.5),
                width: 0.8),
            boxShadow: [
              BoxShadow(
                  blurRadius: 8,
                  color: AppColors.goldenColor
                      .withOpacity(0.15))
            ]),
        child: Row(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                ClipRRect(
                  borderRadius:
                  BorderRadius.circular(
                      5.r),
                  child: CachedNetworkImage(
                    imageUrl:
                 data.thumbnailFullUrl! ,
                    fit: BoxFit.fill,
                    height: 100.h,
                    width: 100.h,
                    placeholder:
                        (context, index) {
                      return Shimmer.fromColors(
                          baseColor: Colors.grey
                              .withOpacity(0.5),
                          highlightColor: Colors
                              .grey
                              .withOpacity(0.4),
                          child: Container(
                            height: 100.h,
                            width: 100.h,
                            color: Colors
                                .grey.shade700,
                          ));
                    },
                    errorWidget: (context,
                        imageUrl, data) {
                      return Container(
                        height: 100.h,
                        width: 100.h,
                        color: Colors.grey
                            .withOpacity(0.3),
                      );
                    },
                  ),
                ),
                 const Positioned(
                    right: 0,
                    bottom: 0,
                    child: PremiumIcon())
              ],
            ),
            SizedBox(
              width: 10.w,
            ),
            Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  mainAxisAlignment:
                  MainAxisAlignment
                      .spaceBetween,
                  children: [
                    Text(
                      data.title!,
                      maxLines: 2,
                      overflow:
                      TextOverflow.ellipsis,
                      style: AppStyles.h3(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                    data.summery!,
                      maxLines: 2,
                      overflow:
                      TextOverflow.ellipsis,
                      style: AppStyles.h4(
                          color:
                          AppColors.greyColor),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                              "Category",
                              style: AppStyles.h3(
                                  color: AppColors
                                      .mainColor),
                              overflow:
                              TextOverflow.ellipsis,
                              maxLines: 1,
                            )),

                        CachedNetworkImage(
                          imageUrl:"https://upload.wikimedia.org/wikipedia/commons/thumb/c/cf/Flag_of_Canada.svg/1024px-Flag_of_Canada.svg.png",
                          placeholder: (context,
                              url) =>
                              Shimmer.fromColors(
                                  baseColor: Colors
                                      .grey
                                      .shade700,
                                  highlightColor:
                                  Colors.grey
                                      .shade400,
                                  child: Container(
                                    height: 20.w,
                                    width: 30.w,
                                    decoration:
                                    const BoxDecoration(
                                      //  borderRadius: BorderRadius.circular(4.r)
                                    ),
                                  )),
                          errorWidget: (context,
                              url, error) =>
                              Container(
                                // height: 20.w,
                                // width: 30.w,
                                // decoration:  BoxDecoration(
                                //     borderRadius: BorderRadius.circular(4.r),
                                //     color: AppColors.greyColor.withOpacity(0.5)
                                // ),
                              ),
                          imageBuilder: (context,
                              imageProvider) =>
                              Container(
                                height: 20.w,
                                width: 30.w,
                                margin: EdgeInsets.only(
                                    right: 10.w),
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius
                                        .circular(
                                        3.r),
                                    image: DecorationImage(
                                        image:
                                        imageProvider,
                                        fit: BoxFit
                                            .cover)),
                              ),
                        ),

                        Expanded(
                            child: Text(
                              "Canada",
                              overflow:
                              TextOverflow.ellipsis,
                              maxLines: 1,
                              style: AppStyles.h3(
                                  fontWeight:
                                  FontWeight.w500),
                            )),
                        SizedBox(
                          width: 10.w,
                        ),
                        GestureDetector(
                          onTap: onFav,
                          child: Obx(()=>
                          _dataController.isPremium.value? Image.asset(
                              data.isSaved!?AppIcons.saveIcon:
                              AppIcons.unsaveIcon,
                              height: 20.h,
                              width: 20.h,
                              color:data.isSaved!?AppColors.goldenColor:Get.theme.iconTheme.color,
                            ): Image.asset(
                            data.isSaved!?AppIcons.saveIcon:
                            AppIcons.unsaveIcon,
                            height: 20.h,
                            width: 20.h,
                            color:data.isSaved!?Colors.redAccent:Get.theme.iconTheme.color,
                          ),
                          ),
                        )
                      ],
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}