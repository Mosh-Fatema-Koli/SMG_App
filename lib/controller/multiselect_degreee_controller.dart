import 'package:get/get.dart';
import 'package:smg/model/profile_model.dart';
import 'package:smg/model/search_degree_model.dart';

import '../services/api_check.dart';
import '../services/api_client.dart';
import '../services/api_constant.dart';
import '../services/new_api_constant.dart';

class MultiSelectDegreeController extends GetxController{
  RxList<SearchDegreeModel> selectedList =<SearchDegreeModel>[].obs;
  RxList<SearchDegreeModel> lastList =<SearchDegreeModel>[].obs;
  RxList<SearchDegreeModel> fastList =<SearchDegreeModel>[].obs;

  var isLoading=false.obs;



  Future searchDegree(String? text) async {
    if(text != null && text.isNotEmpty) {
      var response = await ApiClient.getData("${NewApiConstant.degreeListApi}?title_like=$text&_limit=50");
      if(response.statusCode==200){
        lastList.value=[];
        lastList.value = List<SearchDegreeModel>.from(response.body['data']['degree_list'].map((x) => SearchDegreeModel.fromJson(x)));
      print("Last List = ${lastList.length}");
      }else{
        ApiChecker.checkApi(response);
      }
    }
  }

  Future searchFastDegree() async {
    isLoading(true);
    var response = await ApiClient.getData("${NewApiConstant.degreeListApi}?_limit=100");
      if(response.statusCode==200){
        fastList.value=[];
        fastList.value = List<SearchDegreeModel>.from(response.body['data']['degree_list'].map((x) => SearchDegreeModel.fromJson(x)));
        print("fast List = ${fastList.length}");
      }else{
        ApiChecker.checkApi(response);
      }
    isLoading(false);
  }


}