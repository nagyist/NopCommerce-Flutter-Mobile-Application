/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nopcommerce/Common/FlushbarMessage.dart';
import 'package:nopcommerce/Models/CustomerAttributeValueModel.dart';
import 'package:nopcommerce/Models/InvalidResponseModel.dart';
import 'package:nopcommerce/Models/UserInformationModel.dart';
import 'package:nopcommerce/Services/CustomerService.dart';
import 'package:nopcommerce/Utils/CacheDatabase.dart';
import 'package:nopcommerce/Models/CommonStateModel.dart';
import 'package:nopcommerce/Models/GenderData.dart';
import 'package:nopcommerce/Models/StateModel.dart';
import 'package:nopcommerce/Screens/Customer/CustomerInfo/Models/UserInformationResponseModel.dart';
import 'package:nopcommerce/Models/HeaderInfoResponseModel.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Services/CommonService.dart';
import 'package:nopcommerce/Services/CustomerInfoService.dart';
import 'package:nopcommerce/Utils/Enum/CustomerAttributes.dart';
import 'package:nopcommerce/Utils/Strings.dart';
import 'package:nopcommerce/Widgets/DialogBoxWidget.dart';
import 'package:nopcommerce/Widgets/DropdownWidget/DropdownModel.dart';
import 'package:nopcommerce/Models/CustomProperties.dart';

class CustomerInfoProvider extends ChangeNotifier {

  bool isPageLoader=true;
  bool isAPILoader=false;
  bool isUserNameCheck=false;
  bool avail=false;

  TextEditingController fNameController=new TextEditingController();
  TextEditingController lNameController=new TextEditingController();
  TextEditingController dobController=new TextEditingController();
  TextEditingController companyNameController=new TextEditingController();
  TextEditingController emailController=new TextEditingController();
  TextEditingController confirmEmailController=new TextEditingController();
  TextEditingController passController=new TextEditingController();
  TextEditingController newPassController=new TextEditingController();
  TextEditingController confirmPassController=new TextEditingController();
  TextEditingController vatNumberController=new TextEditingController();
  TextEditingController streetAddressController=new TextEditingController();
  TextEditingController streetAddress2Controller=new TextEditingController();
  TextEditingController zipPostalCodeController=new TextEditingController();
  TextEditingController countyRegionController=new TextEditingController();
  TextEditingController cityController=new TextEditingController();
  TextEditingController userNameController=new TextEditingController();
  TextEditingController phoneController=new TextEditingController();
  TextEditingController faxController=new TextEditingController();
  TextEditingController signatureController=new TextEditingController();

  late UserInformationModel userInformationResponseModel;
  HeaderInfoResponseModel headerModel = new HeaderInfoResponseModel(
      isAuthenticated: false,
      customerName: "",
      shoppingCartEnabled: false,
      shoppingCartItems: 0,
      wishlistEnabled: false,
      wishlistItems: 0,
      allowPrivateMessages: false,
      unreadPrivateMessages: "",
      alertMessage: "",
      registrationType: "",
      customProperties: CustomProperties()
  );
  String checkAvailability='';

  List<GenderData> genderData=[];
  List<DropDownModel> stateDropDown=[];

  pageLoadData({required BuildContext context}){
    getUserInfoData(context: context);
  }

  getUserInfoData({required BuildContext context}) async{
    Response response = await CustomerInfoService().getUserInformation(context: context);
    if(response.statusCode==200){
      storage.setItem(StringConstants.CACHE_USERINFO, response.body);
      userInformationResponseModel=userInformationResponseModelFromJson(response.body);
      stateDropDown.clear();
      for(var c in userInformationResponseModel.availableStates)
      {
        stateDropDown.add(DropDownModel(text: c.text, value: c.value,));
      }
      genderData.clear();
      genderData.add(GenderData(1,"M", LocalResourceProvider().getResourseByKey("account.fields.gender.male")));
      genderData.add(GenderData(2,"F", LocalResourceProvider().getResourseByKey("account.fields.gender.female")));

      userInformationResponseModel.gender = userInformationResponseModel.gender == null ? "" : userInformationResponseModel.gender;

      fNameController.text=userInformationResponseModel.firstName;
      lNameController.text=userInformationResponseModel.lastName;
      if(userInformationResponseModel.dateOfBirthDay != null && userInformationResponseModel.dateOfBirthMonth != null && userInformationResponseModel.dateOfBirthYear != null)
      {
        dobController.text="${userInformationResponseModel.dateOfBirthDay}/${userInformationResponseModel.dateOfBirthMonth}/${userInformationResponseModel.dateOfBirthYear}";
      }
      companyNameController.text=userInformationResponseModel.company;
      emailController.text=userInformationResponseModel.email;
      if(userInformationResponseModel.emailToRevalidate != null){
        confirmEmailController.text=userInformationResponseModel.emailToRevalidate;
      }
      vatNumberController.text=userInformationResponseModel.vatNumber;
      streetAddressController.text=userInformationResponseModel.streetAddress;
      streetAddress2Controller.text=userInformationResponseModel.streetAddress2;
      zipPostalCodeController.text=userInformationResponseModel.zipPostalCode;
      countyRegionController.text=userInformationResponseModel.county;
      cityController.text=userInformationResponseModel.city;
      userNameController.text=userInformationResponseModel.username;
      phoneController.text=userInformationResponseModel.phone;
      faxController.text=userInformationResponseModel.fax;

      if(userInformationResponseModel.signatureEnabled)
      {
        signatureController.text = userInformationResponseModel.signature;
      }

      if(userInformationResponseModel.countryEnabled)
      {
        if(userInformationResponseModel.countryId != null && userInformationResponseModel.countryId != ""){

          userInformationResponseModel.countryId = userInformationResponseModel.countryId;
        }
      }

      if(userInformationResponseModel.stateProvinceEnabled && userInformationResponseModel.countryEnabled)
      {
        if(userInformationResponseModel.stateProvinceId != null && userInformationResponseModel.stateProvinceId != "")
        {
          userInformationResponseModel.stateProvinceId = userInformationResponseModel.stateProvinceId;
        }else{
          if( userInformationResponseModel.stateProvinceId==""){
            userInformationResponseModel.stateProvinceId =  int.parse(userInformationResponseModel.availableStates[0].value);
          }
        }
      }

      if(userInformationResponseModel.allowCustomersToSetTimeZone)
      {
        if(userInformationResponseModel.timeZoneId != null && userInformationResponseModel.timeZoneId != "")
        {
          userInformationResponseModel.timeZoneId = userInformationResponseModel.timeZoneId;
        }else{
          for(var i in userInformationResponseModel.availableTimeZones){
            if(i.selected){
              userInformationResponseModel.timeZoneId= i.value;
            }
          }
          if( userInformationResponseModel.timeZoneId==""){
            userInformationResponseModel.timeZoneId =  userInformationResponseModel.availableTimeZones[0].value;
          }
        }
      }
       isAPILoader=false;
    }
    getHeaderData(context: context);
  }

  getHeaderData({required BuildContext context}) async {

    Response response = await CommonService().getHeaderData(context: context);
    if(response.statusCode == 200)
    {
      storage.setItem(StringConstants.CACHE_HEADER, response.body);
      headerModel = headerInfoResponseModelFromJson(response.body);

      if(headerModel.alertMessage != "")
      {
        DialogBoxWidget().confirmationDialogBox(context: context, title: "Notification", content: headerModel.alertMessage, cancelText: "Cancel", submitText: "Ok", isCancelable: true, onSubmit: (){});
      }
    }else{
      storage.setItem(StringConstants.CACHE_HEADER, null);
    }
    isPageLoader=false;
    isAPILoader=false;
    notifyListeners();
  }

  checkUserNameAvailability({required BuildContext context}) async {
    if (userNameController.text.isNotEmpty) {
      isAPILoader=true;
      notifyListeners();
      isUserNameCheck = true;
      Response response= await CustomerService().checkAvailability(context: context, userName: userNameController.text);
      var checkData;
      if(response.statusCode==200){
        checkData=response.body;
      }
      else if(response.statusCode==400){
        InvalidResponseModel errors = invalidResponseModelFromJson(response.body);
        FlushBarMessage().failedMessage(context: context, title: errors.errors.join("\n"));
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
    isAPILoader=false;
    notifyListeners();
  }

  updateButtonClickEvent({required BuildContext context})async
  {
    if (dobController.text.trim().isNotEmpty) {
      List<String> datOfBirthList = dobController.text.trim().toString().split("/");

      userInformationResponseModel.dateOfBirthDay = int.parse(datOfBirthList[0]);
      userInformationResponseModel.dateOfBirthMonth = int.parse(datOfBirthList[1]);
      userInformationResponseModel.dateOfBirthYear = int.parse(datOfBirthList[2]);
    }

    isAPILoader = true;
    notifyListeners();

    Map<String, String> customerAttributesSelected = {};
    Map<String, String> gDPRConsentsSelected = {};
    String prefixString = "customer_attribute_";
    String consentsPrefixString = "consent";

    for(var item in userInformationResponseModel.customerAttributes)
    {
      if(item.attributeControlType == AttributeControlType.Checkboxes || item.attributeControlType == AttributeControlType.ReadonlyCheckboxes)
      {
        List<int> selectCheckbox=[];
        for(var cItem in item.values)
        {
          if(cItem.isPreSelected)
          {
            selectCheckbox.add(cItem.id);
          }
        }
        String checkboxString = selectCheckbox.join(",");
        customerAttributesSelected['"$prefixString${item.id}"'] = '"$checkboxString"';
      }else{
        if (item.defaultValue != null) {
          customerAttributesSelected['"$prefixString${item.id}"'] = '"${item.defaultValue}"';
        } else {
          customerAttributesSelected['"$prefixString${item.id}"']  = "''";
        }
      }
    }

    for(var item in userInformationResponseModel.gdprConsents)
    {
      String checkCondition="";
      if(item.accepted)
      {
        checkCondition="on";
      }
      gDPRConsentsSelected['"$consentsPrefixString${item.id}"'] = '"$checkCondition"';
    }
    final body='{ '
        '"username": "${userNameController.text}",'
        '"password": "${passController.text}",'
        '"confirmPassword": "${confirmPassController.text}",'
        '"email": "${emailController.text}",'
        '"confirmEmail": "${confirmEmailController.text}",'
        '"timeZoneId": "${userInformationResponseModel.timeZoneId}",'
        '"vatNumber": "${vatNumberController.text}",'
        '"gender": "${userInformationResponseModel.gender}",'
        '"firstName": "${fNameController.text}",'
        '"lastName": "${lNameController.text}",'
        '"dateOfBirthDay": ${userInformationResponseModel.dateOfBirthDay},'
        '"dateOfBirthMonth": ${userInformationResponseModel.dateOfBirthMonth},'
        '"dateOfBirthYear": ${userInformationResponseModel.dateOfBirthYear},'
        '"company": "${companyNameController.text}",'
        '"streetAddress": "${streetAddressController.text}",'
        '"streetAddress2": "${streetAddress2Controller.text}",'
        '"zipPostalCode": "${zipPostalCodeController.text}",'
        '"city": "${cityController.text}",'
        '"county": "${countyRegionController.text}",'
        '"countryId": ${userInformationResponseModel.countryId},'
        '"phone": "${phoneController.text}",'
        '"fax": "${faxController.text}",'
        '"stateProvinceId": ${userInformationResponseModel.stateProvinceId},'
        '"newsletter": ${userInformationResponseModel.newsletter},'
        '"CustomerAttributes": $customerAttributesSelected,'
        '"gdprConsents": $gDPRConsentsSelected,'
        '"signature": "${signatureController.text}"'
        '}';

    Response response = await CustomerInfoService().putUserInfoData(context: context, body: body);
    if(response.statusCode == 200 || response.statusCode == 202){
      isAPILoader = false;
      notifyListeners();
      Navigator.pop(context);
      FlushBarMessage().successMessage(context: context, title: LocalResourceProvider().getResourseByKey("nopAdvance.plugin.publicApi.defaultClean.customerInfo.updated"));
    }else if(response.statusCode==400){
      InvalidResponseModel errors = invalidResponseModelFromJson(response.body);
      FlushBarMessage().failedMessage(context: context, title: errors.errors.join("\n"));
    }
    isAPILoader=false;
    notifyListeners();
  }

  getStateDataByCountryId({required BuildContext context,required int countryId}) async
  {
    isAPILoader = true;
    notifyListeners();

    Response response = await CommonService().getStateData(context: context, countryId: countryId);
    if (response.statusCode == 200) {

      List<StateModel> stateModelList = getStatesModelFromJson(response.body);
      stateDropDown.clear();
      for(var item in stateModelList)
      {
        stateDropDown.add(DropDownModel(text: item.name, value: item.id.toString(),));
      }
      userInformationResponseModel.stateProvinceId = stateModelList[0].id;
    }
    isAPILoader = false;
    notifyListeners();
  }

  loadCacheData({required BuildContext context})async{

    isPageLoader=true;
    isAPILoader=false;
    avail=false;
    genderData=[];
    checkAvailability='';

    if(LocalResourceProvider().isLocalDataLoad)
    {
      await getCacheUserInfo(context: context);
      await getCacheHeader(context: context);
    }

  }

  getCacheUserInfo({required BuildContext context}) async {
    await storage.ready;
    String res = storage.getItem(StringConstants.CACHE_USERINFO);
    if(res != null)
    {
      userInformationResponseModel = userInformationResponseModelFromJson(res);
      stateDropDown.clear();
      for(var c in userInformationResponseModel.availableStates)
      {
        stateDropDown.add(DropDownModel(text: c.text, value: c.value,));
      }
      genderData.clear();
      genderData.add(GenderData(1,"M", LocalResourceProvider().getResourseByKey("account.fields.gender.male")));
      genderData.add(GenderData(2,"F", LocalResourceProvider().getResourseByKey("account.fields.gender.female")));

      userInformationResponseModel.gender = userInformationResponseModel.gender == null ? "" : userInformationResponseModel.gender;

      fNameController.text=userInformationResponseModel.firstName;
      lNameController.text=userInformationResponseModel.lastName;
      if(userInformationResponseModel.dateOfBirthDay != null && userInformationResponseModel.dateOfBirthMonth != null && userInformationResponseModel.dateOfBirthYear != null)
      {
        dobController.text="${userInformationResponseModel.dateOfBirthDay}/${userInformationResponseModel.dateOfBirthMonth}/${userInformationResponseModel.dateOfBirthYear}";
      }
      companyNameController.text=userInformationResponseModel.company;
      emailController.text=userInformationResponseModel.email;
      if(userInformationResponseModel.emailToRevalidate != null){
        confirmEmailController.text=userInformationResponseModel.emailToRevalidate;
      }
      vatNumberController.text=userInformationResponseModel.vatNumber;
      streetAddressController.text=userInformationResponseModel.streetAddress;
      streetAddress2Controller.text=userInformationResponseModel.streetAddress2;
      zipPostalCodeController.text=userInformationResponseModel.zipPostalCode;
      countyRegionController.text=userInformationResponseModel.county;
      cityController.text=userInformationResponseModel.city;
      userNameController.text=userInformationResponseModel.username;
      phoneController.text=userInformationResponseModel.phone;
      faxController.text=userInformationResponseModel.fax;

      if(userInformationResponseModel.signatureEnabled)
      {
        signatureController.text = userInformationResponseModel.signature;
      }

      if(userInformationResponseModel.countryEnabled)
      {
        if(userInformationResponseModel.countryId != null && userInformationResponseModel.countryId != ""){

          userInformationResponseModel.countryId = userInformationResponseModel.countryId;
        }
      }

      if(userInformationResponseModel.stateProvinceEnabled && userInformationResponseModel.countryEnabled)
      {
          if(userInformationResponseModel.stateProvinceId != null && userInformationResponseModel.stateProvinceId != "")
          {
            userInformationResponseModel.stateProvinceId = userInformationResponseModel.stateProvinceId;
          }else{
            if( userInformationResponseModel.stateProvinceId==""){
              userInformationResponseModel.stateProvinceId =  int.parse(userInformationResponseModel.availableStates[0].value);
            }
          }
      }

      if(userInformationResponseModel.allowCustomersToSetTimeZone)
      {
        if(userInformationResponseModel.timeZoneId != null && userInformationResponseModel.timeZoneId != "")
        {
          userInformationResponseModel.timeZoneId = userInformationResponseModel.timeZoneId;
        }else{
          for(var i in userInformationResponseModel.availableTimeZones){
            if(i.selected){
              userInformationResponseModel.timeZoneId= i.value;
            }
          }

          if( userInformationResponseModel.timeZoneId==""){
            userInformationResponseModel.timeZoneId =  userInformationResponseModel.availableTimeZones[0].value;
          }
        }
      }

      isPageLoader = false;
      notifyListeners();
      return userInformationResponseModel;
    }else{
      return null;
    }
  }

  getCacheHeader({required BuildContext context}) async {
    await storage.ready;
    String res = storage.getItem(StringConstants.CACHE_HEADER);
    if(res != null)
    {
      headerModel = headerInfoResponseModelFromJson(res);
      if(headerModel.alertMessage != "")
      {
        DialogBoxWidget().confirmationDialogBox(context: context, title: "Notification", content: headerModel.alertMessage, cancelText: "Cancel", submitText: "Ok", isCancelable: true, onSubmit: (){});
      }
      return headerModel;
    }else{
      return null;
    }
  }
}