
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smg/utils/styles.dart';

import '../../utils/color.dart';

class CustomButton extends StatelessWidget {
  final double? width;
  final double? height;
  final Function() onPressed;
  final String title;
  String? icon;
  final double? iconSize;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final Color? iconColor;

  CustomButton({super.key,
    this.width,
    this.height,
    this.iconColor,
    required this.title,
    required this.onPressed,
    this.icon,
    this.backgroundColor,
    this.textColor,
    this.borderColor ,
    this.iconSize ,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    EdgeInsetsGeometry edgeInsets = const EdgeInsets.all(0);
    if (width == null || height == null) {
      edgeInsets =  EdgeInsets.symmetric(vertical:5.h);
    }
    return Padding(
      padding: edgeInsets,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          width: width,
          height: height,
          padding: edgeInsets,
          decoration: BoxDecoration(
              color: backgroundColor??Get.theme.primaryColor,
              border: Border.all(color: borderColor??Get.theme.primaryColor),
              borderRadius: BorderRadius.circular(50.r),
              boxShadow: [
                BoxShadow(
                    color:backgroundColor!=null? backgroundColor!.withOpacity(0.3):Get.theme.primaryColor.withOpacity(0.3),
                    blurRadius: 4.0,
                    offset: const Offset(0.0, 5.0)),
              ]),
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildIcon(theme,iconColor),
                _buildTitle(),
              ],
            ),
          ),
        ),
      ),
    );
    /*MaterialButton(
      onPressed: onPressed,
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(
          AppSizes.buttonRadius
        )
      ),
      child: Container(
        alignment: Alignment.center,
        width: width,
        height: height,
        child: Text(title,
          style: _theme.textTheme.button?.copyWith(
            backgroundColor: _theme.textTheme.button.backgroundColor,
            color: _theme.textTheme.button.color
          )
        )
      )
    );*/
  }

  Widget _buildTitle() {
    return Text(
      title,
      style:AppStyles.h4(fontWeight: FontWeight.w500,color:textColor??AppColors.bgColor),
    );
  }

  Widget _buildIcon(ThemeData theme ,Color? iconColor) {
    if (icon != null) {
      return Padding(
        padding: const EdgeInsets.only(
          right: 8.0,
        ),
        child: Image.asset(
          icon!,
          height: iconSize,
          width: iconSize,
          fit: BoxFit.fill,
          color:iconColor??theme.iconTheme.color,
        ),
      );
    }

    return SizedBox();
  }
}