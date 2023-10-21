import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smg/utils/styles.dart';

class HeaderText extends StatelessWidget {
  const HeaderText({super.key,required this.text,this.isRequired=false});
  final String text;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical:8.h),
      child: Row(
        children: [
          Text(text, style: AppStyles.h3()),
          if(isRequired)
          Text(" *", style: AppStyles.h3(color:Colors.red)),
        ],
      ),
    );
}
}