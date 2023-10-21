import 'dart:convert';
import 'dart:io';

import 'package:advertising_id/advertising_id.dart';
import 'package:app_set_id/app_set_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_app_installations/firebase_app_installations.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:smg/routes/routes.dart';
import 'package:smg/utils/app_constant.dart';
import 'package:uuid/uuid.dart';
import '../helper/prefs_helper.dart';
import '../services/api_client.dart';
import '../services/new_api_constant.dart';

class SplashController extends GetxController {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  var fcmToken ="".obs;
  var uuid = const Uuid();
  var fid="".obs;
  var appId="".obs;
  var loading=true.obs;
  var advertisingId="".obs;


  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  final RxMap<String, dynamic> _deviceData = <String, dynamic>{}.obs;


  @override
  void onInit() {
    super.onInit();
    init();
  }




  init()async{
    var deviceToken= await PrefsHelper.getString(AppConstant.deviceToken);
    if(deviceToken.isEmpty){
      await   getFcmToken();
      await initPlatformState();
      await initGetAppSetId();
      await initAdvertisingId();
      await  getFId();
      await resolveDevice();
    }
  }
  jumpToNextPage() async {
    await Future.delayed(const Duration(seconds: 3), () async {
      bool isLogged = await PrefsHelper.getBool(AppConstant.appLogged);
      var setupProfile= await PrefsHelper.getString(AppConstant.profileSetup);
      if(isLogged){
        if(setupProfile==""){
          Get.offNamed(Routes.setupProfile1);
        }else if(setupProfile=="PersonalInformation"){
          Get.offNamed(Routes.setupProfile2);
        } else if(setupProfile=="EducationInformation"){
          Get.offNamed(Routes.setupProfile3);
        }else{
          Get.offAllNamed(Routes.blogScreen);
        }
      }else{
        Get.offAllNamed(Routes.signInScreen);
      }

    });
  }

  Future<void> getFcmToken() async {
    String? token = await _firebaseMessaging.getToken();
    fcmToken.value = token!;
    debugPrint("=====> Get Token successful : $fcmToken");
  }


  Future<void> initPlatformState() async {
    var deviceData = <String, dynamic>{};
    try {
      deviceData = switch (defaultTargetPlatform) {
        TargetPlatform.android =>
            _readAndroidBuildData(await deviceInfoPlugin.androidInfo),
        TargetPlatform.iOS =>
        <String, dynamic>{
          'Error:': 'Fuchsia platform isn\'t supported'
        },
        TargetPlatform.linux =>
        <String, dynamic>{
          'Error:': 'Fuchsia platform isn\'t supported'
        },
        TargetPlatform.windows =>
        <String, dynamic>{
          'Error:': 'Fuchsia platform isn\'t supported'
        },
        TargetPlatform.macOS =>
        <String, dynamic>{
          'Error:': 'Fuchsia platform isn\'t supported'
        },
        TargetPlatform.fuchsia => <String, dynamic>{
          'Error:': 'Fuchsia platform isn\'t supported'
        },
      };

    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }
    _deviceData.value = deviceData;
    _deviceData.refresh();
    print("====> Device Data : ${_deviceData.value}");

  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'systemFeatures': build.systemFeatures,
      'displaySizeInches':
      ((build.displayMetrics.sizeInches * 10).roundToDouble() / 10),
      'displayWidthPixels': build.displayMetrics.widthPx,
      'displayWidthInches': build.displayMetrics.widthInches,
      'displayHeightPixels': build.displayMetrics.heightPx,
      'displayHeightInches': build.displayMetrics.heightInches,
      'displayXDpi': build.displayMetrics.xDpi,
      'displayYDpi': build.displayMetrics.yDpi,
      'serialNumber': build.serialNumber,
    };
  }

  /// <---------------------  get fid  ------------->
  Future<void> getFId() async {
    try {
      final _newid = await FirebaseInstallations.instance.getId();

        fid.value = _newid;
      debugPrint("Firebase Installations id : ${fid.value}");
    } catch (e) {
      log('$e');
    }
  }


  /// <---------------------  get app set id ------------->


  Future<void> initGetAppSetId() async {
    String identifier;
    try {
      identifier = await AppSetId().getIdentifier() ?? "Unknown";
    } on PlatformException {
      identifier = 'Failed to get identifier.';
    }
    appId.value=identifier;
    appId.refresh();
    debugPrint("=======> AppSet Id   : ${appId.value}");

  }

  /// <------------------------ AdvertisingId id------------------>\
    initAdvertisingId() async {
      String? _advertisingId;
      bool? isLimitAdTrackingEnabled;
      // Platform messages may fail, so we use a try/catch PlatformException.
      try {
        _advertisingId = await AdvertisingId.id(true);
      } on PlatformException {
        _advertisingId = 'Failed to get platform version.';
      }
        advertisingId.value = _advertisingId!;
      debugPrint("=======> AdvertisingId   : ${advertisingId.value}");
    }

    String getPlatform(){
      if(Platform.isIOS){
        return "Ios";
      }else if(Platform.isAndroid){
        return "Android";
      }else if(Platform.isMacOS){
        return "MacOS";
      }else{
        return "Other";
      }

    }


  resolveDevice()async{
    // loading(true);
    var localId = uuid.v4();

    var headers = {
      'Content-Type': 'application/json'
    };

    Map<String ,dynamic>body={
      "kind":getPlatform(),
      "source": "TipTipBarsaBijoli",
      "fid": fid.value,
      "local_id": localId,
      "fcm_token": fcmToken.value,
      "app_set_id":appId.value,
      "advertisement_id":advertisingId.value,
      "properties": {
        "model": _deviceData.value["model"],
        "brand": _deviceData.value["brand"]
      }
    };
    Response response = await ApiClient.postData(NewApiConstant.deviceResolve,json.encode(body),headers: headers);
    if(response.statusCode==200){
      await PrefsHelper.setString(AppConstant.deviceToken, response.body['data']['device_token']);
      await PrefsHelper.setString(AppConstant.deviceKind, response.body['data']["device_kind"]);
      await PrefsHelper.setString(AppConstant.channels,json.encode(response.body['data']['channels']));
    }else{
      print(response.body);
    }


  }


}
