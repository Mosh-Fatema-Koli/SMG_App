import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/color.dart';
import '../../utils/styles.dart';

class DeleteConfirmationDialog extends StatelessWidget {
  const DeleteConfirmationDialog({
    super.key, required this.title, required this.subTitle, required this.onTapYes,  this.onTapNo,
  });
  final  String title;
  final String subTitle;
  final Function()  onTapYes;
  final Function()? onTapNo;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:Text(title,style:AppStyles.h1(fontWeight: FontWeight.w600),),
      content: Text(subTitle,style: AppStyles.h5(color: AppColors.greyColor),),
      actions: [
        TextButton(
            onPressed:onTapNo ?? (){
              Get.back();
            },
            child: Text("No",style:AppStyles.h3(),)),
        TextButton(
            onPressed:onTapYes,
            child: Text("Yes",style:AppStyles.h3(),)),

      ],
    );
  }
}

