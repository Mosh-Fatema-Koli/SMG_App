import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:smg/controller/data_controller.dart';
import 'package:smg/controller/profile_controller.dart';
import 'package:smg/helper/prefs_helper.dart';
import 'package:smg/model/address_model.dart';
import 'package:smg/model/profile_model.dart';
import 'package:smg/services/api_check.dart';
import 'package:smg/services/api_client.dart';
import 'package:smg/services/api_constant.dart';
import 'package:smg/services/new_api_constant.dart';
import 'package:smg/utils/app_constant.dart';
import 'package:smg/utils/color.dart';

class PersonalInformationController extends GetxController {

  var loading=false.obs;
  Rx<UserPersonalInformation>userData = UserPersonalInformation as Rx<UserPersonalInformation>;
  final _dataController=Get.put(DataController());

  var isSelectGender = "".obs;
  var isSelectSex = "".obs;
  // var selectCountry = [].obs;
  var isPoliceVerification = false.obs;


  var genderList =  ["Male", "Female", "Others" ];
  void handleGenderChange(String? value) {
    isSelectGender.value = value!;
  }

  var sexList = [
    "Male",
    "Female",
  ];



  TextEditingController fastNameCtrl = TextEditingController();
  TextEditingController middleCtrl = TextEditingController();
  TextEditingController lastNameCtrl = TextEditingController();
  TextEditingController fatherNameCtrl = TextEditingController();
  TextEditingController motherNameCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController nidCtrl = TextEditingController();
  TextEditingController passportCtrl = TextEditingController();
  TextEditingController policeCtrl = TextEditingController();

  TextEditingController dateOfBirthCtrl = TextEditingController();
  TextEditingController nationalityCtrl = TextEditingController();
  TextEditingController tuitionCostCtrl = TextEditingController();
  TextEditingController genderCtrl = TextEditingController();
  final _profileCtrl = Get.put(ProfileController());

  TextEditingController currentCtrl = TextEditingController();
  TextEditingController currentDivisionCtrl = TextEditingController();
  TextEditingController currentDistrictCtrl = TextEditingController();
  TextEditingController currentZipCodeCtrl = TextEditingController();
  TextEditingController permanentCtrl = TextEditingController();
  TextEditingController  permanentDivisionCtrl = TextEditingController();
  TextEditingController  permanentDistrictCtrl = TextEditingController();
  TextEditingController  permanentZipCodeCtrl = TextEditingController();

  @override
  void onInit() {
    _profileCtrl.getProfile();
    super.onInit();
  }




  getPersonalInformation()async{

    var id = await PrefsHelper.getString(AppConstant.userId);
    loading(true);
    Response response = await ApiClient.getData(NewApiConstant.personalInfo+id);
    if(response.statusCode==200){
      userData.value = UserPersonalInformation.fromJson(response.body['data']['user']);
      await  _dataController.setData(named:userData.value.firstName.isEmpty?"":"${userData.value.firstName} ${userData.value.firstName} ${userData.value.lastName}", imaged:userData.value.id);
      userData.refresh();
      update();
    }else{
      ApiChecker.checkApi(response);
    }
    loading(false);
  }







  void handleSexChange(String? value) {
    isSelectSex.value = value!;
  }



  pickImage({bool isGallery=false})async{
    final source= isGallery==false?ImageSource.camera:ImageSource.gallery;
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source:source);
   if(image != null){
     _cropImage(image);
   }

  }
  Future<void> _cropImage(XFile file) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: file.path,
     aspectRatio: const CropAspectRatio(ratioX:0.1, ratioY:0.1),


      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: AppColors.mainColor,
            toolbarWidgetColor: Colors.white,
            //initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: true,
            showCropGrid: true,
              hideBottomControls: false
        ),
      ],
    );
    if(croppedFile !=null){
      upLoadProfileImage(croppedFile);
    }

  }
    var isUploadImageLoading=false.obs;
    upLoadProfileImage(CroppedFile croppedFile)async{
      isUploadImageLoading(true);
      Response response = await ApiClient.postMultipartData(ApiConstant.updateProfileApi,{},multipartBody:[MultipartBody("image", File(croppedFile.path))]);
        if(response.statusCode==200) {
          await _profileCtrl.getProfilePic();
           isUploadImageLoading(false);
        }else{
          ApiChecker.checkApi(response);
          isUploadImageLoading(false);
        }
         
    } 





// Initial date

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      String? year= picked.year.toString();
      String? day= picked.day.toString();
      String? month= picked.month.toString();
      dateOfBirthCtrl.text="$year/$month/$day";
      refresh();
    }
  }



  setPersonalInfo()async{
       var data=  _profileCtrl.userData.value.studentProfile;
     fastNameCtrl.text=data!.firstname??"";
     middleCtrl.text=data.middlename;
     lastNameCtrl.text=data.lastname??"";
     fatherNameCtrl.text=data.fatherName;
     motherNameCtrl.text=data.motherName;
  }


  updatePersonalInfo()async{
      loading(true);
    Map<String,dynamic> body={
      'firstname': fastNameCtrl.text,
      'lastname': lastNameCtrl.text,
      'middlename': middleCtrl.text,
      'father_name': fatherNameCtrl.text,
      'mother_name': motherNameCtrl.text
    };
     
    Response response = await ApiClient.postData(ApiConstant.updateProfileApi, jsonEncode(body));
    if(response.statusCode==200){
  await    _profileCtrl.getProfile();
    //  Get.snackbar("Successful", "Personal info updated",backgroundColor:AppColors.mainColor,colorText:Colors.white);
      fatherNameCtrl.clear();
      fastNameCtrl.clear();
      lastNameCtrl.clear();
      middleCtrl.clear();
      motherNameCtrl.clear();
     // updateData();
      Get.back();
    }else{
      ApiChecker.checkApi(response);
      // Get.snackbar("Unsuccessful", "Personal info updated",backgroundColor:Colors.red,colorText:Colors.white);
    }
      loading(false);

  }


  setBasicInfo(){
       var data=  _profileCtrl.userData.value.studentProfile;
      nidCtrl.text=data!.nid??"";
       passportCtrl.text=data.passportNumber??"";
      nationalityCtrl.text=data.nationality??"";
      dateOfBirthCtrl.text="${data.dob!.year}/${data.dob!.month}/${data.dob!.day}";
      genderCtrl.text=_profileCtrl.userData.value.gender??"";

  }


  updateBasicInfo()async{
      loading(true);
    Map<String,dynamic> body={
      'dob': dateOfBirthCtrl.text,
      'nid': nidCtrl.text,
      'passport_number': passportCtrl.text,
      'nationality': nationalityCtrl.text,
      'gender':genderCtrl.text,
    };

    Response response = await ApiClient.postData(ApiConstant.updateProfileApi, jsonEncode(body));
    if(response.statusCode==200){
    await  _profileCtrl.getProfile();
      dateOfBirthCtrl.clear();
      nidCtrl.clear();
      passportCtrl.clear();
      nationalityCtrl.clear();
      isSelectGender.value="";
    //  Get.snackbar("Successful", "Basic info updated",backgroundColor:AppColors.mainColor,colorText:Colors.white);
       // updateData();
      Get.back();
    }else{
      ApiChecker.checkApi(response);
    }
      loading(false);
  }






setContactInfo(){
  phoneCtrl.text=_profileCtrl.userData.value.phone;
}

  updateContactInfo()async{
      loading(true);
    Map<String,dynamic> body={
      'phone': phoneCtrl.text,
    };

    Response response = await ApiClient.postData(ApiConstant.updateProfileApi, jsonEncode(body));
    if(response.statusCode==200){
      await _profileCtrl.getProfile();
       Get.back();
   //   Get.snackbar("Successful", "Contact info updated",backgroundColor:AppColors.mainColor,colorText:Colors.white);
      phoneCtrl.clear();
     
     // updateData();
    }else{
      ApiChecker.checkApi(response);
    }
      loading(false);
  }

  setTuitionFee(){
  tuitionCostCtrl.text="Below < ${_profileCtrl.userData.value.studentProfile!.budget}";
}


  updateTuitionPerYear(String tuitionFee)async{
      loading(true);
    Map<String,dynamic> body={
      'budget': tuitionFee,
    };
    Response response = await ApiClient.postData(ApiConstant.updateProfileApi, jsonEncode(body));
    if(response.statusCode==200){
     await _profileCtrl.getProfile();
      tuitionCostCtrl.clear();
     // Get.snackbar("Successful", "Tuition updated",backgroundColor:AppColors.mainColor,colorText:Colors.white);
      Get.back();
    }else{
      ApiChecker.checkApi(response);
    }
      loading(false);

  }


 RxList<Division> allDivision=<Division>[].obs;
 RxList<Division> allDistrict=<Division>[].obs;
 var isGetAddressLoading=false.obs;
 var selectCurrentDivisionId=(-1).obs;
 var selectCurrentDistrictId=(-1).obs;
 var selectPermanentDivisionId=(-1).obs;
 var selectPermanentDistrictId=(-1).obs;

getAllAddress()async{
      isGetAddressLoading(true);
      Response response= await ApiClient.getData(ApiConstant.divisionGetApi);
      if(response.statusCode==200){
      AddressModel model= addressModelFromJson(response.body);
      allDivision.value=model.data.divisions;
      allDivision.refresh();
      }else{
        ApiChecker.checkApi(response);
      }
      isGetAddressLoading(false);


}

  currentAddressUpdate()async{
    isGetAddressLoading(true);
    Map<String,dynamic> body=
      {
        'address': currentCtrl.text,
        'division_id': selectCurrentDivisionId.value,
        'district_id': selectCurrentDistrictId.value,
        'zip_code': currentZipCodeCtrl.text,
        'type': 'current_address'
    };
    Response response = await ApiClient.postData(ApiConstant.addressUpdateApi, jsonEncode(body));
    if(response.statusCode==200){
      await _profileCtrl.getProfile();
      Get.back();
      currentCtrl.clear();
      currentZipCodeCtrl.clear();
      currentDistrictCtrl.clear();
      currentDivisionCtrl.clear();
      selectCurrentDivisionId.value=(-1);
      selectCurrentDistrictId.value=(-1);
    }else{
      ApiChecker.checkApi(response);
    }
    isGetAddressLoading(false);
  }


  permanentAddressUpdate()async{
    isGetAddressLoading(true);
    Map<String,dynamic> body=
      {
        'address': permanentCtrl.text,
        'division_id': selectPermanentDivisionId.value,
        'district_id': selectPermanentDistrictId.value,
        'zip_code': permanentZipCodeCtrl.text,
        'type': 'permanent_address'
    };
    Response response = await ApiClient.postData(ApiConstant.addressUpdateApi, jsonEncode(body));
    if(response.statusCode==200){
      await _profileCtrl.getProfile();
      Get.back();
      permanentZipCodeCtrl.clear();
      permanentCtrl.clear();
      permanentDistrictCtrl.clear();
      permanentDivisionCtrl.clear();
      selectPermanentDivisionId.value=(-1);
      selectPermanentDistrictId.value=(-1);
    }else{
      ApiChecker.checkApi(response);
    }
    isGetAddressLoading(false);
  }


}
