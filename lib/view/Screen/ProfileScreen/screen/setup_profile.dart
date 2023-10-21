import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:smg/model/search_degree_model.dart';
import 'package:smg/routes/routes.dart';
import 'package:smg/utils/app_images.dart';
import 'package:smg/utils/styles.dart';
import 'package:smg/view/Screen/ProfileScreen/Controller/setup_profile_controller.dart';
import 'package:smg/view/Screen/SettingScreen/Screen/PersonalInformation/Component/header_text.dart';
import 'package:smg/view/Widgets/custom_button.dart';
import 'package:smg/view/Widgets/custom_loader.dart';
import 'package:smg/view/Widgets/custom_text_form_field.dart';
import 'package:smg/view/Widgets/drop_down_single_page.dart';



class SetupProfile1 extends StatelessWidget {
  SetupProfile1({super.key});
  final _setupProfileController = Get.put(SetUpProfileController());

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      
                 ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: Image.asset(AppImages.drawerHeader,height:200.h,width: double.infinity,fit: BoxFit.fill,)),
      
                 ///<------------------- First Name ------------------->
                  SizedBox(
                    height: 30.h,
                  ),

                  CustomTextField(
                    controller: _setupProfileController.fastNameCtrl,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Field is empty";
                      }
                      return null;
                    },
                    hintText: 'First Name',
                  ),
      
                  ///<------------------- last Name ------------------->
                  SizedBox(
                    height: 15.h,
                  ),

                  CustomTextField(
                    controller: _setupProfileController.lastNameCtrl,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Field is empty";
                      }
                      return null;
                    },
                    hintText: 'Last Name',
                  ),
      
          
                  ///  <-------------- Date of Birth --------------->
                  SizedBox(
                    height: 15.h,
                  ),
                  CustomTextField(
                    hintText: 'Date of Birth',
                    readOnly: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Field is empty";
                      }
                      return null;
                    },
                    controller: _setupProfileController.dateOfBirthCtrl,
                    suffixIcon:const Icon(Icons.calendar_month),
                    onTap: () => _setupProfileController.selectDate(context),
                  ),


                  //<------------------ Gender ------------------->
                  SizedBox(
                    height: 15.h,
                  ),
                    CustomTextField(hintText:"Select Gender",readOnly: true,
                    controller: _setupProfileController.genderCtrl,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Field is empty";
                        }
                        return null;
                      },
                      suffixIcon: const Icon(Icons.arrow_drop_down),
                    onTap: (){
                      Get.to(DropDownSingleString(onSelectionChanged:(value){
                        _setupProfileController.genderCtrl.text=value;
                      }, itemList:_setupProfileController.genderList));
                    },
                    ),
                  // DropDownString(
                  //   items: _setupProfileController.genderList,
                  //   hintText: "Select gender",
                  //   constraints: BoxConstraints(minHeight: 150.h, maxHeight: 200.h),
                  //   onChanged: _setupProfileController.handleGenderChange,
                  //   validator: (val) {
                  //     if (val == null) {
                  //       return "Select your gender";
                  //     }
                  //     return null;
                  //   },
                  // ),
      
      
                  
      
               
                  SizedBox(
                    height: 40.h,
                  ),
                  CustomButton(
                      title: "Save",
                      onPressed: ()async {
      
                     if(_formKey.currentState!.validate()){
                       _setupProfileController.handleSetProfile();
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
 );
 
 
 
  }

 

  
}
