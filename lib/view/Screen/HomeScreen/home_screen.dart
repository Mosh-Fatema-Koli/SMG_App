
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smg/controller/home_controller.dart';
import 'package:smg/utils/color.dart';
import 'package:smg/utils/styles.dart';
import 'package:smg/view/Widgets/bottom_menu.dart';
import 'package:smg/view/Widgets/custom_loader.dart';
import '../../../controller/profile_controller.dart';
import '../../../routes/routes.dart';
import '../../Widgets/notice_card.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});
  final _homeController =Get.put(HomeController());
  final _profileController =Get.find<ProfileController>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:()async =>false,
      child:Scaffold(
        appBar: AppBar(
          leadingWidth: 0,
          elevation: 1,
          title:Obx(()=>
             Row(
              children: [
                  CachedNetworkImage(
                  imageUrl:_profileController.userData.value.image,
                  placeholder:(context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey.shade700,
                    highlightColor: Colors.grey.shade400,
                    child:Container(
                       height:40.h,
                    width: 40.h,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    
                    ),

                    ) 
                    ) ,
                    errorWidget: (context, url, error) => Container(
                       height:40.h,
                    width: 40.h,
                    decoration:  BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.greyColor.withOpacity(0.8)
                    
                    ),

                    ),
                  imageBuilder: (context, imageProvider) => 
                  Container(
                    height:40.h,
                    width: 40.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 0.5,
                        
                      ),
                      image: DecorationImage(image: imageProvider,fit: BoxFit.cover)
                    ),
                  ),
                  
                  
                  ),


              //  _profileController.userData.value.image.isNotEmpty?CircleAvatar(
              //     radius:18.r,
              //     child:CachedNetworkImage(imageUrl:_profileController.userData.value.image,errorWidget:(context, url, error) {
              //       // onImageLoadResult!('Image URL is not valid: $error');
              //       return Container();
              //     },),
              //   ):
              //   Container(
              //     height: 40.h,
              //     width: 40.h,
              //     decoration:  BoxDecoration(
              //       color:Colors.grey,
              //       shape: BoxShape.circle,
              //       image:DecorationImage(image:AssetImage(AppIcons.person),fit: BoxFit.fill),
              //       border: Border.all(
              //         width:2
              //       )
              //     ),
              //   ),
                SizedBox(width:10.w,),
                if(_profileController.userData.value.studentProfile!=null)
                Text(_profileController.userData.value.studentProfile!.firstname,style:AppStyles.h4(),maxLines: 1,overflow: TextOverflow.ellipsis,)
            ],),
          ),
          centerTitle: true,
          leading: const SizedBox(),
          actions: [
            IconButton(onPressed:(){
              Get.toNamed(Routes.notificationScreen);
            }, icon: const Icon(Icons.notifications_sharp))
          ],
        ),
        body: Obx(()=>_homeController.isFirstLoadRunning.value?const CustomLoader():
           RefreshIndicator(
            onRefresh: ()async {
         await _homeController.refreshData();
             },
            child: _homeController.noticeList.isEmpty?const Center(child: Text("No data available !"),) :SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              controller:_homeController.scrollController,
              child: Column(
                children: [
                  SizedBox(height:10.h,),
                  CarouselSlider(
                      items: _homeController.sliderImage.map((e) =>Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          margin: EdgeInsets.symmetric(horizontal: 5.w),
                          child: CachedNetworkImage(imageUrl:e,fit: BoxFit.fill,height:double.infinity,width: double.infinity,))).toList(),
                      options: CarouselOptions(
                        height:120.h,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        viewportFraction: 1.2,
                        enlargeStrategy: CenterPageEnlargeStrategy.height,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration: const Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeFactor: 0.3,
                        onPageChanged:(index,j){
                          _homeController.dotPosition.value=index;
                        },
                        scrollDirection: Axis.horizontal,
                      )
                  ),
                  SizedBox(height:5.h,),
                  DotsIndicator(
                    dotsCount: _homeController.sliderImage.length,
                    position: _homeController.dotPosition.value,
                    decorator: DotsDecorator(
                      activeColor:AppColors.mainColor,
                      color:AppColors.greyColor,
                      spacing: const EdgeInsets.all(2),
                      activeSize:const Size(8, 8),
                      size:const Size(7, 7) ,
                    ),
                  ),



                  SizedBox(
                    height: 20.h,
                  ),
                  // notification
                  Obx(()=>
                     ListView.separated(
                     // controller: _homeController.scrollController,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          if (index < _homeController.noticeList.length) {
                            return NoticeCard(
                              onSaved: (){
                                if(_homeController.noticeList[index].isSaved==false){
                                  _homeController.handleSave(_homeController.noticeList[index].id!, index);
                                }else{
                                  _homeController.handleUnSave(_homeController.noticeList[index].id!, index);
                                }
                              },
                              dataModel:_homeController.noticeList[index],

                            );
                          } else {
                            if (_homeController.isLoadMoreRunning.value) {
                              return const Center(child: CircularProgressIndicator());
                            }else{
                              return const SizedBox();
                            }
                          }
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 20.h,
                          );
                        },
                        itemCount: _homeController.noticeList.length+1),
                  )


                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: const BottomMenu(0),
      ),
    );
  }
}


