import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smg/controller/save_blog_controller.dart';
import 'package:smg/controller/save_unsave_controller.dart';
import 'package:smg/utils/app_icons.dart';
import 'package:smg/view/Screen/BlogDetails/blog_details_screen.dart';
import 'package:smg/view/Widgets/blog_card.dart';
import 'package:smg/view/Widgets/blog_shimmer_layout.dart';
import 'package:smg/view/Widgets/empty_screen.dart';
import 'package:smg/view/Widgets/no_internet_screen.dart';

class SavedBlogScreen extends StatelessWidget {
  SavedBlogScreen({super.key});

  final _savedBlogController = Get.put(SavedBlogController());
  final _saveUnSaveBlogController = Get.put(SaveUnSaveController());
  @override
  Widget build(BuildContext context) {
    _savedBlogController.fastLoad();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Saved Blog"),
      ),
      body: Obx(
        () => _savedBlogController.isFirstLoadRunning.value
            ? const BlogShimmerList()
            : _savedBlogController.isNetworkError.value
                ? NoInternetScreen(onTap: () {
                    _savedBlogController.fastLoad();
                  })
                : _savedBlogController.blogList.isEmpty
                    ? EmptyScreeen(
                        image: AppIcons.emptySavedList,
                        des: "Your saved blog list is empty.")
                    : RefreshIndicator(
                        onRefresh: () async {
                          await _savedBlogController.refreshData();
                        },
                        child: SingleChildScrollView(
                          controller: _savedBlogController.scrollController,
                          padding: EdgeInsets.symmetric(vertical: 15.h),
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Column(
                            children: [
                              Obx(
                                () => ListView.separated(
                                    // controller: _homeController.scrollController,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16.w),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      if (index <
                                          _savedBlogController
                                              .blogList.length) {
                                        // return BlogCard(
                                        //   onTapFav: (){
                                        //     if(_savedBlogController.blogList[index].isSaved!){
                                        //       _saveUnSaveBlogController.handleUnSave(_savedBlogController.blogList[index].id!,);
                                        //     }
                                        //   },
                                        //   onTap: (){
                                        //     Get.to( BlogDetails(blogIds:_savedBlogController.blogList[index].id!,),transition:Transition.rightToLeft);
                                        //   },
                                        //   blogModel: _savedBlogController.blogList[index],
                                        // );
                                        return BlogCard(
                                          onFav: () {
                                            if (_savedBlogController
                                                .blogList[index].isSaved!) {
                                              _saveUnSaveBlogController
                                                  .handleUnSave(
                                                _savedBlogController
                                                    .blogList[index].id!,
                                              );
                                            }
                                          },
                                          data: _savedBlogController
                                              .blogList[index],
                                          onTap: () {
                                            Get.to( BlogDetails(blogIds:_savedBlogController.blogList[index].id!,),transition:Transition.rightToLeft);
                                          },
                                        );
                                        ;
                                      } else {
                                        if (_savedBlogController
                                            .isLoadMoreRunning.value) {
                                          return const Center(
                                              child:
                                                  CircularProgressIndicator());
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
                                    itemCount:
                                        _savedBlogController.blogList.length +
                                            1),
                              )
                            ],
                          ),
                        ),
                      ),
      ),
    );
  }
}
