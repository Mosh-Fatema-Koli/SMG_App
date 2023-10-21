import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:smg/view/Screen/SettingScreen/Screen/DesiredDestination/Controller/destination_controller.dart';
import 'package:smg/view/Widgets/custom_button.dart';
import 'package:smg/view/Widgets/custom_loader.dart';

import '../../../../../model/search_degree_model.dart';
import '../../../../../utils/app_icons.dart';
import '../../../../../utils/color.dart';
import '../../../../../utils/styles.dart';
import '../../../../Widgets/multiselect_degree.dart';
import '../PersonalInformation/Component/header_text.dart';

class AddDesiredDegree extends StatelessWidget {
   AddDesiredDegree({super.key});

  final _controller=Get.put(DestinationController());

   final _formKey = GlobalKey<FormState>();

   RxList<SearchDegreeModel> selectDegree = <SearchDegreeModel>[].obs;

   var isDegreeEmpty = false.obs;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Add Desired Degree"),
      ),
      body: Obx(()=> _controller.loading.value?const CustomLoader():
         SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(
                height: 15.h,
              ),

              Obx(()=>
                 Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Get.to(
                            MultiSelectDegree(
                              onSelectionChanged: (selectedItems) {
                                // Handle the selected items here
                                for (var element in selectedItems) {
                                  if (selectDegree
                                      .contains(element)) {
                                  } else {
                                    selectDegree.add(element);
                                  }
                                }
                                print(
                                    "Selected Items: $selectedItems");
                              },
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.w, vertical: 10.h),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(8.r),
                              color: Get.theme.inputDecorationTheme
                                  .fillColor,
                              border: isDegreeEmpty.value
                                  ? Border.all(
                                  color: Colors.redAccent,
                                  width: 1)
                                  : null),
                          child: Row(
                            children: [
                              selectDegree.isEmpty
                                  ? Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10.h),
                                  child: Text(
                                    "Desired Degree",
                                    style: AppStyles.h3(
                                        color: Get
                                            .theme.hintColor),
                                  ),
                                ),
                              )
                                  : Expanded(
                                child: Wrap(
                                    children:
                                    selectDegree.map((e) {
                                      return Container(
                                        height: 32,
                                        padding:
                                        const EdgeInsets.only(
                                            left: 8, right: 1),
                                        margin: const EdgeInsets
                                            .symmetric(
                                            horizontal: 2,
                                            vertical: 1),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(
                                              10),
                                          color: Theme.of(context)
                                              .primaryColorLight,
                                        ),
                                        child: Row(
                                          mainAxisSize:
                                          MainAxisSize.min,
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                e.title!,
                                                style: Theme.of(
                                                    context)
                                                    .textTheme
                                                    .titleSmall,
                                                overflow:
                                                TextOverflow
                                                    .ellipsis,
                                              ),
                                            ),
                                            MaterialButton(
                                              shape:
                                              const CircleBorder(),
                                              padding:
                                              const EdgeInsets
                                                  .all(0),
                                              minWidth: 15,
                                              onPressed: () {
                                                  selectDegree.value
                                                      .remove(e);
                                                  selectDegree.refresh();
                                              },
                                              child: const Icon(
                                                Icons
                                                    .close_outlined,
                                                size: 18,
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    }).toList()),
                              ),
                              Icon(
                                Icons.arrow_drop_down,
                                color: AppColors.greyColor,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.all(6.h),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Get.theme.dividerColor)),
                        child: Image.asset(
                          AppIcons.iIcon,
                          height: 15.h,
                          width: 15.h,
                        ),
                      ),
                    )
                  ],
                ),
              ),

              if (isDegreeEmpty.value)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.h),
                  child: Text(
                    "Required Field",
                    style: AppStyles.h5(color: Colors.redAccent),
                  ),
                ),
              SizedBox(height: 30.h,),

              CustomButton(title:"Update", onPressed:(){

                if(selectDegree.isNotEmpty){
                  _controller.handleSelectDesiredDegree(selectDegree);
                  _controller.updateDesiredDegree();
                }else{
                  isDegreeEmpty.value=true;
                }


              })








            ],
          ),
        ),
      ),

    );
  }
}
