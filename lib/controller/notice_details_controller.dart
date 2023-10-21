import 'package:get/get.dart';
import 'package:smg/model/notices_model.dart';
import 'package:smg/services/api_check.dart';
import 'package:smg/services/api_client.dart';
import 'package:smg/services/api_constant.dart';
import 'package:url_launcher/url_launcher.dart';

class NoticesDetailsController extends GetxController {
   NoticeModel? dataModel;
  var isLoading = false.obs;

  getNoticeDetails(int id, int? alertId) async {
    isLoading(true);
    String uri = '';
    if (alertId == null) {
      uri = ApiConstant.noticeDetailsApi + id.toString();
    } else {
      uri = "${ApiConstant.noticeDetailsApi}$id?alert_id=$alertId";
    }
    Response response = await ApiClient.getData(uri);
    if (response.statusCode == 200) {
      dataModel = NoticeModel.fromJson(response.body['data']['notice']);
    } else {
      ApiChecker.checkApi(response);
    }
    isLoading(false);
  }

  void launchURL(String url) async {
      if (!await launchUrl(Uri.parse(url))) {
        throw Exception('Could not launch $url');
      }
    
  }

}
