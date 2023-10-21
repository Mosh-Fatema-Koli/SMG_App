import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smg/model/search_degree_model.dart';
import 'package:smg/routes/routes.dart';
import 'package:smg/services/api_check.dart';
import 'package:smg/services/api_client.dart';
import 'package:smg/services/api_constant.dart';
import 'package:smg/services/new_api_constant.dart';
import '../../../../helper/prefs_helper.dart';
import 'package:http/http.dart' as http;
import '../../../../model/country_model.dart';
import '../../../../utils/app_constant.dart';

class SetUpProfileController extends GetxController {
  TextEditingController fastNameCtrl = TextEditingController();
  TextEditingController dateOfBirthCtrl = TextEditingController();
  TextEditingController lastNameCtrl = TextEditingController();
  TextEditingController budgetCtrl = TextEditingController();
  TextEditingController passingYearCtrl = TextEditingController();
  TextEditingController startingYearCtrl = TextEditingController();
  TextEditingController cgpaCtrl = TextEditingController();
  TextEditingController searchDegreeCtrl = TextEditingController();
  TextEditingController genderCtrl = TextEditingController();
  TextEditingController lastAchievedDegreeCtrl = TextEditingController();

  var selectDegree="".obs;
  var loading = false.obs;
  var genderList =["Married", "Unmarried", "Widowed", "Divorced"];


  @override
  void onInit() {
    super.onInit();
  }





  RxList<SearchDegreeModel> degreeList = <SearchDegreeModel>[].obs;


  Future<List<SearchDegreeModel>> searchLocation(BuildContext context, String? text) async {

    if(text != null && text.isNotEmpty) {
        String uri="${ApiConstant.degreeApi}?input=$text";
      var response = await ApiClient.getData(uri);
      if(response.statusCode==200){
        degreeList.value=[];
        degreeList.value =degreeList.value = List<SearchDegreeModel>.from(response.body['data']['degrees'].map((x) => SearchDegreeModel.fromJson(x)));
      }else{
        ApiChecker.checkApi(response);
      }
  }

    return degreeList;
  }
 

  



  /// <--------------- select date of birth ------------->
late DateTime dob;

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      dob=picked;
      var day = picked.day;
      var month = picked.month;
      var year = picked.year;
      dateOfBirthCtrl.text = "$year/$month/$day";
      refresh();
    }
  }



  ///  fast screen
  handleSetProfile() async {
    loading(true);
    var userId= await PrefsHelper.getString(AppConstant.userId);

    Map<String,dynamic>  body={
      "user_id":userId,
      "dob":dateOfBirthCtrl.text,
      "gender":genderCtrl.text
    };
      // Map<String,String>  body={
      //       'firstname': fastNameCtrl.text,
      //       'lastname': lastNameCtrl.text,
      //       'dob': dateOfBirthCtrl.text,
      //        "gender": genderCtrl.text,
      //       // 'last_achieved_degree': jsonEncode(degree),
      //       // 'budget':budgetCtrl.text
      //     };
      Response response = await ApiClient.postData(NewApiConstant.personalInformationCreateApi, json.encode(body));
      if(response.statusCode==201){
         await  PrefsHelper.setString(AppConstant.profileSetup,'PersonalInformation');
           Get.offNamed(Routes.setupProfile2);
      }else{
        ApiChecker.checkApi(response);
      }

    loading(false);
  }


  /// screen 2

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







  handleSetupProfile2()async{
    loading(true);
    var userId= await PrefsHelper.getString(AppConstant.userId);
    Map<String,dynamic> body={
      "user_id":userId,
      "degree_id":selectDegree.value,
      "gpa":{
        "point":cgpaCtrl.text
      },
      "passing_year":passingYearCtrl.text,
      "starting_year":startingYearCtrl.text
    };

    Response response = await ApiClient.postData(NewApiConstant.addEducationApi, json.encode(body));
    if(response.statusCode==201){
      await  PrefsHelper.setString(AppConstant.profileSetup,'EducationInformation');
      Get.offNamed(Routes.setupProfile3);
    }else{
      ApiChecker.checkApi(response);
    }
    loading(false);

  }



  ///  screen 3

  var selectCountry = [].obs;
  var selectDesiredDegree = [].obs;
    RxList<String> tuitionFee=<String>[].obs;
  RxList<CountryModel> countryList = <CountryModel>[].obs;

  // get country
  getCountry() async {
    loading(true);
    Response response = await ApiClient.getData(ApiConstant.countryApi);
    if (response.statusCode == 200) {
      List<CountryModel> demoCountryList = countryModelFromJson(response.body);
      countryList.value = demoCountryList;
      countryList.refresh();
    } else {
      ApiChecker.checkApi(response);
    }
    loading(false);
  }



  handleSelectCountry(List<CountryModel> value) {
    selectCountry.clear();
    for (var element in value) {
      selectCountry.add(element.id.toString());
    }
    print("Select Country length ${selectCountry.length}");
  }

  handleSelectDesiredDegree(List<SearchDegreeModel> value) {
    selectDesiredDegree.clear();
    for (var element in value) {
      selectDesiredDegree.add(element.id.toString());
    }
    print("Select degree length ${selectDesiredDegree.length}");
  }

  handleSetupProfile3(String tuitionFee)async{
    loading(true);
    // Map<String,dynamic> body={
    //   "desired_country_ids": selectCountry,
    //   "desired_degree_ids": selectDesiredDegree,
    //   "budget":double.parse(tuitionFee)
    // };
    var userId= await PrefsHelper.getString(AppConstant.userId);
    var cost= await int.parse(tuitionFee);
 Map<String,dynamic> body={
   "user_id":userId,
   "total_tuition_fee_upto_in_usd":cost,
  //"per_month_living_cost_upto_in_usd":2000,
   "countries":selectCountry.value,
   "degrees":selectDesiredDegree.value
 };
    Response response = await ApiClient.postData(NewApiConstant.userDesireCreate,json.encode(body));
    if(response.statusCode==201){
      await  PrefsHelper.setString(AppConstant.profileSetup,'UserDesire');
      Get.toNamed(Routes.blogScreen);
    }else{
      ApiChecker.checkApi(response);
    }
    loading(false);
  }

}
