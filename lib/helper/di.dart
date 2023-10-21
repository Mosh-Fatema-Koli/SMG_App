
import 'package:get/get.dart';
import 'package:smg/controller/blog_controller.dart';
import 'package:smg/controller/home_controller.dart';
import 'package:smg/controller/notice_details_controller.dart';
import 'package:smg/controller/notification_controller.dart';
import 'package:smg/controller/profile_controller.dart';
import 'package:smg/controller/save_blog_controller.dart';
import 'package:smg/controller/splash_controller.dart';
import 'package:smg/controller/notice_tag_controller.dart';

import '../controller/auth_controller.dart';
import '../controller/forgot_password_controller.dart';
import '../controller/theme_controller.dart';

Future init()async{

    Get.lazyPut(() => SplashController());
    Get.lazyPut(() => ForgotPasswordController());
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => ThemeController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => NoticesDetailsController());
    Get.lazyPut(() => SavedBlogController());
    Get.lazyPut(() => NotificationController());
    Get.lazyPut(() => NoticeTagController());
    Get.lazyPut(() => ProfileController());
    Get.lazyPut(() => BlogController());


}