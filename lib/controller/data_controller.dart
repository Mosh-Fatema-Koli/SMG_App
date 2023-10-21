import 'package:get/get.dart';
import 'package:smg/helper/prefs_helper.dart';
import 'package:smg/utils/app_constant.dart';

class DataController extends GetxController{
    var name="".obs;
    var image="".obs;
    var isPremium=true.obs;

    setData({required String named,required  String imaged}){
      name.value=named;
      image.value=imaged;
      PrefsHelper.setString(AppConstant.name, named);
      PrefsHelper.setString(AppConstant.image, imaged);
    }




}