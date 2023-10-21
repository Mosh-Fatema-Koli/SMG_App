import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smg/model/notification_model.dart';
import '../services/api_check.dart';
import '../services/api_client.dart';
import '../services/api_constant.dart';

class NotificationController extends GetxController{
  late ScrollController scrollController;
  int page = 1;
  var isFirstLoadRunning = false.obs;
  var hasNextPage = true.obs;
  var isLoadMoreRunning = false.obs;
  var isNetworkError=false.obs;

  // Group notification by date

  // RxMap<DateTime, List<NotificationModel>> groupedNotifications =
  //     <DateTime, List<NotificationModel>>{}.obs;
 RxList<NotificationModel> notificationList = List<NotificationModel>.empty(growable: true).obs;


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

  refreshData()async{
    page=1;
    Response response =
    await ApiClient.getData(ApiConstant.allNotificationApi +page.toString());
    if (response.statusCode == 200) {
    List<NotificationModel>  demoList=List<NotificationModel>.from(response.body['data']['alerts']['data'].map((x) => NotificationModel.fromJson(x)));
    // groupedNotifications.clear();
    // groupNotificationByDate(demoList);
    // groupedNotifications.refresh();

    notificationList.value=demoList;
    notificationList.refresh();
    update();
    hasNextPage = true.obs;
    } else {
      ApiChecker.checkApi(response);
    }
  }



  fastLoad()async {
    isNetworkError(false);
    page=1;
    isFirstLoadRunning(true);
     hasNextPage.value = true;
    Response response =
    await ApiClient.getData(ApiConstant.allNotificationApi + page.toString());
    if (response.statusCode == 200) {
      List<NotificationModel> demoList=List<NotificationModel>.from(response.body['data']['alerts']['data'].map((x) => NotificationModel.fromJson(x)));
      // groupedNotifications.clear();
      // groupNotificationByDate(demoList);
      // groupedNotifications.refresh();

      notificationList.value=demoList;
      notificationList.refresh();
      update();
      isFirstLoadRunning(false);
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
      Response response =
      await ApiClient.getData(ApiConstant.allNotificationApi + page.toString());
      if (response.statusCode == 200) {
        List<NotificationModel> demoList=<NotificationModel>[];
         demoList=List<NotificationModel>.from(response.body['data']['alerts']['data'].map((x) => NotificationModel.fromJson(x)));
        if (demoList.isEmpty) {
          hasNextPage.value = false;
        } else {
          notificationList.addAll(demoList);
          notificationList.refresh();
          // groupNotificationByDate(demoList);
          // groupedNotifications.refresh();

          update();
        }
      } else {
        ApiChecker.checkApi(response);
        //page-=1;
      }
      isLoadMoreRunning(false);
    }
  }

seenNotification(int id)async{
    Response response = await ApiClient.getData(ApiConstant.seenNotificationApi+id.toString());
    if(response.statusCode==200){
      for (var element in notificationList) {
        if(element.id==id){
         element.seenAt=DateTime.now();
        }
      }
      notificationList.refresh();
    }else{
      debugPrint("Seen Notification Error ");
    }
    
    
}

  groupNotificationByDate(List<NotificationModel> notification){
    notification.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
    for (var notice in notification) {
      final date = DateTime(notice.createdAt!.year, notice.createdAt!.month, notice.createdAt!.day);
      // groupedNotifications.putIfAbsent(date, () => []);
      // groupedNotifications[date]?.add(notice);
    }


  }

  
  



}