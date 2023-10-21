import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:smg/model/notices_model.dart';
import 'package:smg/services/api_constant.dart';

import '../services/api_check.dart';
import '../services/api_client.dart';

class NoticeTagController extends GetxController{
  late ScrollController scrollController;

  int page = 1;
  var tagIds=0.obs;
  var isFirstLoadRunning = false.obs;
  var hasNextPage = true.obs;
  var isLoadMoreRunning = false.obs;
  // var noticeList = <NoticeData>[].obs;
  RxList<NoticeModel> noticeList = List<NoticeModel>.empty(growable: true).obs;

  @override
  void onInit() {
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        loadMore();
      }
    });
    super.onInit();
  }

    getTagIds(int id)async{
       tagIds.value=id;
       fastLoad();
    }

  refreshData()async{
    page=1;
    Response response =
    await ApiClient.getData("${ApiConstant.noticeTagApi}[${tagIds.value}]&page=$page");

    if (response.statusCode == 200) {

      noticeList.value = noticeModelFromJson(response.body['data']['notices']['data']);
      hasNextPage = true.obs;
      noticeList.refresh();
    } else {
      ApiChecker.checkApi(response);
    }


  }

  fastLoad()async {
    isFirstLoadRunning(true);
    Response response =
    await ApiClient.getData("${ApiConstant.noticeTagApi}[${tagIds.value}]&page=$page");
    if (response.statusCode == 200) {
      List<NoticeModel>  demoList=noticeModelFromJson(response.body['data']['saved_notices']['data']);
      noticeList.value = demoList;
    } else {
      ApiChecker.checkApi(response);
    }
    isFirstLoadRunning(false);
  }

  loadMore() async {
    print("load more");
    if (hasNextPage.value == true &&
        isFirstLoadRunning.value == false &&
        isLoadMoreRunning.value == false) {
      isLoadMoreRunning(true);
      page += 1;
      Response response =
       await ApiClient.getData("${ApiConstant.noticeTagApi}[${tagIds.value}]&page=$page");
      if (response.statusCode == 200) {
        List<NoticeModel>  demoList=noticeModelFromJson(response.body['data']['saved_notices']['data']);
        if (demoList.isEmpty) {
          hasNextPage.value = false;
        } else {
          noticeList.addAll(demoList);
          noticeList.refresh();
        }
      } else {
        ApiChecker.checkApi(response);
      }
      isLoadMoreRunning(false);
    }
  }



  handleSave(int id,int index)async{
    Response response = await ApiClient.postData(ApiConstant.saveNotice,jsonEncode({
      'notice_id':id
    }));
    if(response.statusCode==200){
      noticeList[index].isSaved=true;
      noticeList.refresh();
    }
  }

  handleUnSave(int id,int index)async{
    Response response = await ApiClient.postData(ApiConstant.unSaveNotice, jsonEncode({
      'notice_id':id
    }));
    if(response.statusCode==200){
      noticeList[index].isSaved=false;
      noticeList.refresh();
    }

  }



  @override
  void onClose() {
    scrollController.removeListener(loadMore);
    super.onClose();
  }


}