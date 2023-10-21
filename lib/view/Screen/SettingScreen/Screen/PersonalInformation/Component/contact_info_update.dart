import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smg/view/Screen/SettingScreen/Screen/PersonalInformation/Controller/personal_information_controller.dart';
import 'package:smg/view/Widgets/custom_button.dart';
import 'package:smg/view/Widgets/custom_loader.dart';

import '../../../../../Widgets/custom_text_form_field.dart';


class ContactInfoUpdate extends StatelessWidget {
   ContactInfoUpdate({super.key});
  final _controller = Get.put(PersonalInformationController());
  @override
  Widget build(BuildContext context) {
    _controller.setContactInfo();
    return Scaffold(
      appBar: AppBar(title: const Text("Contact Info Update"),),
      body: Obx(()=>_controller.loading.value?const CustomLoader()
        : SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal:16.w),
          child: Column(
            children: [
              SizedBox(height: 20.h,),
              ///<------------------- Phone Number ------------------->

              CustomTextField(
                controller: _controller.phoneCtrl,
                hintText: 'Phone Number',
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Field is empty";
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 40.h,),
              CustomButton(title:"Update", onPressed: (){
                _controller.updateContactInfo();

              })



            ],
          ),
        ),
      ),
    );
  }
}
