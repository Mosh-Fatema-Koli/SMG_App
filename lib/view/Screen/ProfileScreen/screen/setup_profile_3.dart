import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smg/model/search_degree_model.dart';
import 'package:smg/utils/app_icons.dart';
import 'package:smg/utils/app_images.dart';
import 'package:smg/utils/styles.dart';
import 'package:smg/view/Screen/ProfileScreen/Controller/setup_profile_controller.dart';
import 'package:smg/view/Widgets/custom_button.dart';
import 'package:smg/view/Widgets/custom_loader.dart';
import 'package:smg/view/Widgets/multiselect_degree.dart';
import 'package:smg/view/Widgets/select_tution_fee.dart';

import '../../../../model/country_model.dart';
import '../../../../utils/color.dart';
import '../../../Widgets/cache_network_image_url.dart';
import '../../../Widgets/multiselect_country.dart';

class SetupProfile3 extends StatefulWidget {
  const SetupProfile3({super.key});

  @override
  State<SetupProfile3> createState() => _SetupProfile3State();
}

class _SetupProfile3State extends State<SetupProfile3> {
  final _setupProfileController = Get.put(SetUpProfileController());

  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();
  RxList<CountryModel> selectCountry = <CountryModel>[].obs;
  RxList<SearchDegreeModel> selectDegree = <SearchDegreeModel>[].obs;
  var isEmpty = false.obs;
  var isDegreeEmpty = false.obs;
  var isTuitionFeeEmpty = false.obs;
  var selectTuitionFee = "".obs;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        extendBody: true,
        body: SafeArea(
          child: Obx(
            () => _setupProfileController.loading.value
                ? const CustomLoader()
                : SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 25.h,
                          ),

                          ClipRRect(
                              borderRadius: BorderRadius.circular(8.r),
                              child: Image.asset(
                                AppImages.drawerHeader,
                                height: 200.h,
                                width: double.infinity,
                                fit: BoxFit.fill,
                              )),

                          SizedBox(
                            height: 30.h,
                          ),

                          ///<------------------- Desired country ------------------->

                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Get.to(
                                      MultiSelectCountry(
                                        onSelectionChanged: (selectedItems) {
                                          // Handle the selected items here
                                          selectCountry.clear();
                                          selectCountry.addAll(selectedItems);
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
                                        border: isEmpty.value
                                            ? Border.all(
                                                color: Colors.redAccent,
                                                width: 1)
                                            : null),
                                    child: Row(
                                      children: [
                                        selectCountry.isEmpty
                                            ? Expanded(
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 10.h),
                                                  child: Text(
                                                    "Desired Country",
                                                    style: AppStyles.h3(
                                                        color: Get
                                                            .theme.hintColor),
                                                  ),
                                                ),
                                              )
                                            : Expanded(
                                                child: Wrap(
                                                    children:
                                                        selectCountry.map((e) {
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
                                                        CachedNetworkImageUrl(
                                                          imageUrl:e.flag!,
                                                        ),
                                                        SizedBox(
                                                          width: 8.w,
                                                        ),
                                                        Flexible(
                                                          child: Text(
                                                            e.name!,
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
                                                            setState(() {
                                                              selectCountry
                                                                  .remove(e);
                                                            });
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
                          if (isEmpty.value)
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 5.h),
                              child: Text(
                                "Required Field",
                                style: AppStyles.h5(color: Colors.redAccent),
                              ),
                            ),
                          SizedBox(
                            height: 15.h,
                          ),

                          ///  <-------------- Desired degree  --------------->

                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Get.to(
                                      MultiSelectDegree(
                                        onSelectionChanged: (selectedItems) {
                                          selectDegree.clear();
                                          selectDegree.addAll(selectedItems);
                                          if (kDebugMode) {
                                            print(
                                              "Selected Items: $selectedItems");
                                          }
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
                                                            setState(() {
                                                              selectDegree
                                                                  .remove(e);
                                                            });
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

                          if (isDegreeEmpty.value)
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 5.h),
                              child: Text(
                                "Required Field",
                                style: AppStyles.h5(color: Colors.redAccent),
                              ),
                            ),

                          ///  <-------------- tuition  --------------->
                          SizedBox(
                            height: 15.h,
                          ),

                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Get.to(
                                      TuitionCostSelect(
                                        onSelectionChanged: (select) {
                                          // Handle the selected items here
                                          selectTuitionFee.value = select;
                                          if (kDebugMode) {
                                            print(
                                                "Selected tuition free: $select");
                                          }
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
                                        border: isTuitionFeeEmpty.value
                                            ? Border.all(
                                                color: Colors.redAccent,
                                                width: 1)
                                            : null),
                                    child: Row(
                                      children: [
                                        selectTuitionFee.value.isEmpty
                                            ? Expanded(
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 10.h),
                                                  child: Text(
                                                    "Tuition Cost Per Year/USD",
                                                    style: AppStyles.h3(
                                                        color: Get
                                                            .theme.hintColor),
                                                  ),
                                                ),
                                              )
                                            : Expanded(
                                                child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10.h),
                                                child: Text(
                                                  "Below < $selectTuitionFee",
                                                  style: AppStyles.h3(),
                                                ),
                                              )),
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

                          if (isTuitionFeeEmpty.value)
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 5.h),
                              child: Text(
                                "Required Field",
                                style: AppStyles.h5(color: Colors.redAccent),
                              ),
                            ),

                          // DropDownString(items:_setupProfileController.tuitionFee.value,
                          //   validator: (value) {
                          //     if (value==null) {
                          //       return "Field is empty";
                          //     }
                          //     return null;
                          //   },
                          //
                          //   hintText: "Select tuition fee",
                          //   itemBuilder:(context, value,bool){
                          //     return ListTile(title: Text("Below < $value"));
                          //   },
                          //   dropdownBuilder: (context,value){
                          //     return value==null?Text("Select tuition fee",style: AppStyles.h4(color:Get.theme.hintColor),):Text("Below < $value");
                          //   },
                          //   onChanged: (value){
                          //     _setupProfileController.budgetCtrl.text=value!;
                          //     print(value);
                          //   },
                          //
                          // ),

                          SizedBox(
                            height: 30.h,
                          ),
                          CustomButton(
                              title: "Save",
                              onPressed: () async {
                                if (_formKey.currentState!.validate() &&
                                    selectCountry.isNotEmpty &&
                                    selectDegree.isNotEmpty &&
                                    selectTuitionFee.isNotEmpty) {
                                  await _setupProfileController
                                      .handleSelectDesiredDegree(selectDegree);
                                  await _setupProfileController
                                      .handleSelectCountry(selectCountry);
                                  _setupProfileController.handleSetupProfile3(
                                      selectTuitionFee.value);
                                }
                                if (selectDegree.isEmpty) {
                                  isDegreeEmpty.value = true;
                                }
                                if (selectCountry.isEmpty) {
                                  isEmpty.value = true;
                                }
                                if (selectTuitionFee.isEmpty) {
                                  isTuitionFeeEmpty.value = true;
                                }
                              }),
                          SizedBox(
                            height: 30.h,
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
