
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../services/api_check.dart';
import '../../services/api_client.dart';
import '../../services/api_constant.dart';
import 'custom_loader.dart';

class TuitionCostSelect extends StatefulWidget {
  final Function(String selectFee) onSelectionChanged;
  const TuitionCostSelect({super.key, required this.onSelectionChanged});

  @override
  State<TuitionCostSelect> createState() => _TuitionCostSelectState();
}

class _TuitionCostSelectState extends State<TuitionCostSelect> {

  TextEditingController searchController = TextEditingController();

  var loading=false.obs;
  RxList<String> tuitionFee=<String>[].obs;
  RxList<String> searchTuitionFee=<String>[].obs;


  @override
  void initState() {
    getTuitionFee();
    super.initState();
  }

  getTuitionFee()async{
    loading(true);

      int max=10000000;
      int min=1000;
      int step=1000;
      List<String> result = [];

      for (int i = min; i <= max; i += step) {
        result.add(i.toString());
      }
      if(int.parse(result.last)!=max){
        result.add(max.toString());
      }
      tuitionFee.value=result;
      searchTuitionFee.value=result;
      searchTuitionFee.refresh();

    loading(false);
  }


    Future search(String? text) async {
    searchTuitionFee.value=tuitionFee
        .where((item) =>
        item.toLowerCase().contains(text!.toLowerCase()))
        .toList();
        searchTuitionFee.refresh();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: const Text("Select Tuition Cost Per Year?USD"),
      ),
      body: Obx(()=>loading.value?const CustomLoader ():
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              keyboardType:TextInputType.number,
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
                if(value.isNotEmpty){
                  search(value);
                }else{
                  searchTuitionFee.value=tuitionFee;
                  searchTuitionFee.refresh();
                }
              },
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount:searchTuitionFee.length,
              itemBuilder: (context, index) {
                final item = searchTuitionFee[index];
                return
                    ListTile(
                      title: Text("Below <$item"),
                      onTap: () {
                        widget.onSelectionChanged(item);
                        Get.back();

                      },

                );
              },
            ),
          ),
        ],
      ),
      ),
    );

  }
}


