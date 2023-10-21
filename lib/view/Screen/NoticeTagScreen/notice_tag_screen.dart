import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smg/controller/notice_tag_controller.dart';
import 'package:smg/view/Widgets/custom_loader.dart';

import '../../Widgets/notice_card.dart';

class NoticeTagScreen extends StatelessWidget {
  NoticeTagScreen({super.key, required this.tagIds, required this.name});
  final _controller =Get.put(NoticeTagController());
    final int tagIds;
    final String name;
  @override
  Widget build(BuildContext context) {
    _controller.getTagIds(tagIds);
    return Scaffold(
      appBar: AppBar(
        title:  Text(name),
      ),
      body: Obx(()=> _controller.isFirstLoadRunning.value?const CustomLoader():
          RefreshIndicator(
            onRefresh: ()async {
           await   _controller.refreshData();
            },
            child: ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(),
                controller:_controller.scrollController,
                padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 25.h),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  if (index < _controller.noticeList.length) {
                    return NoticeCard(
                      onSaved: (){
                        if(_controller.noticeList[index].isSaved==false){
                          _controller.handleSave(_controller.noticeList[index].id!, index);
                        }else{
                          _controller.handleUnSave(_controller.noticeList[index].id!, index);
                        }
                      },
                      dataModel:_controller.noticeList[index],

                    );
                  } else {
                    if (_controller.isLoadMoreRunning.value) {
                      return const Center(child: CircularProgressIndicator());
                    }else{
                      return const SizedBox();
                    }
                  }
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 20.h,
                  );
                },
                itemCount: _controller.noticeList.length+1),
          ),
      ),



    );
  }
}

