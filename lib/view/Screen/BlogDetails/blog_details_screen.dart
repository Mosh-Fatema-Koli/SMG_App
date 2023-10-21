import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smg/controller/blog_details_Controller.dart';
import 'package:smg/utils/color.dart';
import 'package:smg/utils/styles.dart';
import 'package:smg/view/Widgets/custom_button.dart';
import 'package:smg/view/Widgets/custom_loader.dart';
import 'package:smg/view/Widgets/no_internet_screen.dart';
import '../../../controller/data_controller.dart';
import '../../../controller/save_unsave_controller.dart';
import '../../../utils/app_icons.dart';
import '../BlogTagScreen/blog_tag_screen.dart';

class BlogDetails extends StatefulWidget {
  BlogDetails({
    super.key,
    required this.blogIds,
  });
  final int blogIds;

  @override
  State<BlogDetails> createState() => _BlogDetailsState();
}

class _BlogDetailsState extends State<BlogDetails> {
  final _controller = Get.put(BlogDetailsController());
  final _dataController=Get.put(DataController());

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _controller.getBlog(widget.blogIds);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          // Obx(()=>_controller.isLoading.value?Container():_controller.isNetworkError.value?Container():
          //    Container(
          //     height: 40.h,
          //     width: 40.h,
          //     padding: EdgeInsets.all(10.h),
          //     alignment: Alignment.center,
          //     decoration:  BoxDecoration(
          //         shape: BoxShape.circle,
          //         color: Get.theme.cardColor,
          //         boxShadow: [
          //           BoxShadow(
          //               spreadRadius: 0,
          //               blurRadius:8,
          //               color:const Color(0xFF000000).withOpacity(0.1),
          //               offset: const Offset(0, 8)
          //           )
          //         ]
          //     ),
          //     child:const Icon(Icons.play_arrow)
          //   ),
          // ),
          // SizedBox(width: 15.w,),
          Obx(
            () => _controller.isLoading.value
                ? Container()
                : _controller.isNetworkError.value
                    ? Container()
                    : GestureDetector(
                        onTap: () async {
                          if (_controller.blogModel.value.isSaved!) {
                            _controller
                                .handleUnSave(_controller.blogModel.value.id!);
                          } else {
                            _controller.handleSave(
                              _controller.blogModel.value.id!,
                            );
                          }
                        },
                        child: Container(
                          height: 40.h,
                          width: 40.h,
                          padding: EdgeInsets.all(
                              _controller.blogModel.value.isSaved!
                                  ? 6.h
                                  : 10.h),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Get.theme.cardColor,
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: 0,
                                    blurRadius: 8,
                                    color: const Color(0xFF000000)
                                        .withOpacity(0.1),
                                    offset: const Offset(0, 8))
                              ]),
                          child: Obx(()=>
                          _dataController.isPremium.value? Image.asset(
                            _controller.blogModel.value.isSaved!?AppIcons.saveIcon:
                            AppIcons.unsaveIcon,
                            height: 20.h,
                            width: 20.h,
                            color:_controller.blogModel.value.isSaved!?AppColors.goldenColor:Get.theme.iconTheme.color,
                          ): Image.asset(
                            _controller.blogModel.value.isSaved!?AppIcons.saveIcon:
                            AppIcons.unsaveIcon,
                            height: 20.h,
                            width: 20.h,
                            color:_controller.blogModel.value.isSaved!?Colors.redAccent:Get.theme.iconTheme.color,
                          ),
                          ),
                        ),
                      ),
          ),
          SizedBox(
            width: 16.w,
          )
        ],
      ),
      body: Obx(
        () => _controller.isLoading.value
            ? const CustomLoader()
            : _controller.isNetworkError.value
                ? NoInternetScreen(
                    onTap: () {
                      _controller.getBlog(widget.blogIds);
                    },
                  )
                : Stack(
                    children: [
                      SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 5.h,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12.r),
                                child: CachedNetworkImage(
                                  imageUrl: _controller
                                      .blogModel.value.thumbnailFullUrl!,
                                  height: 180.h,
                                  width: double.infinity,
                                  fit: BoxFit.fill,
                                  placeholder: (context, url) =>
                                      Shimmer.fromColors(
                                          baseColor: Colors.grey.shade800,
                                          highlightColor: Colors.grey.shade700,
                                          child: Container(
                                            height: 180.h,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8.r),
                                                color: Colors.grey
                                                    .withOpacity(0.5)),
                                          )),
                                  errorWidget: (context, url, error) =>
                                      Container(
                                    height: 180.h,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        color: Colors.grey.withOpacity(0.5)),
                                    child: Icon(
                                      Icons.error,
                                      color: Colors.red.withOpacity(0.9),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                Jiffy.parseFromList([
                                  _controller.blogModel.value.createdAt!.year,
                                  _controller.blogModel.value.createdAt!.month,
                                  _controller.blogModel.value.createdAt!.day
                                ]).yMMMMd,
                                style:
                                    AppStyles.h4(fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                _controller.blogModel.value.title!,
                                style:
                                    AppStyles.h1(fontWeight: FontWeight.bold),
                              ),
                              //   SizedBox(height:5.h,),
                              Wrap(
                                children: List.generate(
                                    _controller.blogModel.value.tags!.length,
                                    (index) => GestureDetector(
                                          onTap: () {
                                            Get.to(
                                                BlogTagScreen(
                                                  tagIds: _controller.blogModel
                                                      .value.tags![index].id!,
                                                  tagName: _controller.blogModel
                                                      .value.tags![index].name!,
                                                ),
                                                transition:
                                                    Transition.rightToLeft);
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                right: 10.w,
                                                bottom: 5.h,
                                                top: 5.h),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.w,
                                                vertical: 5.h),
                                            decoration: BoxDecoration(
                                                color: Get
                                                    .theme
                                                    .inputDecorationTheme
                                                    .fillColor,
                                                borderRadius:
                                                    BorderRadius.circular(25.r),
                                                border: Border.all(
                                                  width: 0.2,
                                                  color: const Color(0xFFE5E5E5)
                                                      .withOpacity(0.2),
                                                )),
                                            child: Text(
                                              "# ${_controller.blogModel.value.tags![index].name}",
                                              style: AppStyles.h5(
                                                color: Colors.blue
                                                    .withOpacity(0.8),
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                        )),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                _controller.blogModel.value.summery!,
                                style: AppStyles.h4(
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.greyColor),
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              Html(
                                data: """${_controller.blogModel.value.body}""",
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (_controller.blogModel.value.subscriptionKind !=
                          "Free")
                        Positioned(
                            child: Container(
                          height: Get.height,
                          width: Get.width,
                          color: Colors.black.withOpacity(0.9),
                          child: Center(
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 20.w),
                              decoration: BoxDecoration(
                                  color: Get.theme.cardColor,
                                  borderRadius: BorderRadius.circular(8.r)),
                              child: Stack(
                                alignment: Alignment.topCenter,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        height: 100.h,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(8.r),
                                                topLeft: Radius.circular(8.r)),
                                            color: const Color(0xFFFFD700)),
                                      ),
                                      SizedBox(
                                        height: 70.h,
                                      ),
                                      Text(
                                        "Premium Subscription",
                                        style: AppStyles.h1(
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15.h,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.w),
                                        child: Text(
                                          "Les premières apparition de Lesram sur la scène rap se font en 2012,",
                                          style: AppStyles.h4(
                                              color: AppColors.greyColor),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      ElevatedButton(
                                        onPressed: () {

                                        },
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        20.r))),
                                        child: Text(
                                          "Buy Now",
                                          style: AppStyles.h4(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                    ],
                                  ),
                                  Positioned(
                                    top: 50.h,
                                    child: Container(
                                      height: 100.h,
                                      width: 100.h,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Get.theme.cardColor,
                                          boxShadow: [
                                            BoxShadow(
                                                blurRadius: 5,
                                                color: Colors.black
                                                    .withOpacity(0.25))
                                          ]),
                                      child: Lottie.asset(
                                        AppIcons.premiumLottie,
                                        width: 60.h,
                                        height: 60.h,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )),
                    ],
                  ),
      ),
    );
  }
}
