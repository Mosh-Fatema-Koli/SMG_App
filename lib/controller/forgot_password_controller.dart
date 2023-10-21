import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController{

  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  /// timer
  var timeShow = ''.obs;
  var secounds=0.obs;

  Timer? timer;

  void startTimer() {
    // secounds(180);
    secounds.value = 180;

    //timer!.cancel();

    timer = Timer.periodic(const Duration(seconds: 1), (ter) {
      if (secounds.value > 0) {
        secounds.value--;
      } else {
        timer?.cancel();
      }
      int minutes = secounds.value ~/ 60;
      int startSecond = (secounds.value % 60);

      timeShow.value =
      "${minutes.toString().padLeft(2, "0")}.${startSecond.toString().padLeft(2, "0")}";
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    pinController.dispose();
    focusNode.dispose();
    if (timer != null) {
      timer!.cancel();
    }
    super.dispose();
  }
}