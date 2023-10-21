import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smg/model/profile_model.dart';
import 'package:smg/view/Screen/SettingScreen/Screen/DesiredDestination/Controller/destination_controller.dart';
import 'package:smg/view/Screen/SettingScreen/Screen/DesiredDestination/add_desired_countries.dart';
import 'package:smg/view/Screen/SettingScreen/Screen/DesiredDestination/add_desired_degree.dart';
import 'package:smg/view/Widgets/cache_network_image_url.dart';
import 'package:smg/view/Widgets/custom_loader.dart';
import 'package:smg/view/Widgets/delete_confirmation_dialog.dart';
import 'package:smg/view/Widgets/no_internet_screen.dart';

import '../../../../../controller/profile_controller.dart';
import '../../../../../model/country_model.dart';
import '../../../../../utils/color.dart';
import '../../../../../utils/styles.dart';

class Destination extends StatelessWidget {
  Destination({super.key});
  final _controller = Get.put(DestinationController());
  @override
  Widget build(BuildContext context) {
    // _controller.getDesiredCountry();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Desired Destination"),
      ),
      body: Obx(
        () => _controller.loading.value
            ? const CustomLoader()
            : _controller.isNetworkError.value?NoInternetScreen(onTap:(){
              _controller.getDesiredCountry();
            }) :SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical:15.h),
                child: Column(
                children: [
                  _desiredCountry(),
                  SizedBox(
                    height: 5.h,
                  ),
                  if(_controller.desiredCountry.length>4)
                    OutlinedButton(onPressed: (){
                      _controller.isSeeMoreCountry.value=!_controller.isSeeMoreCountry.value;
                    },

                    child: Text(_controller.isSeeMoreCountry.value?"See Less":"See More")),


                  _desiredDegree(),
                  SizedBox(
                    height: 5.h,
                  ),
                  if(_controller.desiredDegree.length>4)
                    OutlinedButton(onPressed: (){
                      _controller.isSeeMoreDegree.value=!_controller.isSeeMoreDegree.value;
                    },

                        child: Text(_controller.isSeeMoreDegree.value? "See Less":"See More")),


                ],
              )),
      ),
    );
  }

  _desiredCountry() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                "Desired Countries",
                style: AppStyles.h1(
                    fontWeight: FontWeight.w600, color: AppColors.greyColor),
              ),
            )),
            TextButton(
                onPressed: () {
                  Get.to(const AddDesiredDestination(),transition:Transition.rightToLeft);
                },
                child: Text(
                  "Add New",
                  style: AppStyles.h4(color: Colors.redAccent),
                )),
            SizedBox(
              width: 8.w,
            )
          ],
        ),

        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          itemCount:  _controller.desiredCountry.length<4?_controller.desiredCountry.length:_controller.isSeeMoreCountry.value==true?_controller.desiredCountry.length:4,
          itemBuilder: (context, index) {
            var data = _controller.desiredCountry[index];
            return Container(
             // height: 50.h,
              //padding: EdgeInsets.symmetric(horizontal: 10.w,),
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.borderColor),
                  borderRadius: BorderRadius.circular(8.r)),
              child: Row(
                children: [
                  SizedBox(width: 15.w,),
                  CachedNetworkImageUrl(
                    imageUrl: data.flag,
                    fit: BoxFit.fill,
                    height: 34.h,
                    width: 30.w,
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                  Expanded(
                      child: Text(
                    data.name,
                    style: AppStyles.h4(),
                  )),
                  GestureDetector(onTap: (){

                    showDialog(context: context, builder:(context)=>DeleteConfirmationDialog(title:"Delete Country" , subTitle:"Are you sure want to delete country?", onTapYes: (){
                      _controller.deleteCountry(data.pivot.countryId, index);
                    }));
                  }, child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(Icons.delete_outline,size: 20.h,color: Colors.redAccent,),
                  )),
                  SizedBox(width: 5.w,)
                  // MaterialButton(
                  //   shape: const CircleBorder(),
                  //   padding: const EdgeInsets.all(0),
                  //   minWidth: 15,
                  //   onPressed: () {
                  //     _controller.deleteCountry(data.pivot.countryId, index);
                  //   },
                  //   child: const Icon(
                  //     Icons.close_outlined,
                  //     size: 18,
                  //   ),
                  // )
                ],
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: 10.h,
            );
          },
        ),
      ],
    );
  }

  _desiredDegree() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                "Desired Degree",
                style: AppStyles.h1(
                    fontWeight: FontWeight.w600, color: AppColors.greyColor),
              ),
            )),
            TextButton(
                onPressed: () {
                  Get.to(AddDesiredDegree(),transition:Transition.rightToLeft);
                },
                child: Text(
                  "Add New",
                  style: AppStyles.h4(color: Colors.redAccent),
                )),
            SizedBox(
              width: 8.w,
            )
          ],
        ),

        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          itemCount:  _controller.desiredDegree.length<4?_controller.desiredDegree.length:_controller.isSeeMoreDegree.value==true?_controller.desiredDegree.length:4,
          itemBuilder: (context, index) {
            var data = _controller.desiredDegree[index];
            return Container(
              // height: 40.h,
              // padding: EdgeInsets.symmetric(vertical:2.h),
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.borderColor),
                  borderRadius: BorderRadius.circular(8.r)),
              child: Row(
                children: [
                  SizedBox(width: 15.w,),

                  Expanded(
                      child: Text(
                    data.name!,
                    style: AppStyles.h4(),
                  )),
                  GestureDetector(onTap: (){
                  //  _controller.deleteDegree(data.pivot!.degreeId, index);
                  showDialog(context: context, builder:(context)=>DeleteConfirmationDialog(title:"Delete Degree" , subTitle:"Are you sure want to delete degree?", onTapYes: (){
                    _controller.deleteDegree(data.pivot!.degreeId, index);
                  }));
                  }, child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(Icons.delete_outline,size: 20.h,color: Colors.redAccent,),
                  )),
                  SizedBox(width: 5.w,)
                  // MaterialButton(
                  //   shape: const CircleBorder(),
                  //   padding: const EdgeInsets.all(0),
                  //   minWidth: 15,
                  //   onPressed: () {
                  //     _controller.deleteDegree(data.pivot!.degreeId, index);
                  //   },
                  //   child: const Icon(
                  //     Icons.close_outlined,
                  //     size: 18,
                  //   ),
                  // )
                ],
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: 10.h,
            );
          },
        )
      ],
    );
  }
}
