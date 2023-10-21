import 'package:get/get_navigation/get_navigation.dart';
import 'package:smg/model/profile_model.dart';
import 'package:smg/view/Screen/Auth/ForgotPassword/forgot_password.dart';
import 'package:smg/view/Screen/Auth/sign_in_screen.dart';
import 'package:smg/view/Screen/Auth/sign_up_screen.dart';
import 'package:smg/view/Screen/Blog/blog_screeen.dart';
import 'package:smg/view/Screen/HomeScreen/home_screen.dart';
import 'package:smg/view/Screen/InboxScreeen/inbox_screen.dart';
import 'package:smg/view/Screen/NotificationScreen/notification_screen.dart';
import 'package:smg/view/Screen/ProfileScreen/screen/setup_profile_2.dart';
import 'package:smg/view/Screen/ProfileScreen/screen/setup_profile_3.dart';
import 'package:smg/view/Screen/SettingScreen/Screen/DesiredDestination/destination.dart';
import 'package:smg/view/Screen/SettingScreen/Screen/LanguageTest/language.dart';
import 'package:smg/view/Screen/SettingScreen/Screen/PersonalInformation/profile_information.dart';
import 'package:smg/view/Screen/SettingScreen/Screen/SaveBlogScreen/save_blog_screen.dart';
import 'package:smg/view/Screen/SettingScreen/setting_screen.dart';
import 'package:smg/view/Screen/StudyMatch/study_match.dart';
import 'package:smg/view/Widgets/no_internet_screen.dart';
import '../view/Screen/NoticesDetails/notice_details.dart';
import '../view/Screen/SettingScreen/Screen/Education/education.dart';
import '../view/Screen/ProfileScreen/screen/setup_profile.dart';
import '../view/Screen/SplashScreen/splash_screen.dart';

class Routes {
  static String splashScreen = "/splash_screen";
//  static String homeScreen = "/home_screen";
  static String inboxScreen = "/inbox_screen";
  static String signInScreen = "/sign_in_screen";
  static String signUpScreen = "/sign_up_screen";
  static String forgotPasswordScreen = "/forgot_password_screen";
  static String settingScreen="/setting_screen";
  static String setupProfile1="/setup_profile1";
  static String setupProfile2="/setup_profile2";
  static String setupProfile3="/setup_profile3";
  static String notificationScreen="/notification_screen";
  static String savedBlogScreen="/saved_blog_screen";
  static String personalInformation="/personal_information";
  static String destination="/destination_screen";
  static String language="/language_screen";
  static String educationScreen="/education_screen";
  static String blogScreen="/blog_screen";
  static String studyMatchScreen="/study_match_screen";



}

List<GetPage> pages = [
  GetPage(name: Routes.splashScreen, page: () => SplashScreen()),
 // GetPage(name: Routes.homeScreen, page: () => HomeScreen(),transition: Transition.noTransition),
  GetPage(name: Routes.inboxScreen, page: () => const InboxScreen(),transition: Transition.noTransition),
  GetPage(name: Routes.signInScreen, page: () => SignInScreen(),transition:Transition.fade),
  GetPage(name: Routes.signUpScreen, page: () => const SignUpScreen(),transition:Transition.rightToLeft),
  GetPage(name: Routes.forgotPasswordScreen, page: () => const ForgotPassword(),transition:Transition.rightToLeft),
  GetPage(name: Routes.settingScreen, page: () => SettingScreen(),transition: Transition.noTransition),
  GetPage(name: Routes.setupProfile1, page: () =>  SetupProfile1(),transition:Transition.rightToLeft),
  GetPage(name: Routes.setupProfile2, page: () =>  SetupProfile2(),transition:Transition.rightToLeft),
  GetPage(name: Routes.setupProfile3, page: () =>  const SetupProfile3(),transition:Transition.rightToLeft),
  GetPage(name: Routes.notificationScreen, page: () =>  NotificationScreen(),transition: Transition.noTransition),
  GetPage(name: Routes.savedBlogScreen, page: () =>  SavedBlogScreen(),transition:Transition.rightToLeft),
  GetPage(name: Routes.personalInformation, page: () =>   PersonalInformation(),transition:Transition.rightToLeft),
  GetPage(name: Routes.destination, page: () =>   Destination(),transition:Transition.rightToLeft),
  GetPage(name: Routes.language, page: () =>   LanguageScreen(),transition:Transition.rightToLeft),
  GetPage(name: Routes.educationScreen, page: () =>   Education(),transition:Transition.rightToLeft),
  GetPage(name: Routes.blogScreen, page: () =>    BlogScreen(),transition:Transition.noTransition),
  GetPage(name: Routes.studyMatchScreen, page: () =>    StudyMatch(),transition:Transition.noTransition),



  

];
