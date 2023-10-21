import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:smg/controller/profile_controller.dart';
import 'package:smg/helper/logger.dart';
import 'package:smg/model/notices_model.dart';
import 'package:smg/services/api_check.dart';
import 'package:smg/services/api_client.dart';
import 'package:smg/services/api_constant.dart';

final log = Logger();

class HomeController extends GetxController {
  late ScrollController scrollController;
  final _profileController = Get.find<ProfileController>();

  int page = 1;

  var isFirstLoadRunning = false.obs;
  var hasNextPage = true.obs;
  var isLoadMoreRunning = false.obs;
  // var noticeList = <NoticeData>[].obs;
  RxList<NoticeModel> noticeList = List<NoticeModel>.empty(growable: true).obs;


  List sliderImage=[
    "https://img.freepik.com/free-vector/dark-blue-banner-with-arrow-style-yellow-shapes_1017-32328.jpg?w=2000",
    "https://img.freepik.com/free-vector/abstract-yellow-blue-geometric-banner-half-tone-design_1017-39620.jpg?w=2000",
    "https://media.istockphoto.com/id/1430537202/vector/modern-abstract-blue-yellow-orange-banner-background-design-abstract-geometric-background.jpg?s=170667a&w=0&k=20&c=UBGh1gKIcffbjPC85FqanmvA-h99kXo8f7wHP0aqoWc="

  ];
  var dotPosition=0.obs;





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
    await ApiClient.getData(ApiConstant.noticeApi +page.toString());

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
        await ApiClient.getData(ApiConstant.noticeApi + page.toString());
    if (response.statusCode == 200) {

      noticeList.value = noticeModelFromJson(response.body['data']['notices']['data']);

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
          await ApiClient.getData(ApiConstant.noticeApi + page.toString());
      if (response.statusCode == 200) {
        List<NoticeModel> demoList = noticeModelFromJson(response.body['data']['notices']['data']);

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
