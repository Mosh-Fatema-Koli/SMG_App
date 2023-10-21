import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smg/controller/blog_tag_controller.dart';
import 'package:smg/view/Widgets/blog_shimmer_layout.dart';
import 'package:smg/view/Widgets/no_internet_screen.dart';

import '../../../controller/save_unsave_controller.dart';
import '../../Widgets/blog_card.dart';
import '../../Widgets/custom_loader.dart';
import '../Blog/blog_screeen.dart';
import '../BlogDetails/blog_details_screen.dart';

class BlogTagScreen extends StatefulWidget {
    BlogTagScreen({super.key, required this.tagIds, required this.tagName});
   final int tagIds;
   late final String tagName;

  @override
  State<BlogTagScreen> createState() => _BlogTagScreenState();
}

class _BlogTagScreenState extends State<BlogTagScreen> {
  final _blogTagController =Get.put(BlogTagController());
   final _savedUnSavedController=Get.put(SaveUnSaveController());
     final  name=''.obs;
     @override
  void initState() {
       SchedulerBinding.instance.addPostFrameCallback((_) {
         setState(() {
           _blogTagController.getTagIds(widget.tagIds);
           name.value=widget.tagName;
         });
       });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Obx(()=> Text(name.value)),
      ),
      body: Obx(
            () => _blogTagController.isFirstLoadRunning.value
            ? const BlogShimmerList():_blogTagController.isNetworkError.value?NoInternetScreen(onTap:(){
              _blogTagController.fastLoad();

            })
            : RefreshIndicator(
          onRefresh: ()async {
            await _blogTagController.refreshData();
          },
          child: SingleChildScrollView(
            controller: _blogTagController.scrollController,
            padding: EdgeInsets.symmetric(vertical: 15.h),
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                Obx(
                    () => ListView.separated(
                    // controller: _homeController.scrollController,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        if (index < _blogTagController.blogList.length) {
                          // return BlogCard(
                          //   onTapFav: (){
                          //      if(_blogTagController.blogList[index].isSaved!){
                          //             _savedUnSavedController.handleUnSave(_blogTagController.blogList[index].id!,);
                          //           }else{
                          //        _savedUnSavedController.handleSave(_blogTagController.blogList[index].id!,);
                          //           }
                          //   },
                          //   blogModel: _blogTagController.blogList[index],
                          //   onTap: (){
                          //     Get.to( BlogDetails(blogIds:_blogTagController.blogList[index].id!,),transition:Transition.rightToLeft);
                          //
                          //   },
                          //   isBlogScreen: false,
                          //   onTapTag: (value){
                          //     name.value=value['name'];
                          //     _blogTagController.getTagIds(value['id']);
                          //   },
                          // );
                          return BlogCard(
                            onFav: () {
                            if(_blogTagController.blogList[index].isSaved!){
                              _savedUnSavedController.handleUnSave(_blogTagController.blogList[index].id!,);
                            }else{
                              _savedUnSavedController.handleSave(_blogTagController.blogList[index].id!,);
                            }
                          },
                            data:_blogTagController.blogList[index],
                            onTap: () {
                              Get.to( BlogDetails(blogIds:_blogTagController.blogList[index].id!,),transition:Transition.rightToLeft);
                          },);
                        } else {
                          if (_blogTagController.isLoadMoreRunning.value) {
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
                      itemCount: _blogTagController.blogList.length + 1),
                )
              ],
            ),
          ),
        ),
      ),
    ) ;
  }
}
