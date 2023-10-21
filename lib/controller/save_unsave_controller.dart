import 'dart:convert';

import 'package:get/get.dart';
import 'package:smg/controller/save_blog_controller.dart';

import '../services/api_client.dart';
import '../services/api_constant.dart';
import 'blog_controller.dart';
import 'blog_tag_controller.dart';

class SaveUnSaveController extends GetxController{
  final _blogController = Get.put(BlogController());
  final _blogTagController = Get.put(BlogTagController());
  final _savedBlogController = Get.put(SavedBlogController());




  handleSave(int id) async {
    Response response = await ApiClient.postData(
        ApiConstant.blogSaveApi, json.encode({"blog_id": id}));
    if (response.statusCode == 200) {


      for (int i = 0; i <_blogController.blogList.length; i++) {
        if(_blogController.blogList[i].id==id){
          _blogController.blogList[i].isSaved=true;
          _blogController.blogList.refresh();
        }

      }

      for (int i = 0; i <_blogTagController.blogList.length; i++) {
        if(_blogTagController.blogList[i].id==id){
          _blogTagController.blogList[i].isSaved=true;
          _blogTagController.blogList.refresh();
        }

      }


    }
  }

  handleUnSave(int id,) async {
    Response response = await ApiClient.postData(
        ApiConstant.blogUnSaveApi, json.encode({"blog_id": id}));
    if (response.statusCode == 200) {
      for (int i = 0; i <_blogController.blogList.length; i++) {
        if(_blogController.blogList[i].id==id){
          _blogController.blogList[i].isSaved=false;
          _blogController.blogList.refresh();
        }

      }

      for (int i = 0; i <_blogTagController.blogList.length; i++) {
        if(_blogTagController.blogList[i].id==id){
          _blogTagController.blogList[i].isSaved=false;
          _blogTagController.blogList.refresh();
        }
      }


      for (int i = 0; i <_savedBlogController.blogList.length; i++) {
        if(_savedBlogController.blogList[i].id==id){
          _savedBlogController.blogList.removeAt(i);
          _savedBlogController.blogList.refresh();
        }
      }

    }
  }






}