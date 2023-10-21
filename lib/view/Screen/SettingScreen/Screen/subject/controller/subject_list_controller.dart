import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:smg/services/api_check.dart';
import 'package:smg/services/api_client.dart';
import 'package:smg/services/api_constant.dart';
import 'package:smg/services/new_api_constant.dart';
import 'package:smg/view/Screen/SettingScreen/Screen/subject/model/major_subject_list.dart';
import 'package:smg/view/Screen/SettingScreen/Screen/subject/model/subject_list_model.dart';

class SubjectList extends GetxController {

  var loading = false.obs;

  var isSeeMoreSubject = false.obs;
  var isSeeMoreMajorSubject = false.obs;
  var isNetworkError = false.obs;



  TextEditingController subjectController = TextEditingController();
  TextEditingController majorSubjectController = TextEditingController();

  var selectSubject = [].obs;
  var selectMajorSubject = [].obs;

  RxList<SubjectListModel> subjectList = <SubjectListModel>[].obs;
  RxList<MajorSubjectListModel> majorSubjectList = <MajorSubjectListModel>[].obs;


  @override
  void onInit() {

    getSubjectList();
    getMajorSubjectList();

    super.onInit();
  }


  getSubjectList({bool getLoading = true}) async {
    isNetworkError(false);
    if (getLoading) {
      loading(true);
    }

    var response = await ApiClient.getData("${NewApiConstant.degreeListApi}?_limit=100");
    if (response.statusCode == 200) {
      subjectList.value = List<SubjectListModel>.from(response.body['data']['subject_list'].map((x) => SubjectListModel.fromJson(x)));
      subjectList.refresh();
      update();
      await getSubjectList(getLoading:false);
    } else {
      isNetworkError(true);
      ApiChecker.checkApi(response);
    }
    if (getLoading) {
      loading(false);
    }
  }


  Future searchSubjectList(String? text) async {

    if(text != null && text.isNotEmpty) {
      var response = await ApiClient.getData("${NewApiConstant.degreeListApi}?title_like=$text&_limit=50");
      if(response.statusCode==200){
        subjectList.value = List<SubjectListModel>.from(response.body['data']['subject_list'].map((x) => SubjectListModel.fromJson(x)));
        subjectList.refresh();
        update();

      }else{
        ApiChecker.checkApi(response);
      }
    }else{

    }
  }


  getMajorSubjectList({bool getLoading = true}) async {
    isNetworkError(false);
    if (getLoading) {
      loading(true);
    }
    var response = await ApiClient.getData("${NewApiConstant.degreeListApi}?_limit=100");

    if (response.statusCode == 200) {

      majorSubjectList.value = List<MajorSubjectListModel>.from(response.body['data'][''].map((x) => MajorSubjectListModel.fromJson(x)));
      majorSubjectList.refresh();
      update();
      await getMajorSubjectList(getLoading:false);
    } else {
      isNetworkError(true);
      ApiChecker.checkApi(response);
    }
    if (getLoading) {
      loading(false);
    }
  }






}
