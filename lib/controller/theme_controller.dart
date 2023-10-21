import 'package:get/get.dart';
import 'package:smg/helper/prefs_helper.dart';
import 'package:smg/utils/app_constant.dart';



class ThemeController extends GetxController{

  var isDarkTheme=false.obs;



  @override
  void onInit() {
    getCurrentAppTheme();

    super.onInit();
  }

  getCurrentAppTheme()async{
    isDarkTheme.value=await PrefsHelper.getBool(AppConstant.theme);
  }


  setDarkTheme(bool value)async{
    isDarkTheme.value=value;
    await PrefsHelper.setBool(AppConstant.theme,value);

  }

}