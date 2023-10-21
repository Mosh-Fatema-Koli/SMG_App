import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smg/model/profile_model.dart';
import 'package:smg/services/api_check.dart';
import '../../../../../../model/search_degree_model.dart';
import '../../../../../../services/api_client.dart';
import '../../../../../../services/api_constant.dart';

class EducationController extends GetxController{


  var isLoading =false.obs;
  
  TextEditingController gpaCtrl=TextEditingController();
  TextEditingController scoreCtrl=TextEditingController();
  TextEditingController passingYearCtrl=TextEditingController();
  TextEditingController minGpaCtrl=TextEditingController();
  TextEditingController maxGpaCtrl=TextEditingController();
  TextEditingController creditHoursCtrl=TextEditingController();
  TextEditingController startingYearCtrl=TextEditingController();
  TextEditingController degreeCtrl=TextEditingController();
  var selectDegreeId="".obs;
  var loading=false.obs;
  var isNetworkError =false.obs;

 Rx<File?> selectedFile = Rx<File?>(null);
  Rx<String> selectedFileName = Rx<String>('');



///  <------------- Degree get Section ------------>
  RxList<Degree> allEducation=<Degree>[].obs;

  getEducation({bool getLoading=true})async{
      isNetworkError(false);
    if(getLoading){
    loading(true);
    }
    Response response = await ApiClient.getData(ApiConstant.getProfileApi);
    if(response.statusCode==200){
      allEducation.value=List<Degree>.from(response.body['data']['user']['student_profile']['degrees'].map((x) => Degree.fromJson(x)));
      allEducation.refresh();
      update();
    }else{
       isNetworkError(true);
      ApiChecker.checkApi(response);
    }
   if(getLoading){
    loading(false);
    }
  }

///  <------------- delete education ------------>

 deleteEducation(int id,index) async {
    Map<String, dynamic> body = {'degree_id': id.toString()};
    Response response =
    await ApiClient.postData(ApiConstant.deleteEducation, jsonEncode(body));
    if (response.statusCode == 200) {
      allEducation.removeAt(index);
     await getEducation(getLoading:false);
     Get.back();
    } else {
      ApiChecker.checkApi(response);
    }
  }

///  <--------------- Passing years generate  ----------->
  List<String> generateYears() {
    var endYear=DateTime.now().year;
    DateTime thirtyYearsAgo = DateTime.now().subtract(const Duration(days: 30 * 365));
    List<String> years = [];
    List<String> reverceList = [];
    for (int year = thirtyYearsAgo.year; year <=endYear ; year++) {
      years.add(year.toString());
    }
    for (int i = years.length - 1; i >= 0; i--) {
      reverceList.add(years[i]);
    }
    return reverceList;
  }



///  <------------- Degree search Section ------------>
  RxList<SearchDegreeModel> degreeList = <SearchDegreeModel>[].obs;
  Future<List<SearchDegreeModel>> searchLocation(BuildContext context, String? text) async {

    if(text != null && text.isNotEmpty) {
      String uri="${ApiConstant.degreeApi}?input=$text";
      var response = await ApiClient.getData(uri);
      if(response.statusCode==200){
        degreeList.value=[];
        
      degreeList.value = List<SearchDegreeModel>.from(response.body['data']['degrees'].map((x) => SearchDegreeModel.fromJson(x)));

      }else{
        ApiChecker.checkApi(response);
      }
    }

    return degreeList;
  }
   

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
       type: FileType.custom,
         allowedExtensions: ['jpg', 'pdf', 'png'],
    );
    if (result != null) {
      selectedFile.value = File(result.files.single.path!);
        selectedFileName.value = result.files.single.name;
    }
  }

    handleAddEduction()async{
    isLoading(true);
    Map<String, dynamic> degreeData = {
      "id": selectDegreeId.value,
      "gpa": double.parse(gpaCtrl.text),
      "score_percentage": double.parse(scoreCtrl.text),
      "passing_year":  passingYearCtrl.text.isEmpty?null:int.parse(passingYearCtrl.text),
      "min_gpa": minGpaCtrl.text.isEmpty?null:double.parse(minGpaCtrl.text),
      "max_gpa": maxGpaCtrl.text.isEmpty?null:double.parse(maxGpaCtrl.text),
      "credit_hours": creditHoursCtrl.text.isEmpty?null:double.parse(creditHoursCtrl.text),
      "starting_year": startingYearCtrl.text.isEmpty?null:int.parse(startingYearCtrl.text),
    };
    String degreeJson = jsonEncode(degreeData);

    Map<String ,String> body={
      'degree': degreeJson
    };

    Response response = await ApiClient.postMultipartData(ApiConstant.addEducationApi,body);
    if(response.statusCode==200){
    // Get.snackbar("Successful","Added Education",backgroundColor:Colors.green,colorText:Colors.white);
       await getEducation();
     selectDegreeId.value="";
     gpaCtrl.clear();
     scoreCtrl.clear();
     scoreCtrl.clear();
     passingYearCtrl.clear();
     minGpaCtrl.clear();
     maxGpaCtrl.clear();
     creditHoursCtrl.clear();
     startingYearCtrl.clear();
     degreeCtrl.clear();
     Get.back();
    }else{
      ApiChecker.checkApi(response);
    }
    isLoading(false);
    }



    


}