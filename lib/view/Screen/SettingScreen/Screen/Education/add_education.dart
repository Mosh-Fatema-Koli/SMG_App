import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:smg/utils/styles.dart';
import 'package:smg/view/Screen/SettingScreen/Screen/Education/Controller/education_controller.dart';
import 'package:smg/view/Screen/SettingScreen/Screen/PersonalInformation/Component/header_text.dart';
import 'package:smg/view/Widgets/custom_button.dart';
import 'package:smg/view/Widgets/custom_loader.dart';
import 'package:smg/view/Widgets/custom_text_form_field.dart';
import '../../../../../model/search_degree_model.dart';
import '../../../../Widgets/drop_down_last_achieved_degree.dart';
import '../../../../Widgets/drop_down_single_page.dart';



class AddEducation extends StatelessWidget {
  AddEducation({super.key});
  final _controller = Get.put(EducationController());
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Education"),
      ),
      body: Obx(
        () => _controller.isLoading.value
            ? const CustomLoader()
            : SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Form(
                  key: _key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 25.h,
                      ),
                      ///<=-------------------- Degree -------------=>
                      CustomTextField(
                        hintText:"Select Degree",
                        readOnly: true,
                        controller:_controller.degreeCtrl,
                        suffixIcon: const Icon(Icons.arrow_drop_down),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Field is empty";
                          }
                          return null;
                        },
                        onTap: (){
                          Get.to(LastAchievedDegreeDropDown(onSelectionChanged:(value){
                            _controller.degreeCtrl.text=value.title!;
                            _controller.selectDegreeId.value=value.id!;

                          }));
                        },),



                      //<=-------------------- Grade -------------=>
                      SizedBox(
                        height: 10.h,
                      ),

                      CustomTextField(
                        controller: _controller.gpaCtrl,
                        hintText: "CGPA",
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Required field";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                      ),

                      //<=-------------------- Score Percentage -------------=>
                      SizedBox(
                        height: 10.h,
                      ),

                      CustomTextField(
                        hintText: "Score Percentage/%",
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Required field";
                          }
                          return null;
                        },
                        controller: _controller.scoreCtrl,
                        keyboardType: TextInputType.number,
                      ),

                      //<=-------------------- Passing year -------------=>
                      SizedBox(
                        height: 10.h,
                      ),

                      // CustomTextField(
                      //   controller: _controller.passingYearCtrl,
                      //   keyboardType: TextInputType.number,
                      //   hintText: "Enter your passing year",
                      //   validator: (value) {
                      //     if (value!.isEmpty) {
                      //       return "Required field";
                      //     }
                      //     return null;
                      //   },
                      // ),

                      CustomTextField(hintText:"Select Passing Year",
                        readOnly: true,
                        suffixIcon: const Icon(Icons.arrow_drop_down),
                        controller:_controller.passingYearCtrl,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Field is empty";
                          }
                          return null;
                        },
                        onTap: (){

                          Get.to(DropDownSingleString(onSelectionChanged:(value){
                            _controller.passingYearCtrl.text=value;
                          }, itemList:_controller.generateYears()));
                        },
                      ),
                      //<=-------------------- Min GPA -------------=>
                      SizedBox(
                        height: 10.h,
                      ),

                      CustomTextField(
                        controller: _controller.minGpaCtrl,
                        hintText: "Minimum GPA",
                        keyboardType: TextInputType.number,
                      ),
                      //<=-------------------- Maximum GPA -------------=>
                      SizedBox(
                        height: 10.h,
                      ),

                      CustomTextField(
                        hintText: "Maximum GPA",
                        controller: _controller.maxGpaCtrl,
                        keyboardType: TextInputType.number,
                      ),

                      //<=-------------------- Credit Hours -------------=>
                      SizedBox(
                        height: 10.h,
                      ),

                      CustomTextField(
                        hintText: "Credit Hours",
                        controller: _controller.creditHoursCtrl,
                        keyboardType: TextInputType.number,
                      ), //<=-------------------- starting_year -------------=>
                      SizedBox(
                        height: 10.h,
                      ),

                      CustomTextField(hintText:"Select Starting Year",
                        readOnly: true,
                        suffixIcon: const Icon(Icons.arrow_drop_down),
                        controller:_controller.startingYearCtrl,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Field is empty";
                          }
                          return null;
                        },
                        onTap: (){

                          Get.to(DropDownSingleString(onSelectionChanged:(value){
                            _controller.startingYearCtrl.text=value;
                          }, itemList:_controller.generateYears()));
                        },
                      ),

                      SizedBox(
                        height: 30.h,
                      ),
                      CustomButton(
                          title: "Save",
                          onPressed: () {
                            if (_key.currentState!.validate()) {
                              _controller.handleAddEduction();
                            }
                          }),
                      SizedBox(
                        height:10.h,
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

 
}
