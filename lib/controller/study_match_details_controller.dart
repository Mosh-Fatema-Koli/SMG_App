
import 'dart:convert';

import 'package:get/get.dart';
import 'package:smg/model/study_match_model.dart';
import 'package:smg/services/api_check.dart';
import 'package:smg/services/api_client.dart';
import 'package:smg/services/api_constant.dart';
import 'package:smg/utils/app_constant.dart';

class StudyMatchDetailsController extends GetxController{

  Rx<MatchModel>  matchData=MatchModel().obs;


  var isLoading=false.obs;
  var isNetWorkError=false.obs;

  getMatch(int id)async{
    isLoading(true);
    isNetWorkError(false);
    Response response = await ApiClient.getData(ApiConstant.studyMatchSingleApi+id.toString());

    if(response.statusCode==200){
      matchData.value=MatchModel.fromJson(response.body['data']['match']);
      matchData.refresh();

    }else{
      isNetWorkError(true);
      ApiChecker.checkApi(response);
    }
    isLoading(false);

  }

  rated(int matchId,int ratingId )async{
    Map<String,dynamic> body= {
      'match_id': matchId,
      'rating_id': ratingId
    };
    Response response= await ApiClient.postData(ApiConstant.ratedStudyMatchApi, json.encode(body));
    if(response.statusCode==200){
      matchData.value.isRated=ratingId;
      matchData.refresh();
  }
  }

  unRated(int matchId)async{
    Map<String,dynamic> body= {
      'match_id': matchId,
    };
    Response response= await ApiClient.postData(ApiConstant.unRatedStudyMatchApi, json.encode(body));
    if(response.statusCode==200){
      matchData.value.isRated=null;
      matchData.refresh();
    }



  }




}