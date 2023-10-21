import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smg/view/Screen/SettingScreen/Screen/PersonalInformation/Controller/personal_information_controller.dart';
import 'package:smg/view/Widgets/custom_button.dart';
import 'package:smg/view/Widgets/custom_loader.dart';
import 'package:smg/view/Widgets/custom_text_form_field.dart';
import 'package:smg/view/Widgets/drop_down_address.dart';

class CurrentAddressAdd extends StatelessWidget {
   CurrentAddressAdd({super.key});
    final _controller=Get.put(PersonalInformationController());
    final _key=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    _controller.getAllAddress();
    return Scaffold(
      appBar: AppBar(title:const Text("Current Address"),),
      body: Obx(()=>_controller.isGetAddressLoading.value?const CustomLoader():
         SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 15.h),
          child:
          Form(
            key:_key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height:15.h,),
                CustomTextField(
                  hintText:"Address",
                  controller:_controller.currentCtrl,
                  validator: (value){
                    if(value!.isEmpty){
                      return "Requerd Field";
                    }
                    return null;
                  },
                ),
                SizedBox(height:15.h,),
                CustomTextField(
                  hintText:"Select Division",
                  readOnly: true,
                  controller: _controller.currentDivisionCtrl,
                  validator: (value){
                    if(value!.isEmpty){
                      return "Requerd Field";
                    }
                    return null;
                  },
                  suffixIcon: const Icon(Icons.arrow_drop_down),
                  onTap: () {
                    Get.to(DropDownAddress(onSelectionChanged:(value){
                      _controller.currentDivisionCtrl.text=value.name;
                      _controller.selectCurrentDivisionId.value=value.id;
                      _controller.currentDistrictCtrl.clear();
                      _controller.selectCurrentDistrictId.value=(-1);
                      _controller.allDistrict.value=(value.districts ?? []);
                    }, itemList:_controller.allDivision));

                  }
                ),
                SizedBox(height:15.h,),
                CustomTextField(
                  hintText:"Select District",
                  readOnly: true,
                  controller: _controller.currentDistrictCtrl,
                  validator: (value){
                    if(value!.isEmpty){
                      return "Requerd Field";
                    }
                    return null;
                  },
                  suffixIcon: const Icon(Icons.arrow_drop_down),
                  onTap: (){
                    Get.to(DropDownAddress(onSelectionChanged:(value){
                      _controller.currentDistrictCtrl.text=value.name;
                      _controller.selectCurrentDistrictId.value=value.id;
                    }, itemList:_controller.allDistrict));
                  },
                ),
                SizedBox(height:15.h,),
                CustomTextField(
                  hintText:"Zip Code",
                  controller:_controller.currentZipCodeCtrl,
                ),
                SizedBox(height: 30.h,),
                CustomButton(title:"Update", onPressed:(){
                  if(_key.currentState!.validate()){
                    _controller.currentAddressUpdate();
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
