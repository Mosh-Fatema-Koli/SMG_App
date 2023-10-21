import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smg/view/Widgets/custom_button.dart';
import 'package:smg/view/Widgets/custom_loader.dart';

import '../../../../../Widgets/custom_text_form_field.dart';
import '../Controller/personal_information_controller.dart';


class PersonalInfoUpdate extends StatelessWidget {
   PersonalInfoUpdate({super.key});
  final _controller = Get.put(PersonalInformationController());
   final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _controller.setPersonalInfo();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Personal Info Update"),
      ),
      body:  Obx(()=>_controller.loading.value?const CustomLoader():
         SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height:15.h,),
                /// <------------------ Fast name -------------->

                CustomTextField(
                  controller: _controller.fastNameCtrl,
                  hintText: "First Name",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Field is empty";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10.h,
                ),
               /// <------------------ Middle name -------------->

                CustomTextField(
                  controller: _controller.middleCtrl,
                  hintText: "Middle Name",
                ),
                SizedBox(
                  height: 10.h,
                ),
               /// <------------------ Last name -------------->

                CustomTextField(
                  hintText: "Last Name",
                  controller: _controller.lastNameCtrl,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Field is empty";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10.h,
                ),
                /// <------------------ father name -------------->

                CustomTextField(
                  hintText: "Father Name",
                  controller: _controller.fatherNameCtrl,
                ),
                SizedBox(
                  height: 10.h,
                ),

                /// <------------------ Mother name -------------->

                CustomTextField(
                  hintText: "Mother Name",
                  controller: _controller.motherNameCtrl,
                ),
                SizedBox(
                  height: 30.h,
                ),

                CustomButton(title: "Update", onPressed: (){
                  if(_formKey.currentState!.validate()){
                    _controller.updatePersonalInfo();
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
