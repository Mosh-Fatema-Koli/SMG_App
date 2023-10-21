import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:smg/services/new_api_constant.dart';

import '../../model/search_degree_model.dart';
import '../../services/api_check.dart';
import '../../services/api_client.dart';
import '../../services/api_constant.dart';

class LastAchievedDegreeDropDown extends StatefulWidget {
  final Function(SearchDegreeModel searchDegreeModel) onSelectionChanged;
  const LastAchievedDegreeDropDown({super.key,required this.onSelectionChanged});

  @override
  State<LastAchievedDegreeDropDown> createState() => _LastAchievedDegreeDropDownState();
}

class _LastAchievedDegreeDropDownState extends State<LastAchievedDegreeDropDown> {

  TextEditingController searchController = TextEditingController();
  List<SearchDegreeModel>  searchList=[];
  List<SearchDegreeModel>  initList=[];

  var isLoading=false;

  @override
  void initState() {
      initDegree();
    super.initState();
  }


  Future searchDegree(String? text) async {
    if(text != null && text.isNotEmpty) {
      setState(() {
        isLoading=true;
      });
      var response = await ApiClient.getData("${NewApiConstant.degreeListApi}?title_like=$text&_limit=50");
      if(response.statusCode==200){
        setState(() {
          searchList=[];
          searchList= List<SearchDegreeModel>.from(response.body['data']['degree_list'].map((x) => SearchDegreeModel.fromJson(x)));
        });

      }else{
        ApiChecker.checkApi(response);
      }
      setState(() {
        isLoading=false;
      });
    }
  }

  Future initDegree() async {
    setState(() {
      isLoading=true;
    });
    var response = await ApiClient.getData("${NewApiConstant.degreeListApi}?_limit=100");
      if(response.statusCode==200){
        setState(() {
          initList=[];
          initList= List<SearchDegreeModel>.from(response.body['data']['degree_list'].map((x) => SearchDegreeModel.fromJson(x)));
          searchList=initList;
        });

      }else{
        ApiChecker.checkApi(response);
    }
    setState(() {
      isLoading=false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: AppBar(
        title: const SizedBox(),
      ),
      body: SafeArea(
        child: Column(
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
                  if(value.isNotEmpty){
                    searchDegree(value);
                  }else{
                    setState(() {
                      searchList=initList;
                    });

                  }


                },
              ),
            ),
            isLoading?const Center(child:CircularProgressIndicator(),):
            Expanded(
              child: ListView.builder(
                itemCount:searchList.length,
                itemBuilder: (context, index) {
                  return
                    ListTile(
                      title: Text(searchList[index].title!),
                      onTap: () {
                        widget.onSelectionChanged(searchList[index]);
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
