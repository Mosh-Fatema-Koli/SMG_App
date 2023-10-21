import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smg/model/search_degree_model.dart';
import 'package:smg/view/Widgets/custom_loader.dart';

import '../../controller/multiselect_degreee_controller.dart';
import '../../services/api_check.dart';
import '../../services/api_client.dart';
import '../../services/new_api_constant.dart';
import 'custom_button.dart';
class MultiSelectDegree extends StatefulWidget {
  final Function(List<SearchDegreeModel> selectedItems) onSelectionChanged;
  const MultiSelectDegree({super.key, required this.onSelectionChanged});

  @override
  State<MultiSelectDegree> createState() => _MultiSelectDegreeState();
}

class _MultiSelectDegreeState extends State<MultiSelectDegree> {
 // final _controller =Get.put(MultiSelectDegreeController());

  @override
  void initState() {
    searchFastDegree();
    super.initState();
  }

  TextEditingController searchController = TextEditingController();

  RxList<SearchDegreeModel> selectList=<SearchDegreeModel>[].obs;
  RxList<SearchDegreeModel> demoList=<SearchDegreeModel>[].obs;
  RxList<SearchDegreeModel> mainList=<SearchDegreeModel>[].obs;
  RxList<bool> selectedList=<bool>[].obs;


  var isLoading=false.obs;

  Future searchDegree(String? text) async {
    if(text != null && text.isNotEmpty) {
      var response = await ApiClient.getData("${NewApiConstant.degreeListApi}?title_like=$text&_limit=50");
      if(response.statusCode==200){
        demoList.value=[];
        demoList.value = List<SearchDegreeModel>.from(response.body['data']['degree_list'].map((x) => SearchDegreeModel.fromJson(x)));
        selectedList.value= List.generate(demoList.length, (index){
          bool check=false;
        //   selectList.forEach((element) {
        //     if(element.id==demoList[index].id){
        //       check=true;
        //     }else{
        //       check=false;
        //     }
        //   });
        //   return check;
          for(int i=0;i < selectList.length;i++){
            if(selectList[i].id==demoList[index].id){
              check=true;
              print("Select Value = $check");
            }
          }
          return check;

        });

        selectedList.refresh();
        demoList.refresh();
      }else{
        ApiChecker.checkApi(response);
      }
    }
  }

  Future searchFastDegree() async {
    isLoading(true);
    var response = await ApiClient.getData("${NewApiConstant.degreeListApi}?_limit=300");
    if(response.statusCode==200){
      mainList.value=[];
      mainList.value = List<SearchDegreeModel>.from(response.body['data']['degree_list'].map((x) => SearchDegreeModel.fromJson(x)));
     demoList.value=mainList.value;
      demoList.refresh();
      selectedList.value= List.generate(demoList.length, (index) => false);
      selectedList.refresh();
    }else{
      ApiChecker.checkApi(response);
    }
    isLoading(false);
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: const Text("Select Degree"),
      ),
      body: Obx(()=>isLoading.value?const CustomLoader ():
      Column(
        children: [
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
                 demoList.value=mainList.value;
                 selectedList.value=List.generate(demoList.length, (index){
                   bool check=false;
                   for(int i=0;i < selectList.length;i++){
                     if(selectList[i].id==demoList[index].id){
                       check=true;
                       print("Select Value = $check");
                     }
                   }
                   return check;
                 });

                 print("Main List = $mainList");
                 demoList.refresh();
                 selectedList.refresh();
                }else{
                  searchDegree(value);
                  // print("Degreelist length = ${_controller.degreeList.length}");
                  // print("DemoList length = ${_controller.demoList.length}");
                }

              },
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: selectedList.value.length,
              itemBuilder: (context, index) {
                final item = demoList[index];
                return Obx(()=>
                          ListTile(
                          title: Text(item.title!),
                          trailing: Checkbox(value:selectedList[index],
                              onChanged:(value){
                              if(selectedList[index]){
                                selectList.remove(item);
                                selectedList[index]=false;
                                selectList.refresh();
                                selectedList.refresh();
                              }else{
                                selectList.add(item);
                                selectedList[index]=true;
                                selectedList.refresh();
                                selectList.refresh();
                              }
                              }),
                          // trailing: selectedItems.contains(item)
                          //     ? const Icon(Icons.check_circle, color: Colors.green)
                          //     : null,
                          onTap: () {
                            if(selectedList[index]){
                              selectList.remove(item);
                              selectedList[index]=false;
                              selectList.refresh();
                              selectedList.refresh();
                            }else{
                              selectList.add(item);
                              selectedList[index]=true;
                              selectedList.refresh();
                              selectList.refresh();
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
          widget.onSelectionChanged(selectList);
          Get.back();
          selectList.clear();
        }),
      ),
    );

  }
}
