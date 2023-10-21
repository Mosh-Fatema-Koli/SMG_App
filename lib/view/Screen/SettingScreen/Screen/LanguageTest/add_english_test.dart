import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smg/model/language_model.dart';
import 'package:smg/utils/styles.dart';
import 'package:smg/view/Screen/SettingScreen/Screen/LanguageTest/Controller/english_test_controller.dart';
import 'package:smg/view/Screen/SettingScreen/Screen/PersonalInformation/Component/header_text.dart';
import 'package:smg/view/Widgets/custom_button.dart';
import 'package:smg/view/Widgets/custom_loader.dart';
import 'package:smg/view/Widgets/custom_text_form_field.dart';
import 'package:smg/view/Widgets/drop_down_select_language.dart';

import '../../../../../utils/color.dart';

class AddEnglishTest extends StatelessWidget {
  AddEnglishTest({super.key});
  final _controller = Get.put(AddEnglishTestController());
  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    _controller.getLanguage();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Language Test"),
      ),
      body: Obx(
        () => _controller.loading.value
            ? const CustomLoader()
            : SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                physics: const BouncingScrollPhysics(),
                child: Form(
                  key: _key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 25.h,
                      ),
                      CustomTextField(hintText:"Select Language Test",
                        readOnly: true,
                      controller: _controller.selectLanguageCtrl,
                      validator: (value){
                        if(value!.isEmpty){
                          return "Required Field";
                        }
                        return null;
                      },
                      onTap: (){
                        Get.to(DropDownLanguage(onSelectionChanged: (
                            LanguageModel languageModel) {
                          _controller.selectLanguageCtrl.text=languageModel.name;
                          _controller.selectLanguageId.value=languageModel.id;
                          _controller.levelList.value=languageModel.levels;
                          _controller.selectLevelCtrl.clear();
                          _controller.levelList.refresh();
                        },
                          itemList:_controller.languageList,));
                      },
                      suffixIcon: const Icon(Icons.arrow_drop_down),
                      ),

                      SizedBox(
                        height: 15.h,
                      ),
                      CustomTextField(hintText:"Select Level",
                        controller: _controller.selectLevelCtrl,
                        readOnly: true,
                        validator: (value) {
                          if (value!.isEmpty && _controller.overallScoreCtrl.text.isEmpty ) {
                            return "Please select level or Overall Score";
                          }
                          return null;
                        },
                        onTap: (){
                          Get.to(DropDownLanguage(onSelectionChanged: (
                              LanguageModel languageModel) {
                            _controller.selectLevelCtrl.text=languageModel.name;
                          },
                            itemList:_controller.levelList,));
                        },
                        suffixIcon: const Icon(Icons.arrow_drop_down),
                      ),

                      SizedBox(
                        height: 15.h,
                      ),

                      CustomTextField(
                        controller: _controller.overallScoreCtrl,
                        keyboardType: TextInputType.number,
                        hintText: "Overall Score",
                        validator: (value) {
                          if (value!.isEmpty && _controller.selectLevelCtrl.text.isEmpty ) {
                            return "Please select level or Overall Score";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 80.h,
                      ),
                      CustomButton(
                          title: "Save",
                          onPressed: () {
                            if (_key.currentState!.validate()) {
                              _controller.handleLanguageAdd();
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
