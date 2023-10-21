import 'package:get/get.dart';
import 'package:smg/services/new_api_constant.dart';

import '../model/country_model.dart';
import '../services/api_check.dart';
import '../services/api_client.dart';
import '../services/api_constant.dart';

class MultiSelectCountryController extends GetxController{

  RxList<CountryModel> selectedList =<CountryModel>[].obs;
  RxList<CountryModel> demoList =<CountryModel>[].obs;
  RxList<CountryModel> countryList =<CountryModel>[].obs;
  var isLoading=false.obs;


  // @override
  // void onInit() {
  //   getCountry();
  //   super.onInit();
  // }

  getCountry() async {
    isLoading(true);
    Response response = await ApiClient.getData(NewApiConstant.countryListApi);
    if (response.statusCode == 200) {
      List<CountryModel> demoCountryList = countryModelFromJson(response.body['data']['country_list']);
      countryList.value = demoCountryList;
      demoList.value = countryList;
      countryList.refresh();
    } else {
      ApiChecker.checkApi(response);
    }
    isLoading(false);
  }
}