import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smg/controller/blog_controller.dart';
import 'package:smg/controller/data_controller.dart';
import 'package:smg/controller/save_unsave_controller.dart';
import 'package:smg/utils/color.dart';
import 'package:smg/utils/styles.dart';
import 'package:smg/view/Screen/BlogDetails/blog_details_screen.dart';
import 'package:smg/view/Widgets/blog_shimmer_layout.dart';
import '../../../routes/routes.dart';
import '../../../utils/app_icons.dart';
import '../../Widgets/blog_card.dart';
import '../../Widgets/bottom_menu.dart';
import 'package:badges/badges.dart' as badges;

import '../../Widgets/floating_button.dart';
import '../../Widgets/premium_icon.dart';
import '../../Widgets/premium_logo.dart';

class BlogScreen extends StatelessWidget {
  BlogScreen({super.key});
  final _blogController = Get.put(BlogController());
  final _dataController = Get.put(DataController());
  final _savedUnSavedController = Get.put(SaveUnSaveController());
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 0,
          elevation: 1,
          title: Obx(
            () => Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.personalInformation);
                  },
                  child: CachedNetworkImage(
                    imageUrl: _dataController.image.value,
                    placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey.shade700,
                        highlightColor: Colors.grey.shade400,
                        child: Container(
                          height: 40.h,
                          width: 40.h,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                        )),
                    errorWidget: (context, url, error) => Container(
                      height: 40.h,
                      width: 40.h,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.greyColor.withOpacity(0.8)),
                    ),
                    imageBuilder: (context, imageProvider) => Container(
                      height: 40.h,
                      width: 40.h,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.greyColor,
                          border: Border.all(
                              width: 1, color: AppColors.goldenColor),
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover)),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                const PremiumLogo()
                // Image.asset(AppIcons.crownIcon,height: 40.h,width: 50.w,),
                // Text(_dataController.name.value,style:AppStyles.h4(),maxLines: 1,overflow: TextOverflow.ellipsis,)
              ],
            ),
          ),
          centerTitle: true,
          leading: const SizedBox(),
          actions: [
            GestureDetector(
              onTap: () {
                Get.toNamed(Routes.notificationScreen);
              },
              child: Padding(
                padding: EdgeInsets.all(15.w),
                child: badges.Badge(
                  badgeContent: Text(
                    '3',
                    maxLines: 1,
                    style: AppStyles.h5(color: Colors.white),
                  ),
                  child: const Icon(Icons.notifications),
                ),
              ),
            ),
            SizedBox(
              width: 8.w,
            ),
            // IconButton(onPressed:(){
            //   Get.toNamed(Routes.notificationScreen);
            // }, icon: const Icon(Icons.notifications_sharp))
          ],
        ),
        extendBody: true,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: const FabFloatingButton(),
        bottomNavigationBar: const BottomMenu(0),
        body: Obx(
          () => RefreshIndicator(
            onRefresh: () async {
              await _blogController.refreshData();
            },
            child: _blogController.isFirstLoadRunning.value
                ? const BlogShimmerList()
                : SingleChildScrollView(
                    controller: _blogController.scrollController,
                    padding: EdgeInsets.symmetric(vertical: 15.h),
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Text(
                            "Our Tutorials And Gridlines",
                            style: AppStyles.h1(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Container(
                              margin: EdgeInsets.only(
                                  left: 16.w, bottom: 3.h, top: 3.h),
                              height: 1,
                              width: double.infinity,
                              color: Get.theme.dividerColor,
                            )),
                            SizedBox(
                              width: 80.w,
                            )
                          ],
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Text(
                              "Lorem ipsum dolor sit amet consectetur adipiscing elit",
                              style: AppStyles.h3(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )),
                        SizedBox(
                          height: 20.h,
                        ),
                        Obx(
                          () => ListView.separated(
                              // controller: _homeController.scrollController,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                if (index < _blogController.blogList.length) {
                                  // return BlogCard(
                                  //   onTapFav: (){
                                  //     if(_blogController.blogList[index].isSaved!){
                                  //       _savedUnSavedController.handleUnSave(_blogController.blogList[index].id!,);
                                  //     }else{
                                  //       _savedUnSavedController.handleSave(_blogController.blogList[index].id!,);
                                  //     }
                                  //   },
                                  //   onTap: (){
                                  //     Get.to( BlogDetails(blogIds:_blogController.blogList[index].id!,),transition:Transition.rightToLeft);
                                  //   },
                                  //   blogModel: _blogController.blogList[index],
                                  // );
                                  return BlogCard(
                                    onFav: () {
                                      if (_blogController
                                          .blogList[index].isSaved!) {
                                        _savedUnSavedController.handleUnSave(
                                          _blogController.blogList[index].id!,
                                        );
                                      } else {
                                        _savedUnSavedController.handleSave(
                                          _blogController.blogList[index].id!,
                                        );
                                      }
                                    },
                                    data: _blogController.blogList[index],
                                    onTap: () {
                                      Get.to(
                                          BlogDetails(
                                            blogIds: _blogController
                                                .blogList[index].id!,
                                          ),
                                          transition: Transition.rightToLeft);
                                    },
                                  );
                                } else {
                                  if (_blogController.isLoadMoreRunning.value) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  } else {
                                    return const SizedBox();
                                  }
                                }
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: 20.h,
                                );
                              },
                              itemCount: _blogController.blogList.length + 1),
                        ),
                        SizedBox(
                          height: 80.h,
                        )
                      ],
                    ),
                  ),




          ),
        ),
      ),
    );
  }
}
