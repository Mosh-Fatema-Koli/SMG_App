import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smg/controller/profile_controller.dart';
import 'package:smg/model/blog_model.dart';

import '../services/api_check.dart';
import '../services/api_client.dart';
import '../services/api_constant.dart';

class SavedBlogController extends GetxController{

  late ScrollController scrollController;
  int page = 1;
  var isFirstLoadRunning = false.obs;
  var hasNextPage = true.obs;
  var isLoadMoreRunning = false.obs;
  var isNetworkError=false.obs;
  RxList<BlogModel> blogList = List<BlogModel>.empty(growable: true).obs;


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
    await ApiClient.getData(ApiConstant.blogSaveListApi+page.toString());
    if (response.statusCode == 200) {
      blogList.value = blogModelFromJson(response.body['data']['saved_blogs']['original']['data']['saved_blogs']['data']);
      hasNextPage = true.obs;
      blogList.refresh();
      isFirstLoadRunning(false);
      isLoadMoreRunning(false);
    } else {
      ApiChecker.checkApi(response);
    }


  }

  fastLoad()async {
    page=1;
    isNetworkError(false);
    isFirstLoadRunning(true);
    Response response =
    await ApiClient.getData(ApiConstant.blogSaveListApi+page.toString());
    if (response.statusCode == 200) {
      blogList.value = blogModelFromJson(response.body['data']['saved_blogs']['original']['data']['saved_blogs']['data']);
      isFirstLoadRunning(false);
    } else {
       isNetworkError(true);
      ApiChecker.checkApi(response);
    }
    
  }

  loadMore() async {
    print("load more");
    if (hasNextPage.value == true &&
        isFirstLoadRunning.value == false &&
        isLoadMoreRunning.value == false) {
      isLoadMoreRunning(true);
      page += 1;
      Response response =
      await ApiClient.getData(ApiConstant.blogSaveListApi+page.toString());
      if (response.statusCode == 200) {
        List<BlogModel> demoList = blogModelFromJson(response.body['data']['saved_blogs']['original']['data']['saved_blogs']['data']);

        if (demoList.isEmpty) {
          hasNextPage.value = false;
        } else {
          blogList.addAll(demoList);
          blogList.refresh();
        }
      } else {
        ApiChecker.checkApi(response);
      }
      isLoadMoreRunning(false);
    }
  }






}