import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smg/utils/color.dart';
import 'package:smg/view/Widgets/custom_button.dart';
import 'package:smg/view/Widgets/custom_loader.dart';
import 'package:smg/view/Widgets/drop_down_single_page.dart';


import '../../../../../Widgets/custom_text_form_field.dart';
import '../Controller/personal_information_controller.dart';


class BasicInfoUpdate extends StatelessWidget {
   BasicInfoUpdate({super.key});
  final _controller = Get.put(PersonalInformationController());
   final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _controller.setBasicInfo();
    return Scaffold(
      appBar:AppBar(
        title: const Text("Basic Info Update"),
      ),
      body: Obx(()=>_controller.loading.value?const CustomLoader():
         SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal:16.w),
          child:
          Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 20.h,),

                // DropDownString(
                //   items: _controller.genderList,
                //   hintText: "Select gender",
                //   constraints: BoxConstraints(minHeight: 150.h, maxHeight: 200.h),
                //   onChanged: _controller.handleGenderChange,
                //   validator: (val) {
                //     if (val == null) {
                //       return "Select your gender";
                //     }
                //     return null;
                //   },
                // ),


                  CustomTextField(hintText:"Select Gender",readOnly: true,
                    controller: _controller.genderCtrl,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Field is empty";
                        }
                        return null;
                      },
                      suffixIcon: const Icon(Icons.arrow_drop_down),
                    onTap: (){
                      Get.to(DropDownSingleString(onSelectionChanged:(value){
                        _controller.genderCtrl.text=value;
                      }, itemList:_controller.genderList));
                    },
                    ),

                // ///<------------------- Sex ------------------->
                // const HeaderText(text: 'Sex'),
                // DropDownString(
                //   items: _controller.sexList,
                //   hintText: "Select Sex",
                //   constraints: BoxConstraints(minHeight: 150.h, maxHeight: 200.h),
                //   onChanged: _controller.handleSexChange,
                // ),

                ///<------------------- Nationality Number ------------------->
                SizedBox(
                  height: 10.h,
                ),
                CustomTextField(
                  controller: _controller.nationalityCtrl,
                  hintText: 'Nationality',

                ),

                ///  <-------------- Date of Birth --------------->
                SizedBox(
                  height: 10.h,
                ),

                CustomTextField(
                    readOnly: true,
                    controller: _controller.dateOfBirthCtrl,
                    suffixIcon: Icon(Icons.calendar_month_outlined,color:AppColors.greyColor,),
                    onTap: (){
                      _controller.selectDate(context);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Field is empty";
                      }
                      return null;
                    },
                    hintText:"Date of Birth"),


                ///<------------------- NID Number ------------------->
                SizedBox(
                  height: 10.h,
                ),
                CustomTextField(
                  hintText: 'NID Number',
                  controller: _controller.nidCtrl,
                  keyboardType: TextInputType.number,
                ),

                ///<------------------- Passport Number ------------------->
                SizedBox(
                  height: 10.h,
                ),
                CustomTextField(
                  hintText: 'Passport Number',
                  controller: _controller.passportCtrl,
                  keyboardType: TextInputType.number,
                ),
                  SizedBox(height:30.h,),
                CustomButton(title:"Update", onPressed: (){
                  if(_formKey.currentState!.validate()){
                    _controller.updateBasicInfo();
                  }


                })




              ],
            ),
          ),
        ),
      ),

    );
  }
}
