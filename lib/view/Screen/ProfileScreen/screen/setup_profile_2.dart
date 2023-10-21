import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:smg/model/search_degree_model.dart';
import 'package:smg/utils/app_images.dart';
import 'package:smg/utils/styles.dart';
import 'package:smg/view/Screen/ProfileScreen/Controller/setup_profile_controller.dart';
import 'package:smg/view/Screen/SettingScreen/Screen/PersonalInformation/Component/header_text.dart';
import 'package:smg/view/Widgets/custom_button.dart';
import 'package:smg/view/Widgets/custom_loader.dart';
import 'package:smg/view/Widgets/custom_text_form_field.dart';
import 'package:smg/view/Widgets/drop_down_last_achieved_degree.dart';


import '../../../../routes/routes.dart';
import '../../../Widgets/drop_down_single_page.dart';
class SetupProfile2 extends StatelessWidget {
   SetupProfile2({super.key});
    final _setupProfileController = Get.put(SetUpProfileController());

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async=>false,
      child: Scaffold(
        extendBody: true,
        body: SafeArea(
          child: Obx(()=>_setupProfileController.loading.value?const CustomLoader():
             SingleChildScrollView(
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
            
                   ///<------------------- Image ------------------->
             
             ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: Image.asset(AppImages.drawerHeader,height:200.h,width: double.infinity,fit: BoxFit.fill,)),
              
                
              ///<------------------- Last Achieved Degree ------------------->
              SizedBox(
                      height: 30.h,
                    ),
                        CustomTextField(
                          hintText:"Select Last Achieved Degree",
                          readOnly: true,
                        controller:_setupProfileController.lastAchievedDegreeCtrl,
                        suffixIcon: const Icon(Icons.arrow_drop_down),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Field is empty";
                            }
                            return null;
                          },
                            onTap: (){
                         Get.to( LastAchievedDegreeDropDown(onSelectionChanged:(value){
                           _setupProfileController.lastAchievedDegreeCtrl.text=value.title!;
                           _setupProfileController.selectDegree.value=value.id!;

                         }));
                        },),

            
                    ///  <-------------- CGPA --------------->

                    SizedBox(
                      height: 15.h,
                    ),

                    CustomTextField(
                      controller: _setupProfileController.cgpaCtrl,
                      keyboardType:TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Field is empty";
                        }
                        return null;
                      },
                      hintText: 'CGPA',
                    ),
                    ///  <-------------- Starting year --------------->
                    SizedBox(
                      height: 15.h,
                    ),
                    CustomTextField(hintText:"Select Starting Year",
                      readOnly: true,
                      suffixIcon: const Icon(Icons.arrow_drop_down),
                      controller: _setupProfileController.startingYearCtrl,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Field is empty";
                        }
                        return null;
                      },
                      onTap: (){
                        Get.to(DropDownSingleString(onSelectionChanged:(value){
                          _setupProfileController.startingYearCtrl.text=value;
                        }, itemList:_setupProfileController.generateYears()));
                      },
                    ),
                    ///  <-------------- Passing year --------------->
                    SizedBox(
                      height: 15.h,
                    ),
                    CustomTextField(hintText:"Select Passing Year",
                    readOnly: true,
                      suffixIcon: const Icon(Icons.arrow_drop_down),
                      controller: _setupProfileController.passingYearCtrl,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Field is empty";
                        }
                        return null;
                      },
                      onTap: (){
                        Get.to(DropDownSingleString(onSelectionChanged:(value){
                          _setupProfileController.passingYearCtrl.text=value;
                        }, itemList:_setupProfileController.generateYears()));
                      },
                    ),



                 // DropDownString(items:_setupProfileController.generateYears(),
                 //   validator: (value) {
                 //          if (value==null) {
                 //          return "Field is empty";
                 //         }
                 //         return null;
                 //      },
                 //     onChanged: (value){
                 //   _setupProfileController.passingYearCtrl.text=value!;
                 //     },
                 //  hintText: "Select passing year"),



                    // CustomTextField(
                    //   controller: _setupProfileController.passingYearCtrl,
                    //   keyboardType:TextInputType.number,
                    //   validator: (value) {
                    //     if (value!.isEmpty) {
                    //       return "Field is empty";
                    //     }
                    //     return null;
                    //   },
                    //   hintText: 'Enter your passing year',
                    // ),
        
            
                    SizedBox(
                      height: 40.h,
                    ),
                    CustomButton(
                        title: "Save",
                        onPressed: ()async {
                        if(_formKey.currentState!.validate()){
                          _setupProfileController.handleSetupProfile2();
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