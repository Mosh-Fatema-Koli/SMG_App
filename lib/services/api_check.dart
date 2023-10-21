
import 'package:get/get.dart';
import 'package:smg/routes/routes.dart';

import '../controller/auth_controller.dart';
import '../view/Widgets/custom_snackbar.dart';

class ApiChecker {
  static void checkApi(Response response, {bool getXSnackBar = false}) {

    if(response.statusCode != 200){
      if(response.statusCode == 401) {
        Get.put(AuthController()).clearSharedData();
        Get.offAllNamed(Routes.splashScreen);
      }else {
        showCustomSnackBar(response.statusText!, getXSnackBar: getXSnackBar);
      }

    }


  }
}