import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smg/controller/multi_select_country_controller.dart';
import 'package:smg/view/Widgets/custom_button.dart';
import 'package:smg/view/Widgets/custom_loader.dart';
import 'package:smg/view/Widgets/custom_text_form_field.dart';

import '../../model/country_model.dart';
import '../../services/api_check.dart';
import '../../services/api_client.dart';
import '../../services/api_constant.dart';
import 'cache_network_image_url.dart';

class MultiSelectCountry extends StatelessWidget {
  final Function(List<CountryModel> selectedItems) onSelectionChanged;

   MultiSelectCountry({super.key, required this.onSelectionChanged});
   final _controller =Get.put(MultiSelectCountryController());

  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    _controller.getCountry();
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: const Text("Select Country",),
      ),
      body: Obx(()=>_controller.isLoading.value?const CustomLoader ():
         Column(
          children:[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  labelText: "Search",
                  filled: false,
                  focusedBorder: OutlineInputBorder(  borderSide: BorderSide(
                      color: Get.theme.dividerColor
                  )),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Get.theme.dividerColor
                    )
                  ),
                  contentPadding: EdgeInsets.only(left: 15.w),
                ),
                onChanged: (value) {
                  if(value.isEmpty){
                    _controller.demoList.value=_controller.countryList;
                  }else{
                    _controller.demoList.value =_controller.countryList
                        .where((item) =>
                        item.name!.toLowerCase().contains(value.toLowerCase()))
                        .toList();
                  }
                },
             ),
           ),

            Expanded(
              child: ListView.builder(
                itemCount: _controller.demoList.length,
                itemBuilder: (context, index) {
                  final item = _controller.demoList[index];
                  print(item.flag!);
                  return Obx(()=>
                     ListTile(
                      minLeadingWidth: 30.w,
                      dense: true,
                          leading:CachedNetworkImageUrl(
                                      imageUrl:item.flag!,
                                      height: 35.h,
                                      width: 35.w,
                                      fit: BoxFit.fill,
                                    ),
                      title: Text(item.name!),
                      trailing: Checkbox(value: _controller.selectedList.contains(item),
                          onChanged:(value){
                              if (_controller.selectedList.contains(item)) {
                                _controller.selectedList.remove(item);
                              } else {
                                _controller.selectedList.add(item);
                              }

                      }),
                      // trailing: selectedItems.contains(item)
                      //     ? const Icon(Icons.check_circle, color: Colors.green)
                      //     : null,
                      onTap: () {
                          if (_controller.selectedList.contains(item)) {
                            _controller.selectedList.remove(item);
                          } else {
                            _controller.selectedList.add(item);
                          }

                      },
                    ),
                  );
                },
              ),
            ),

          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      resizeToAvoidBottomInset: false,
      floatingActionButton:  Container(
        padding:  EdgeInsets.symmetric(horizontal: 16.w,vertical: 15.h),
        // color: Get.theme.canvasColor,
        child: CustomButton(title: "Ok", onPressed:(){
          onSelectionChanged(_controller.selectedList);
          Get.back();
          _controller.selectedList.clear();
        }),
      ),
    );

}

}
