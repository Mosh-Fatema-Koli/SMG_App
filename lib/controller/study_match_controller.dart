import 'package:get/get.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:smg/controller/profile_controller.dart';
import 'package:smg/model/notices_model.dart';
import 'package:smg/model/study_match_model.dart';
import 'package:smg/services/api_check.dart';
import 'package:smg/services/api_client.dart';
import 'package:smg/services/api_constant.dart';

final log = Logger();

class StudyMatchController extends GetxController{
  late ScrollController scrollController;

  int page = 1;
  var isFirstLoadRunning = false.obs;
  var hasNextPage = true.obs;
  var isLoadMoreRunning = false.obs;
  var isNetWorkError=false.obs;
  var isShowDialog=true.obs;
  RxMap<DateTime, List<MatchModel>> groupedMatch =
      <DateTime, List<MatchModel>>{}.obs;


  @override
  void onInit() {
    fastLoad();
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        loadMore();
      }
    });

    super.onInit();
  }

  refreshData()async{
    page=1;
    Response response =
    await ApiClient.getData(ApiConstant.studyMatchApi+page.toString());
    if (response.statusCode == 200) {
      List<MatchModel>  modelList= matchModelFromJson(response.body['data']['matches']['data']);
      groupedMatch.clear();
      groupNotificationByDate(modelList);
    groupedMatch.refresh();
      hasNextPage = true.obs;

    } else {
      ApiChecker.checkApi(response);
    }

  }



  fastLoad()async {
    page=1;
    isFirstLoadRunning(true);
    isNetWorkError(false);
    Response response =
    await ApiClient.getData(ApiConstant.studyMatchApi+page.toString());
    if (response.statusCode == 200) {
      List<MatchModel>  modelList= matchModelFromJson(response.body['data']['matches']['data']);
      groupNotificationByDate(modelList);
      groupedMatch.refresh();
    } else {
      ApiChecker.checkApi(response);
      isNetWorkError(true);
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
      await ApiClient.getData(ApiConstant.studyMatchApi+page.toString());
      if (response.statusCode == 200) {
        List<MatchModel>  modelList= matchModelFromJson(response.body['data']['matches']['data']);


        if (modelList.isEmpty) {
          hasNextPage.value = false;
        } else {
          groupNotificationByDate(modelList);
          groupedMatch.refresh();
        }
      } else {
        ApiChecker.checkApi(response);
      }
      isLoadMoreRunning(false);
    }
  }



  groupNotificationByDate(List<MatchModel> matchList){
    matchList.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
    for (var match in matchList) {
      final date = DateTime(match.createdAt!.year, match.createdAt!.month, match.createdAt!.day);
      groupedMatch.putIfAbsent(date, () => []);
      groupedMatch[date]?.add(match);
    }


  }


  @override
  void onClose() {
    scrollController.removeListener(loadMore);
    super.onClose();
  }






}