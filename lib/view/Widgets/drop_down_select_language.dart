

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:smg/model/language_model.dart';

import '../../services/api_check.dart';
import '../../services/api_client.dart';
import '../../services/api_constant.dart';
import 'custom_loader.dart';

class DropDownLanguage extends StatefulWidget {
  final Function(LanguageModel languageModel) onSelectionChanged;
  final List<LanguageModel> itemList;

  const DropDownLanguage({super.key,required  this.onSelectionChanged,required this.itemList});

  @override
  State<DropDownLanguage> createState() => _DropDownLanguageState();
}

class _DropDownLanguageState extends State<DropDownLanguage> {

  TextEditingController searchController = TextEditingController();


  List<LanguageModel>  searchList=[];

  @override
  void initState() {
    setState(() {
      searchList=widget.itemList;
    });
    super.initState();
  }

  Future search(String? text) async {
    searchList=widget.itemList
        .where((item) =>
        item.name.toLowerCase().contains(text!.toLowerCase()))
        .toList();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:
      SafeArea(
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
                  if(value.isEmpty){
                    setState(() {
                      searchList=widget.itemList;
                    });
                  }else{
                    setState(() {
                      search(value);
                    });
                  }
                },
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount:searchList.length,
                itemBuilder: (context, index) {
                  return
                    ListTile(
                      title: Text(searchList[index].name),
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

