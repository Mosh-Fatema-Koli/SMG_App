import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smg/controller/profile_controller.dart';
import 'package:smg/model/blog_model.dart';
import '../services/api_check.dart';
import '../services/api_client.dart';
import '../services/api_constant.dart';

class BlogController extends GetxController{

  late ScrollController scrollController;
  int page = 1;
  var isFirstLoadRunning = false.obs;
  var hasNextPage = true.obs;
  var isLoadMoreRunning = false.obs;
  RxList<BlogModel> blogList = List<BlogModel>.empty(growable: true).obs;
  final _profileController =Get.put(ProfileController());

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
    await ApiClient.getData(ApiConstant.blogApi+page.toString());
    if (response.statusCode == 200) {
      blogList.value = blogModelFromJson(response.body['data']['blogs']['data']);
      hasNextPage = true.obs;
      blogList.refresh();
      isFirstLoadRunning(false);
      isLoadMoreRunning(false);
    } else {
      ApiChecker.checkApi(response);
    }


  }



  fastLoad()async {
    isFirstLoadRunning(true);
    Response response =
    await ApiClient.getData(ApiConstant.blogApi+page.toString());
    if (response.statusCode == 200) {
      blogList.value = blogModelFromJson(response.body['data']['blogs']['data']);
      await _profileController.getProfilePic();
      isFirstLoadRunning(false);
    } else {
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
      await ApiClient.getData(ApiConstant.blogApi+page.toString());
      if (response.statusCode == 200) {
        List<BlogModel> demoList = blogModelFromJson(response.body['data']['blogs']['data']);

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



  @override
  void onClose() {
    scrollController.removeListener(loadMore);
    super.onClose();
  }




}