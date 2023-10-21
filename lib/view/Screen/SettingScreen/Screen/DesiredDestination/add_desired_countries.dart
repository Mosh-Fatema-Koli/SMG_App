import 'dart:core';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smg/model/country_model.dart';
import 'package:smg/utils/color.dart';
import 'package:smg/utils/styles.dart';
import 'package:smg/view/Screen/SettingScreen/Screen/DesiredDestination/Controller/destination_controller.dart';
import 'package:smg/view/Screen/SettingScreen/Screen/PersonalInformation/Component/header_text.dart';
import 'package:smg/view/Widgets/custom_button.dart';
import 'package:smg/view/Widgets/custom_loader.dart';
import '../../../../../utils/app_icons.dart';
import '../../../../Widgets/cache_network_image_url.dart';
import '../../../../Widgets/multiselect_country.dart';

class AddDesiredDestination extends StatefulWidget {
  const AddDesiredDestination({super.key});

  @override
  State<AddDesiredDestination> createState() => _AddDesiredDestinationState();
}

class _AddDesiredDestinationState extends State<AddDesiredDestination> {
   final _controller = Get.put(DestinationController());

    RxList<CountryModel> selectCountry=<CountryModel>[].obs;
    var isEmpty=false.obs;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Desired Countries"),
      ),
      body: Obx(()=>_controller.isLoading.value?const CustomLoader():
         SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 25.h,
              ),

              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        Get.to( MultiSelectCountry(
                          onSelectionChanged: (selectedItems) {
                            // Handle the selected items here
                            for (var element in selectedItems) {
                              if(selectCountry.contains(element)){

                              }else{
                                selectCountry.add(element);
                              }

                            }
                            print("Selected Items: $selectedItems");
                          },
                        ),);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15.w,vertical:10.h),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: Get.theme.inputDecorationTheme.fillColor,
                          border:isEmpty.value? Border.all(
                            color: Colors.redAccent,
                            width: 1
                          ):null
                        ),
                        child:Row(
                          children: [
                            selectCountry.isEmpty?Expanded(
                              child: Padding(
                                padding:  EdgeInsets.symmetric(vertical: 10.h),
                                child: Text("Select Desired Countries",style: AppStyles.h3(color:Get.theme.hintColor),),
                              ),
                            ): Expanded(
                              child: Wrap(
                                        children: selectCountry.map((e) {
                                      return Container(
                                        height: 32,
                                        padding: const EdgeInsets.only(left: 8, right: 1),
                                        margin:
                                            const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Theme.of(context).primaryColorLight,
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            CachedNetworkImageUrl(
                                              imageUrl: e.flag!,
                                            ),
                                            SizedBox(
                                              width: 8.w,
                                            ),
                                            Flexible(
                                              child: Text(
                                                e.name!,
                                                style: Theme.of(context).textTheme.titleSmall,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            MaterialButton(
                                              shape: const CircleBorder(),
                                              padding: const EdgeInsets.all(0),
                                              minWidth: 15,
                                              onPressed: () {
                                                setState(() {
                                                  selectCountry.remove(e);
                                                });
                                              },
                                              child: const Icon(
                                                Icons.close_outlined,
                                                size: 18,
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    }).toList()),
                            ),
                            Icon(Icons.arrow_drop_down,color: AppColors.greyColor,)
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width:10.w,),
                  GestureDetector(
                    onTap:(){},
                    child: Container(
                      padding: EdgeInsets.all(6.h),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          shape:BoxShape.circle,
                          border: Border.all(
                              color: Get.theme.dividerColor
                          )
                      ),
                      child: Image.asset(AppIcons.iIcon,height:15.h,width: 15.h,),
                    ),
                  )
                ],
              ),
              if(isEmpty.value)
              Padding(
                padding:  EdgeInsets.symmetric(vertical:5.h),
                child: Text("Required Field",style: AppStyles.h5(color: Colors.redAccent),),
              ),



              SizedBox(
                height: 20.h,
              ),
              CustomButton(title: "Update", onPressed: () {

                if(selectCountry.isEmpty){
                  isEmpty.value=true;
                }else{
                  _controller.handleAddDesiredCountry(selectCountry);
                }



              })
            ],
          ),
        ),
      )
    );
  }
}
