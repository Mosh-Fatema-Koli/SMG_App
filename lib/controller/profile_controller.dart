import 'dart:convert';

import 'package:get/get.dart';
import 'package:smg/controller/data_controller.dart';
import 'package:smg/services/api_check.dart';
import 'package:smg/services/api_client.dart';
import 'package:smg/services/api_constant.dart';

import '../model/profile_model.dart';

class ProfileController extends GetxController {
  var loading=false.obs;
  Rx<User>userData = User(name: '', email: '', image: '', phone: '').obs;
  final _dataController=Get.put(DataController());
   

  @override
  void onInit() {
    getProfile();
    super.onInit();
  }

  getProfile()async{
    loading(true);
    Response response = await ApiClient.getData(ApiConstant.getProfileApi);
    if(response.statusCode==200){
      userData.value = User.fromJson(response.body['data']['user']);
    await  _dataController.setData(named:userData.value.studentProfile==null?"":"${userData.value.studentProfile!.firstname} ${userData.value.studentProfile!.middlename} ${userData.value.studentProfile!.lastname}", imaged:userData.value.image);
      userData.refresh();
      update();
    }else{
      ApiChecker.checkApi(response);
    }
    loading(false);
  }

  getProfilePic()async{
    Response response = await ApiClient.getData(ApiConstant.getProfileApi);
    if(response.statusCode==200){
      userData.value = User.fromJson(response.body['data']['user']);
      userData.refresh();
    }else{
      ApiChecker.checkApi(response);
    }
  }

 



}
