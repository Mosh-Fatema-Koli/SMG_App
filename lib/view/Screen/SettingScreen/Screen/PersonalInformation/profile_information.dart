import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smg/controller/profile_controller.dart';
import 'package:smg/view/Screen/SettingScreen/Screen/PersonalInformation/Component/basic_info_update.dart';
import 'package:smg/view/Screen/SettingScreen/Screen/PersonalInformation/Component/contact_info_update.dart';
import 'package:smg/view/Screen/SettingScreen/Screen/PersonalInformation/Component/personal_info_update.dart';
import 'package:smg/view/Widgets/custom_loader.dart';
import 'package:smg/view/Widgets/no_internet_screen.dart';
import '../../../../../utils/app_icons.dart';
import '../../../../../utils/color.dart';
import '../../../../../utils/styles.dart';
import 'Component/current_address_add.dart';
import 'Component/permanent_address_add.dart';
import 'Controller/personal_information_controller.dart';
import 'Component/tuitiion_per_year.dart';

class PersonalInformation extends StatelessWidget {
  PersonalInformation({super.key});
  final _controller = Get.put(ProfileController());
  final _personalController = Get.put(PersonalInformationController());

  @override
  Widget build(BuildContext context) {
 //  _controller.getProfile();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Personal Information"),
      ),
      body: Obx(
        () => _controller.loading.value
            ? const CustomLoader()
            : _controller.userData.value.studentProfile == null
                ? NoInternetScreen(onTap:(){
                  _controller.getProfile();
                })
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),

                        ///<------------------- Image ------------------->

                        Align(
                          alignment: Alignment.center,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              _controller.userData.value.studentProfile != null
                                  ? CachedNetworkImage(
                                      imageUrl:
                                          _controller.userData.value.image,
                                      imageBuilder: (context, imageProvider) =>
                                      
                                          Container(
                                            height: 140.h,
                                            width: 140.h,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Get.isDarkMode
                                                    ? AppColors.darkFillColor
                                                    : AppColors.shadowColor,
                                                border: Border.all(
                                                    color: AppColors.bgColor,
                                                    width: 4),
                                                boxShadow: [
                                                  AppStyles.boxShadow
                                                ],
                                                image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.cover)
                                                    
                                                    ),
                                           ),
                                      placeholder: (context, url) =>
                                           Shimmer.fromColors(
                                              baseColor: Colors.grey.shade800,
                                              highlightColor: Colors.grey.shade400,
                                              child: Container(
                                                height: 140.h,
                                                width: 140.h,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                  
                                                    color: Get.isDarkMode
                                                        ? AppColors
                                                            .darkFillColor
                                                        : AppColors.shadowColor,
                                                   
                                                    boxShadow: [
                                                      AppStyles.boxShadow
                                                    ],
                                                        ),
                                              ),),
                                      errorWidget: (context, url, error) =>
                                          _emptyProfileImage())
                                  : _emptyProfileImage(),
                              Positioned(
                                  bottom: 5.h,
                                  right: 6.h,
                                  child: GestureDetector(
                                    onTap: () {
                                     // _personalController.pickImage();
                                      showDialog(context: context, builder: (context)=>AlertDialog(
                                        title: Text("Pick Profile Picture",style: AppStyles.h2(fontWeight: FontWeight.w500),),
                                        content:Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            ListTile(
                                              onTap: (){
                                                  _personalController.pickImage();
                                                  Get.back();
                                              },
                                              leading: const Icon(Icons.camera_alt),
                                              dense: true,
                                              contentPadding:EdgeInsets.zero,
                                              minVerticalPadding: 0,
                                              minLeadingWidth: 0,
                                              title: Text("Open Camera",style: AppStyles.h3(fontWeight: FontWeight.w500),),
                                            ),
                                            ListTile(
                                              onTap: (){
                                                _personalController.pickImage(isGallery: true);
                                                Get.back();
                                              },
                                              leading: const Icon(Icons.camera),
                                              dense: true,
                                              contentPadding:EdgeInsets.zero,
                                              minVerticalPadding: 0,
                                              minLeadingWidth: 0,
                                              title: Text("Select from Gallery",style: AppStyles.h3(fontWeight: FontWeight.w500),),
                                            )
                                            
                                          ],
                                        ),
                                      )


                                      );


                                    },
                                    child: Container(
                                      height: 30.h,
                                      width: 30.h,
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(5.h),
                                      decoration: BoxDecoration(
                                          color: AppColors.bgColor,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: AppColors.borderColor,
                                              width: 2)),
                                      child: Center(
                                        child: Icon(
                                          Icons.camera_alt,
                                          color: AppColors.darkBgColor,
                                          size: 16.h,
                                        ),
                                      ),
                                    ),
                                  ))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        if(_personalController.isUploadImageLoading.value)
                        Text("Loading...",style: AppStyles.h2(color:AppColors.greyColor),),
                        SizedBox(
                          height: 30.h,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ///  <---------------- Personal Info ------------------->

                              _personalInfo(),

                              const Divider(),

                              ///  <---------------- Basic Info ------------------->
                              _basicInfo(),

                              const Divider(),

                              ///  <----------------Current Address ------------------->
                              _currentAddressInfo(),
                              const Divider(),
                              ///  <----------------Permanent Address ------------------->
                              _permanentAddressInfo(),
                              const Divider(),

                              ///  <---------------- Contact Info ------------------->
                              _contactInfo(),
                              const Divider(),

                              ///  <---------------- Tuition Info ------------------->
                              _tuitionInfo()
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }

  _tuitionInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _headerTile(
            title: 'Tuition Cost Per Year',
            onTap: () {
              Get.to(TuitionPerYear());
            }),
        SizedBox(
          height: 10.h,
        ),
        _listTile(
            icon: Icons.attach_money,
            title: "Below < ${_controller.userData.value.studentProfile!.budget.toString()}",
            subTitle: "USD"),
      ],
    );
  }

  _currentAddressInfo() {
    return Column(
      children: [
        _headerTile(
            title: 'Current Address',
            onTap: () {
              Get.to(CurrentAddressAdd());
            }),
        SizedBox(
          height: 10.h,
        ),
        _controller.userData.value.currentAddress != null
            ? _listTile(
                icon: Icons.location_on_outlined,
                title:
                    _controller.userData.value.currentAddress!.address,
                subTitle: "${ _controller.userData.value.currentAddress!.division!.name}, ${ _controller.userData.value.currentAddress!.district!.name}",
              )
            : _listTile(
          onTap: (){
            Get.to(CurrentAddressAdd());
          },
                icon: Icons.location_on_outlined,
                errorText: "Add Current Address"),

      ],
    );
  }
  _permanentAddressInfo() {
    return Column(
      children: [
        _headerTile(
            title: 'Permanent Address',
            onTap: () {
              Get.to(PermanentAddressAdd());
            }),
        SizedBox(
          height: 10.h,
        ),

        _controller.userData.value.permanentAddress != null
            ? _listTile(

                icon: Icons.location_on_outlined,
                title:
                _controller.userData.value.permanentAddress!.address,
                subTitle:  "${ _controller.userData.value.permanentAddress!.division!.name}, ${ _controller.userData.value.permanentAddress!.district!.name}",
              )
            : _listTile(
          onTap: (){
            Get.to(PermanentAddressAdd());


          },
                icon: Icons.location_on_outlined,
                errorText: "Add Permanent Address"),
      ],
    );
  }

  _contactInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _headerTile(
            title: 'Contact Info',
            onTap: () {
              Get.to(ContactInfoUpdate());
            }),
        SizedBox(
          height: 10.h,
        ),
        _controller.userData.value.phone.isNotEmpty
            ? _listTile(
                icon: Icons.phone,
                title: _controller.userData.value.phone,
                subTitle: "Phone")
            : _listTile(icon: Icons.phone, errorText: "Add Phone Number",onTap:(){
          Get.to(ContactInfoUpdate());
        }),
      ],
    );
  }

  _basicInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _headerTile(
          title: 'Basic Info',
          onTap: () {
            Get.to(BasicInfoUpdate());
          },
        ),
        SizedBox(
          height: 10.h,
        ),

        /// <------  Gender  ----------->
        if (_controller.userData.value.gender != null)
          _listTile(
              icon: Icons.person_outline,
              title: _controller.userData.value.gender,
              subTitle: "Gender"),
        if (_controller.userData.value.gender != null) _sortDivier(),

        /// <------  date of birth number ----------->
        if (_controller.userData.value.studentProfile != null)
          _listTile(
              icon: Icons.calendar_view_day,
              title:Jiffy.parseFromList([_controller.userData.value.studentProfile!.dob!.year,_controller.userData.value.studentProfile!.dob!.month,_controller.userData.value.studentProfile!.dob!.day]).yMMMMd,
              subTitle: "Date of Birth"),

        /// <------  passport number ----------->
        if (_controller.userData.value.studentProfile!.passportNumber != null)
          _sortDivier(),
        if (_controller.userData.value.studentProfile!.passportNumber != null)
          _listTile(
            icon: Icons.person_2_outlined,
            title: _controller.userData.value.studentProfile!.passportNumber,
            subTitle: "Passport Number",
          ),

        /// <------  Nid ----------->
        if (_controller.userData.value.studentProfile!.nid != null)
          _sortDivier(),
        if (_controller.userData.value.studentProfile!.nid != null)
          _listTile(
            icon: Icons.person,
            title: _controller.userData.value.studentProfile!.nid,
            subTitle: "NID",
          ),

        /// <------  Nationality ----------->
        if (_controller.userData.value.studentProfile!.nationality != null)
          _sortDivier(),
        if (_controller.userData.value.studentProfile!.nationality != null)
          _listTile(
            icon: Icons.person,
            title: _controller.userData.value.studentProfile!.nationality,
            subTitle: "Nationality",
          ),
      ],
    );
  }

  _personalInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _headerTile(
            title: 'Personal Info',
            onTap: () {
              Get.to(PersonalInfoUpdate());
            }),
        SizedBox(
          height: 10.h,
        ),
        _listTile(
            title: _controller.userData.value.studentProfile == null
                ? ""
                : "${_controller.userData.value.studentProfile!.firstname} ${_controller.userData.value.studentProfile!.middlename} ${_controller.userData.value.studentProfile!.lastname}",
            subTitle: "Name",
            icon: Icons.person),
        if (_controller.userData.value.studentProfile != null &&
            _controller.userData.value.studentProfile!.fatherName.isNotEmpty)
          _sortDivier(),
        if (_controller.userData.value.studentProfile != null &&
            _controller.userData.value.studentProfile!.fatherName.isNotEmpty)
          _listTile(
              title: _controller.userData.value.studentProfile == null
                  ? ""
                  : _controller.userData.value.studentProfile!.fatherName,
              subTitle: "Father Name",
              icon: Icons.person),
        if (_controller.userData.value.studentProfile != null &&
            _controller.userData.value.studentProfile!.motherName.isNotEmpty)
          _sortDivier(),
        if (_controller.userData.value.studentProfile != null &&
            _controller.userData.value.studentProfile!.motherName.isNotEmpty)
          _listTile(
              title: _controller.userData.value.studentProfile == null
                  ? ""
                  : _controller.userData.value.studentProfile!.motherName,
              subTitle: "Mother Name",
              icon: Icons.person),
      ],
    );
  }

  _sortDivier() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.h),
      child: const Divider(),
    );
  }

  _listTile({String? title, subTitle, errorText, required IconData icon,Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            height: 40.h,
            width: 40.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Get.theme.cardColor,
                border: Border.all(color: AppColors.borderColor)),
            child: Icon(
              icon,
              size: 25.h,
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          subTitle == null && title == null
              ? Expanded(
                  child: Text(
                  errorText,
                  style: AppStyles.h4(color: AppColors.mainColor),
                ))
              : Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title!,
                        style: AppStyles.h4(),
                      ),
                      Text(
                        subTitle,
                        style: AppStyles.h4(color: AppColors.greyColor),
                      )
                    ],
                  ),
                ),
        ],
      ),
    );
  }

  _emptyProfileImage() {
    return Container(
      height: 140.h,
      width: 140.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color:
              Get.isDarkMode ? AppColors.darkFillColor : AppColors.shadowColor,
          border: Border.all(color: AppColors.bgColor, width: 4),
          boxShadow: [AppStyles.boxShadow],
          image: DecorationImage(
              image: AssetImage(
                AppIcons.person,
              ),
              fit: BoxFit.cover)),
    );
  }

  _headerTile({required String title, Function()? onTap}) {
    return Row(
      children: [
        Expanded(
            child: Text(
          title,
          style: AppStyles.h4(fontWeight: FontWeight.bold),
        )),
        GestureDetector(
            onTap: onTap,
            child: Padding(
              padding: EdgeInsets.all(5.sp),
              child: Text(
                "Edit",
                style: AppStyles.h4(
                    fontWeight: FontWeight.w500, color: AppColors.mainColor),
              ),
            ))
      ],
    );
  }
}
