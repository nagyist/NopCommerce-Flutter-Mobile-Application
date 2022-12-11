/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nopcommerce/Common/CheckInternet.dart';
import 'package:nopcommerce/Common/FlushbarMessage.dart';
import 'package:nopcommerce/Common/HtmlAttribute.dart';
import 'package:nopcommerce/Models/CustomerAttributeValueModel.dart';
import 'package:nopcommerce/Screens/Home/MainScreen.dart';
import 'package:nopcommerce/Utils/Enum/LoginTypeAttribute.dart';
import 'package:nopcommerce/Utils/Enum/CustomerAttributes.dart';
import 'package:nopcommerce/Models/GetTopicBlockModel.dart';
import 'package:nopcommerce/Models/InvalidResponseModel.dart';
import 'package:nopcommerce/Models/CommonStateModel.dart';
import 'package:nopcommerce/Models/StateModel.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Screens/Customer/Login/Login.dart';
import 'package:nopcommerce/Screens/Customer/Register/Models/GenderData.dart';
import 'package:nopcommerce/Screens/Customer/Register/Models/GetRegisterResponseModel.dart';
import 'package:nopcommerce/Screens/Customer/Register/Models/RegisterResponseModel.dart';
import 'package:nopcommerce/Services/CommonService.dart';
import 'package:nopcommerce/Services/CustomerService.dart';
import 'package:nopcommerce/Utils/Enum/PageTransitionType.dart';
import 'package:nopcommerce/Utils/SharedPreferences.dart';
import 'package:nopcommerce/Widgets/DropdownWidget/DropdownModel.dart';
import 'package:nopcommerce/Widgets/PageTransition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Models/RegisterRequestModel.dart';

class RegisterProvider extends ChangeNotifier {

  int loginType = 0;
  bool isAPILoader = false;
  bool isPageLoader = true;
  late GetRegisterResponseModel getRegisterResponseModel;
  late RegisterRequestModel requestModel;
  late GetTopicBlockModel getTopicBlockModel;
  ScrollController scrollController = ScrollController();
  List<String> errors = [];
  List<GenderData> genderData = [];
  List<DropDownModel> stateDropDown = [];
  bool privacyPolicy = false;
  bool isPassword = true;
  bool isConfirmPassword = true;
  String checkAvailability = '';
  bool avail = false;
  bool isUserNameCheck = false;
  TextEditingController emailController = new TextEditingController();
  TextEditingController confirmEmailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController newPassController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();
  TextEditingController firstNameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController dateOfBirthController = new TextEditingController();
  TextEditingController companyNameController = new TextEditingController();
  TextEditingController vatNumberController = new TextEditingController();
  TextEditingController streetAddressController = new TextEditingController();
  TextEditingController streetAddress2Controller = new TextEditingController();
  TextEditingController zipPostalCodeController = new TextEditingController();
  TextEditingController countyRegionController = new TextEditingController();
  TextEditingController cityController = new TextEditingController();
  TextEditingController userNameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController faxController = new TextEditingController();

  clearDefaultData({required BuildContext context}) async
  {
    isAPILoader = false;
    isPageLoader = true;
    errors = [];
    genderData = [];
    stateDropDown = [];
    privacyPolicy = false;
    isPassword = true;
    isConfirmPassword = true;
    checkAvailability = '';
    avail = false;
    isUserNameCheck = false;
    emailController.text = "";
    confirmEmailController.text ="";
    passwordController.text = "";
    newPassController.text = "";
    confirmPasswordController.text="";
    firstNameController.text = "";
    lastNameController.text = "";
    dateOfBirthController.text = "";
    companyNameController.text = "";
    vatNumberController.text = "";
    streetAddressController.text ="";
    streetAddress2Controller.text="";
    zipPostalCodeController.text ="";
    countyRegionController.text ="";
    cityController.text = "";
    phoneController.text ="";
    faxController.text = "";

  }

  pageLoadData({required BuildContext context, required int loginType})
  {
    this.loginType = loginType;
    getRegister(context: context);

  }

  getRegister({required BuildContext context}) async
  {
    Response response = await CustomerService().getRegisterData(context: context);
    if (response.statusCode == 200) {
      getRegisterResponseModel = getRegisterResponseModelFromJson(response.body);
      getPrivacyTopicBlock(context: context);
    }
  }

  getPrivacyTopicBlock({required BuildContext context}) async {
    Response response = await CommonService().getTopicBlock(context: context, topic: 'privacyInfo');
    if (response.statusCode == 200) {
      getTopicBlockModel = getTopicBlockModelFromJson(response.body);
    }
    getData(context: context);
  }

  getData({required BuildContext context}) async {
    stateDropDown.clear();
    for(var c in getRegisterResponseModel.availableStates) {
      stateDropDown.add(DropDownModel(text: c.text, value: c.value,));
    }

    for(var i in getRegisterResponseModel.availableTimeZones){
      if(i.selected){
        getRegisterResponseModel.timeZoneId= i.value;
      }
    }

    genderData.clear();
    genderData.add(GenderData(id: 1,code: "M",name: LocalResourceProvider().getResourseByKey("account.fields.gender.male")));
    genderData.add(GenderData(id: 2,code: "F",name: LocalResourceProvider().getResourseByKey("account.fields.gender.female")));


    if (getRegisterResponseModel.countryEnabled) {
      if (getRegisterResponseModel.countryId == null || getRegisterResponseModel.countryId == "") {
        getRegisterResponseModel.countryId = int.parse(getRegisterResponseModel.availableCountries[0].value);
      }
    }

    if (getRegisterResponseModel.stateProvinceEnabled && getRegisterResponseModel.countryEnabled) {
      if (getRegisterResponseModel.stateProvinceId == null && getRegisterResponseModel.stateProvinceId == "") {
        getRegisterResponseModel.stateProvinceId = int.parse(getRegisterResponseModel.availableStates[0].value);
      }
    }

    if (getRegisterResponseModel.allowCustomersToSetTimeZone) {
      if (getRegisterResponseModel.timeZoneId == null || getRegisterResponseModel.timeZoneId == "") {
        getRegisterResponseModel.timeZoneId = getRegisterResponseModel.availableTimeZones[0].value;
      }
    }

    isPageLoader = false;
    notifyListeners();
  }

  getStateDataByCountryId({required BuildContext context, required int countryId}) async
  {
    if (await CheckConnectivity().checkInternet(context)) {
      isAPILoader = true;
      notifyListeners();

      List<StateModel> stateModelList = [];
      Response response = await CommonService().getStateData(context: context, countryId: countryId);
      if (response.statusCode == 200) {
        stateModelList = getStatesModelFromJson(response.body);
      }
      stateDropDown.clear();
      for (var item in stateModelList) {
        stateDropDown.add(DropDownModel(text: item.name, value: item.id.toString()));
      }
      getRegisterResponseModel.stateProvinceId = stateModelList[0].id;
      isAPILoader = false;
      notifyListeners();
    }

    notifyListeners();
  }

  registerButtonClickEvent(BuildContext context, loginType) async
  {
    if (dateOfBirthController.text.trim().isNotEmpty) {
      List<String> datOfBirthList = dateOfBirthController.text.trim().toString().split("/");

      getRegisterResponseModel.dateOfBirthMonth = int.parse(datOfBirthList[0]);
      getRegisterResponseModel.dateOfBirthDay = int.parse(datOfBirthList[1]);
      getRegisterResponseModel.dateOfBirthYear = int.parse(datOfBirthList[2]);
    }

    errors.clear();
    isAPILoader = true;
    notifyListeners();

    Map<String, String> customerAttributesSelected = {};
    Map<String, String> gdprConsentsSelected = {};

    String prefixString = "customer_attribute_";
    String consentsPrefixString = "consent";

    for (var item in getRegisterResponseModel.customerAttributes) {
      if (item.attributeControlType == AttributeControlType.Checkboxes || item.attributeControlType == AttributeControlType.ReadonlyCheckboxes) {
        List<int> selectCheckbox = [];
        for (var cItem in item.values) {
          if (cItem.isPreSelected) {
            selectCheckbox.add(cItem.id);
          }
        }
        String checkboxString = selectCheckbox.join(",");
        customerAttributesSelected['"$prefixString${item.id}"'] = '"$checkboxString"';
      } else {
        if (item.defaultValue != null) {
          customerAttributesSelected['"$prefixString${item.id}"'] = '"${item.defaultValue}"';
        } else {
          customerAttributesSelected['"$prefixString${item.id}"'] = "''";
        }
      }
    }

    for (var item in getRegisterResponseModel.gdprConsents) {
      String checkCondition = "";
      if (item.accepted) {
        checkCondition = "on";
      }
      gdprConsentsSelected['"$consentsPrefixString${item.id}"'] = '"$checkCondition"';
    }


    final body = '{ '
        '"username": "${userNameController.text.toString()}",'
        '"password": "${passwordController.text.toString()}",'
        '"confirmPassword": "${confirmPasswordController.text.toString()}",'
        '"email": "${emailController.text.toString()}",'
        '"confirmEmail": "${confirmEmailController.text.toString()}",'
        '"timeZoneId": "${getRegisterResponseModel.timeZoneId}",'
        '"vatNumber": "${vatNumberController.text.toString()}",'
        '"gender": "${getRegisterResponseModel.gender.toString()}",'
        '"firstName": "${firstNameController.text.toString()}",'
        '"lastName": "${lastNameController.text.toString()}",'
        '"dateOfBirthDay": ${getRegisterResponseModel.dateOfBirthDay},'
        '"dateOfBirthMonth": ${getRegisterResponseModel.dateOfBirthMonth},'
        '"dateOfBirthYear": ${getRegisterResponseModel.dateOfBirthYear},'
        '"company": "${companyNameController.text.toString()}",'
        '"streetAddress": "${streetAddressController.text.toString()}",'
        '"streetAddress2": "${streetAddress2Controller.text.toString()}",'
        '"zipPostalCode": "${zipPostalCodeController.text.toString()}",'
        '"city": "${cityController.text.toString()}",'
        '"county": "${countyRegionController.text.toString()}",'
        '"countryId": ${getRegisterResponseModel.countryId},'
        '"phone": "${phoneController.text.toString()}",'
        '"fax": "${faxController.text.toString()}",'
        '"stateProvinceId": ${getRegisterResponseModel.stateProvinceId},'
        '"newsletter": ${getRegisterResponseModel.newsletter},'
        '"loginAfterRegistration": true,'
        '"CustomerAttributes": $customerAttributesSelected,'
        '"GdprConsents": $gdprConsentsSelected'
        '}';

    Response response = await CustomerService().userRegister(context: context, body: body);

    if (response.statusCode == 400) {
      isAPILoader = false;
      InvalidResponseModel error = invalidResponseModelFromJson(response.body);
      errors.clear();
      for (var er in error.errors) {
        if (!errors.contains(er)) {
          errors.add(er.replaceAll(htmlExpressions, ""));
          notifyListeners();
        }
      }

      scrollController.animateTo(scrollController.position.minScrollExtent,duration: Duration(milliseconds: 500),curve: Curves.ease);

    } else if (response.statusCode == 200) {
      isAPILoader = false;
      RegisterResponseModel registerResponseModel = registerResponseModelFromJson(response.body);
      if (registerResponseModel.accessToken == null || registerResponseModel.accessToken == "") {
        Navigator.pushReplacement(context, PageTransition(type: selectedTransition, child: Login(loginType: LoginTypeAttribute.Login,)));
      } else {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString(SharedPreferencesValues.SHARED_PREFERENCE_TOKEN, registerResponseModel.accessToken);
        preferences.setString(SharedPreferencesValues.SHARED_PREFERENCE_REFRESH_TOKEN, registerResponseModel.refreshToken);
        preferences.setBool(SharedPreferencesValues.SHARED_PREFERENCE_IS_LOGIN, true);
        preferences.setBool(SharedPreferencesValues.SHARED_PREFERENCE_IS_WITHOUT_LOGIN, false);

        if (loginType == LoginTypeAttribute.Checkout) {
          Navigator.pop(context);
        } else {
          Navigator.pushReplacement(context, PageTransition(type: selectedTransition, child: MainScreen(tabIndex: 0,)));
        }
      }
      FlushBarMessage().successMessage( context: context, title: registerResponseModel.message);
    }
    notifyListeners();
  }

  checkUserNameAvailability({required BuildContext context}) async {
    if (userNameController.text.isNotEmpty) {
      isUserNameCheck = true;

      Response response= await CustomerService().checkAvailability(context: context, userName: userNameController.text);
      var checkData;
      if(response.statusCode==200){
        checkData=response.body;
      }
      else if(response.statusCode==400){

      }
      if (checkData != null) {
        checkData = checkData.replaceAll('"', "");
        if (checkData.toString().trim() == LocalResourceProvider().getResourseByKey("account.checkUserNameAvailability.available")) {
          checkAvailability = checkData;
          avail = true;
        }
        else {
          checkAvailability = checkData;
          avail = false;
        }
        isUserNameCheck = false;
      } else {
        checkAvailability = "";
        isUserNameCheck = false;
      }
    } else {
      {
        FlushBarMessage().failedMessage(context: context, title: LocalResourceProvider().getResourseByKey("account.fields.username.required"));
        checkAvailability = "";
      }
    }
    notifyListeners();
  }

}