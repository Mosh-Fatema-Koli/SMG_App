import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:smg/helper/di.dart' as di;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smg/routes/routes.dart';
import 'package:smg/themes/themes.dart';
import 'package:smg/view/Widgets/empty_screen.dart';
import 'package:smg/view/Widgets/file_careate_and_save.dart';

import 'controller/theme_controller.dart';
import 'firebase_options.dart';
import 'helper/notification_helper.dart';
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin=FlutterLocalNotificationsPlugin();


void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await di.init();
  var _body;
  try {
    if (GetPlatform.isMobile) {
      final RemoteMessage? remoteMessage = await FirebaseMessaging.instance.getInitialMessage();
      if (remoteMessage != null) {
        _body =remoteMessage.data;
      }
      await NotificationHelper.init(flutterLocalNotificationsPlugin);
      FirebaseMessaging.onBackgroundMessage(NotificationHelper.firebaseMessagingBackgroundHandler);
    }
  }catch(e) {}
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      //systemNavigationBarColor: AppColors.blackColor, // navigation bar color
      statusBarColor: Colors.transparent,
      // status bar color
      statusBarIconBrightness: Brightness.dark));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
  final _themeController=Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return Obx(()=>
           GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'SMG',
            // You can use the library anywhere in the app even in theme
            theme: Themes.themeData(context,_themeController.isDarkTheme.value),
            initialRoute: Routes.splashScreen,
            getPages: pages,
          //   home: FileSaveAndStorage(),
          ),
        );
      },
    );
  }
}

