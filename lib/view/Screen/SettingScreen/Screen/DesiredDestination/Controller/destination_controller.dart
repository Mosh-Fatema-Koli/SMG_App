import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:smg/model/country_model.dart';
import 'package:smg/model/profile_model.dart';

import '../../../../../../model/search_degree_model.dart';
import '../../../../../../services/api_check.dart';
import '../../../../../../services/api_client.dart';
import '../../../../../../services/api_constant.dart';

class DestinationController extends GetxController {
  var isLoading = false.obs;
  var loading = false.obs;

  var isSeeMoreCountry=false.obs;
  var isSeeMoreDegree=false.obs;
  var isNetworkError=false.obs;

  @override
  void onInit() {
    getDesiredCountry();
    super.onInit();
  }

  TextEditingController accommodationCtrl = TextEditingController();
  TextEditingController educationCtrl = TextEditingController();
  TextEditingController searchDegreeCtrl = TextEditingController();
  var selectCountry = [].obs;
  RxList<CountryModel> countryList = <CountryModel>[].obs;
  RxList<DesiredCountry> desiredCountry = <DesiredCountry>[].obs;
  RxList<DesiredDegreeModel> desiredDegree = <DesiredDegreeModel>[].obs;

  getDesiredCountry({bool getLoading = true}) async {
    isNetworkError(false);
    if (getLoading) {
      loading(true);
    }
    Response response = await ApiClient.getData(ApiConstant.getProfileApi);
    if (response.statusCode == 200) {
      desiredCountry.value = List<DesiredCountry>.from(response.body['data']
              ['user']['student_profile']['desired_countries']
          .map((x) => DesiredCountry.fromJson(x)));
      desiredCountry.refresh();
      update();
      await getDesiredDegree(getLoading:false);
    } else {
      isNetworkError(true);
      ApiChecker.checkApi(response);
    }
    if (getLoading) {
      loading(false);
    }
  }



  getDesiredDegree({bool getLoading = true}) async {
    if (getLoading) {
      loading(true);
    }
    Response response = await ApiClient.getData(ApiConstant.getProfileApi);
    if (response.statusCode == 200) {
      desiredDegree.value = List<DesiredDegreeModel>.from(response.body['data']
      ['user']['student_profile']['desired_degrees']
          .map((x) => DesiredDegreeModel.fromJson(x)));
      desiredDegree.refresh();
      update();
    } else {
       isNetworkError(true);
      ApiChecker.checkApi(response);
    }
    if (getLoading) {
      loading(false);
    }
  }


  getCountry() async {
    isLoading(true);
    Response response = await ApiClient.getData(ApiConstant.countryApi);
    if (response.statusCode == 200) {
      List<CountryModel> demoCountryList = countryModelFromJson(response.body);
      countryList.value = demoCountryList;
      countryList.refresh();
    } else {
      ApiChecker.checkApi(response);
    }
    isLoading(false);
  }


  handleAddDesiredCountry(List<CountryModel> selectedCountry)async {
    isLoading(true);
    selectCountry.clear();
    for (var element in selectedCountry) {
      selectCountry.add(element.id);
    }
    Map<String, dynamic> body = {"countries_id": selectCountry};

    Response response = await ApiClient.postData(
        ApiConstant.addDesiredCountriesApi, jsonEncode(body));
    if (response.statusCode == 200) {
      getDesiredCountry(getLoading: false);
      Get.back();
    } else {
      ApiChecker.checkApi(response);
    }
    isLoading(false);
  }

  deleteCountry(int id, index) async {
    Map<String, dynamic> body = {
      "countries_id": [id]
    };
    Response response =
        await ApiClient.postData(ApiConstant.deleteCountry, jsonEncode(body));
    if (response.statusCode == 200) {
      desiredCountry.removeAt(index);
        await getDesiredCountry(getLoading: false);
      Get.back();
    } else {
      ApiChecker.checkApi(response);
    }
  }

  /// desired degree add
  RxList<SearchDegreeModel> degreeList = <SearchDegreeModel>[].obs;
  Future<List<SearchDegreeModel>> searchDegree(
      BuildContext context, String? text) async {
    if (text != null && text.isNotEmpty) {
      String uri = "${ApiConstant.degreeApi}?input=$text";
      var response = await ApiClient.getData(uri);
      if (response.statusCode == 200) {
        degreeList.value = [];
        degreeList.value = degreeList.value = List<SearchDegreeModel>.from(
            response.body['data']['degrees']
                .map((x) => SearchDegreeModel.fromJson(x)));
      } else {
        ApiChecker.checkApi(response);
      }
    }

    return degreeList;
  }

  var selectDesiredDegree = [].obs;
  handleSelectDesiredDegree(List<SearchDegreeModel> value) {
    selectDesiredDegree.clear();
    for (var element in value) {
      selectDesiredDegree.add(element.id);
    }
    print("Select degree length ${selectDesiredDegree}");
  }

  updateDesiredDegree() async {
    loading(true);
    Map<String, dynamic> body = {"degrees_id": selectDesiredDegree.value};

    Response response = await ApiClient.postData(
        ApiConstant.addDesiredDegreeApi, jsonEncode(body));
    if (response.statusCode == 200) {
      await getDesiredDegree(getLoading:false);
      Get.back();
    } else {
      ApiChecker.checkApi(response);
    }
    loading(false);
  }



  deleteDegree(int id, index) async {
    Map<String, dynamic> body = {
      "degrees_id": [id]
    };
    Response response =
    await ApiClient.postData(ApiConstant.deleteDesiredDegreeApi, jsonEncode(body));
    if (response.statusCode == 200) {
      desiredDegree.removeAt(index);
      Get.back();
      //await getDesiredCountry(getLoading: false);
    } else {
      ApiChecker.checkApi(response);
    }
  }

}
