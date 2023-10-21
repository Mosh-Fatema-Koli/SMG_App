import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smg/view/Widgets/custom_button.dart';
import 'package:smg/view/Widgets/custom_loader.dart';
import 'package:smg/view/Widgets/custom_text_form_field.dart';
import 'package:smg/view/Widgets/select_tution_fee.dart';


import '../Controller/personal_information_controller.dart';


class TuitionPerYear extends StatelessWidget {
   TuitionPerYear({super.key});
  final _controller = Get.put(PersonalInformationController());
  final  selectTuitionFee = "".obs;
     final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    _controller.setTuitionFee();
  
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Tuition"),
      ),
      body: Obx(()=>_controller.loading.value?const CustomLoader():
         SingleChildScrollView(
           child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 16.w),
            child: Form(
              key:_formKey ,
              child: Column(
                children: [
                  SizedBox(height: 30.h,),
                  ///<------------------- Tuition costs per year  ------------------->
                  ///
                  ///
                     CustomTextField(hintText:"Tuition Cost Per Year/USD",readOnly: true,
                      controller: _controller.tuitionCostCtrl,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Field is empty";
                          }
                          return null;
                        },
                        suffixIcon: const Icon(Icons.arrow_drop_down),
                      onTap: (){
                        Get.to(
                               TuitionCostSelect(
                                          onSelectionChanged: (select) {
                                            // Handle the selected items here
                                            _controller.tuitionCostCtrl.text="Below < $select";
                                            selectTuitionFee.value = select;
                                            if (kDebugMode) {
                                              print(
                                                  "Selected tuition free: $select");
                                            }
                                          },
                                        ),
                                      );
                      },
                      ),
                 
                     
                
                    SizedBox(height: 30.h,),
                  CustomButton(title:"Update", onPressed: (){
                    if(_formKey.currentState!.validate()){
                         _controller.updateTuitionPerYear(selectTuitionFee.toString());
                    }


               
            
                  })
            
            
                ],
              ),
            ),
        ),
         ),
      ),

    );
  }
}
