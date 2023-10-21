import 'dart:convert';

import 'package:get/get.dart';
import 'package:smg/controller/blog_controller.dart';
import 'package:smg/controller/blog_tag_controller.dart';
import 'package:smg/controller/save_blog_controller.dart';
import 'package:smg/model/blog_model.dart';
import 'package:smg/services/api_check.dart';
import 'package:smg/services/api_client.dart';
import 'package:smg/services/api_constant.dart';
import 'package:smg/utils/app_constant.dart';

class BlogDetailsController extends GetxController {
  Rx<BlogModel> blogModel = BlogModel().obs;
  final _blogController = Get.put(BlogController());
  final _blogTagController = Get.put(BlogTagController());
  final _savedBlogController = Get.put(SavedBlogController());
  var isLoading = false.obs;
  var isNetworkError=false.obs;

  getBlog(int id) async {
    isNetworkError(false);
    isLoading(true);
    Response response =
        await ApiClient.getData(ApiConstant.blogDetailsApi + id.toString());
    if (response.statusCode == 200) {
      blogModel.value = BlogModel.fromJson(response.body['data']['blog']);
    } else {
      isNetworkError(true);
      ApiChecker.checkApi(response);
    }
    isLoading(false);
  }


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
      for (int i = 0; i <_savedBlogController.blogList.length; i++) {

        if(!_savedBlogController.blogList.contains(blogModel.value)){
          _savedBlogController.fastLoad();
        }

      }


      blogModel.value.isSaved=true;
      blogModel.refresh();
      update();

    }
  }

  handleUnSave(int id,) async {
    Response response = await ApiClient.postData(
        ApiConstant.blogUnSaveApi, json.encode({"blog_id": id}));
    if (response.statusCode == 200) {
      blogModel.value.isSaved=false;
      blogModel.refresh();
      update();
    }
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
