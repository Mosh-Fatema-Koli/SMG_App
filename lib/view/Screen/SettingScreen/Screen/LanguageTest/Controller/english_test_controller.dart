import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:smg/model/language_model.dart';
import 'package:smg/model/profile_model.dart';
import 'package:smg/services/api_check.dart';
import 'package:smg/services/api_client.dart';
import 'package:smg/services/api_constant.dart';


class AddEnglishTestController extends GetxController {
  @override
  void onInit() {
    getAllLanguage();
    super.onInit();
  }

  TextEditingController overallScoreCtrl = TextEditingController();
  TextEditingController selectLanguageCtrl = TextEditingController();
  TextEditingController selectLevelCtrl = TextEditingController();

  var languageList = <LanguageModel>[].obs;
  var levelList = <LanguageModel>[].obs;
  var allLanguageTest = <Language>[].obs;



  var selectLanguageId = (-1).obs;

  LanguageModel? selectLevel1;
  var loading = false.obs;
  var isLoading=false.obs;
  var isNetworkError=false.obs;

  getAllLanguage({bool getLoading = true}) async {
    isNetworkError(false);
    if (getLoading) {
      isLoading(true);
    }
    Response response = await ApiClient.getData(ApiConstant.getProfileApi);
    if (response.statusCode == 200) {
      allLanguageTest.value = List<Language>.from(response.body['data']['user']
              ['student_profile']['languages']
          .map((x) => Language.fromJson(x)));
      allLanguageTest.refresh();
      update();
    } else {
      isNetworkError(true);
      ApiChecker.checkApi(response);
    }
    if (getLoading) {
      isLoading(false);
    }
  }



  /// language add screen use this funtion
  getLanguage() async {
    loading(true);
    Response response = await ApiClient.getData(ApiConstant.getLanguageApi);
    if (response.statusCode == 200) {
      languageList.value = List<LanguageModel>.from(response.body['data']
              ['languages']
          .map((x) => LanguageModel.fromJson(x)));
      languageList.refresh();
    } else {
      ApiChecker.checkApi(response);
    }
    loading(false);
  }

  deleteLanguage(int id,index) async {
    Response response = await ApiClient.postData(
        ApiConstant.deleteLanguage, jsonEncode({"language_id": id}));
    if (response.statusCode == 200) {
      allLanguageTest.removeAt(index);
      allLanguageTest.refresh();
      Get.back();
    //  getAllLanguage( getLoading:false);
    } else {
      ApiChecker.checkApi(response);
    }
  }

  handleLanguageAdd() async {
    loading(true);
    Map<String, dynamic> body = {
      "language": {
        "id": selectLanguageId.value,
        "level": selectLevelCtrl.text,
        "score": overallScoreCtrl.text.isEmpty ? null : overallScoreCtrl.text
      }
    };
    Response response =
        await ApiClient.postData(ApiConstant.addLanguageApi, jsonEncode(body));

    if (response.statusCode == 200) {
       await  getAllLanguage();
      Get.back();
      selectLevelCtrl.clear();
      selectLanguageCtrl.clear();
      selectLanguageId.value = (-1);
      overallScoreCtrl.clear();
      levelList.value = [];
    } else {
      ApiChecker.checkApi(response);
    }
    loading(false);
  }
}
