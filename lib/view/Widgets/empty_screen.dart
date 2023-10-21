import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smg/utils/styles.dart';


class EmptyScreeen extends StatelessWidget {
  const EmptyScreeen({super.key, required this.image, required this.des});
  final String image;
  final String des;
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment:CrossAxisAlignment.center,
          children: [
            Image.asset(image,height:150.h,width: 150.h,fit: BoxFit.fill,),
            SizedBox(height:30.h,),
            Text(des,style: AppStyles.h2(color: Colors.grey),textAlign: TextAlign.center,)
      
          ],
        ),
      ),
    );
  }
}
