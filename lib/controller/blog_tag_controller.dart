import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../model/blog_model.dart';
import '../services/api_check.dart';
import '../services/api_client.dart';
import '../services/api_constant.dart';

class BlogTagController extends GetxController {
  late ScrollController scrollController;
  int page = 1;

  var isFirstLoadRunning = false.obs;
  var hasNextPage = true.obs;
  var isLoadMoreRunning = false.obs;
  var isNetworkError=false.obs;
  var tagIds = (-1).obs;
  RxList<BlogModel> blogList = List<BlogModel>.empty(growable: true).obs;

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

  getTagIds(int id) async {
    tagIds.value = id;
    fastLoad();
  }

  refreshData() async {
    page = 1;
    Response response = await ApiClient.getData(
        "${ApiConstant.blogTagApi}[${tagIds.value}]&page=$page");
    if (response.statusCode == 200) {
      blogList.value =
          blogModelFromJson(response.body['data']['blogs']['data']);
      hasNextPage = true.obs;
      blogList.refresh();
    } else {
      ApiChecker.checkApi(response);
    }
  }

  fastLoad() async {
    isFirstLoadRunning(true);
    isNetworkError(false);
    page=1;
    Response response = await ApiClient.getData(
        "${ApiConstant.blogTagApi}[${tagIds.value}]&page=$page");
    if (response.statusCode == 200) {
      blogList.value =
          blogModelFromJson(response.body['data']['blogs']['data']);
    } else {
      isNetworkError(true);
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
      Response response = await ApiClient.getData(
          "${ApiConstant.blogTagApi}[${tagIds.value}]&page=$page");
      if (response.statusCode == 200) {
        List<BlogModel> demoList =
            blogModelFromJson(response.body['data']['blogs']['data']);
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
