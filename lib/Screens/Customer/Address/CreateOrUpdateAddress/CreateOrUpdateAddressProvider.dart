/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nopcommerce/Common/FlushbarMessage.dart';
import 'package:nopcommerce/Models/AddressModel.dart';
import 'package:nopcommerce/Models/CommonStateModel.dart';
import 'package:nopcommerce/Models/CountryStateModel.dart';
import 'package:nopcommerce/Models/CustomProperties.dart';
import 'package:nopcommerce/Models/HeaderInfoResponseModel.dart';
import 'package:nopcommerce/Models/InvalidResponseModel.dart';
import 'package:nopcommerce/Models/StateModel.dart';
import 'package:nopcommerce/Screens/Customer/Address/CreateOrUpdateAddress/Model/GetAddressByIdModel.dart';
import 'package:nopcommerce/Services/AddressListService.dart';
import 'package:nopcommerce/Services/CommonService.dart';
import 'package:nopcommerce/Utils/CacheDatabase.dart';
import 'package:nopcommerce/Utils/Enum/CustomerAttributes.dart';
import 'package:nopcommerce/Utils/Enum/FormType.dart';
import 'package:nopcommerce/Utils/Strings.dart';
import 'package:nopcommerce/Widgets/DropdownWidget/DropdownModel.dart';

import 'Model/AddAddressModel.dart';

class CreateOrUpdateAddressProvider extends ChangeNotifier{

  bool isPageLoader=true;
  bool isAPILoader=false;
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

  late AddressModel addressModel;


  TextEditingController firstNameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController companyNameController = new TextEditingController();
  TextEditingController signatureController = new TextEditingController();
  TextEditingController dateController = new TextEditingController();
  TextEditingController cityController = new TextEditingController();
  TextEditingController countyController = new TextEditingController();
  TextEditingController address1Controller = new TextEditingController();
  TextEditingController address2Controller = new TextEditingController();
  TextEditingController zipCodeController = new TextEditingController();
  TextEditingController phoneNumberController = new TextEditingController();
  TextEditingController faxNumberController = new TextEditingController();
  String formType = FormType.Create;
  int addressId = 0;
  List<DropDownModel> stateDropDown=[];

  pageLoadData({required BuildContext context,required String formType,required int addressId}) async
  {
    isPageLoader=true;
    isAPILoader=false;
    this.formType = formType;
    this.addressId = addressId;
    stateDropDown.clear();
    firstNameController.text="";
    lastNameController.text="";
    emailController.text="";
    companyNameController.text="";
    cityController.text= "";
    address1Controller.text="";
    address2Controller.text="";
    zipCodeController.text="";
    phoneNumberController.text="";
    faxNumberController.text="";
    notifyListeners();
    getAddress(context: context);
  }

  getAddress({required BuildContext context})async {
    isAPILoader=true;
    notifyListeners();
    Response response;
    if(formType == FormType.Create)
    {
      response = await AddressService().getAddAddresses(context: context);
    }else{
      response = await AddressService().getAddressById(context: context, param: "/$addressId");
    }

    if (response.statusCode == 200) {

      if(formType == FormType.Create)
      {
        addressModel = addAddressModelFromJson(response.body);
      }else{
        addressModel = getAddressByIdModelFromJson(response.body).address;
      }

      isAPILoader=false;
      stateDropDown.clear();
      for(var item in addressModel.availableStates)
      {
        stateDropDown.add(DropDownModel(text: item.text, value:item.value,));
      }

      if(addressModel.firstName != null){
        firstNameController.text = addressModel.firstName;
      }
      if(addressModel.lastName != null){
        lastNameController.text = addressModel.lastName;
      }
      if(addressModel.email != null){
        emailController.text = addressModel.email;
      }
      if(addressModel.company != null){
        companyNameController.text = addressModel.company;
      }
      if(addressModel.city != null){
        cityController.text = addressModel.city;
      }
      if(addressModel.address1 != null){
        address1Controller.text = addressModel.address1;
      }
      if(addressModel.address2 != null){
        address2Controller.text = addressModel.address2;
      }
      if(addressModel.zipPostalCode != null){
        zipCodeController.text = addressModel.zipPostalCode;
      }
      if(addressModel.phoneNumber != null){
        phoneNumberController.text = addressModel.phoneNumber;
      }
      if(addressModel.faxNumber != null){
        faxNumberController.text = addressModel.faxNumber;
      }
      if(addressModel.county != null){
        countyController.text = addressModel.county;
      }
      if(addressModel.countryEnabled)
      {
        if(addressModel.countryId == null || addressModel.countryId == ""){

          List<CountryStateModel> availableCountries = addressModel.availableCountries.where((element) => element.selected).toList();
          if(availableCountries.isNotEmpty)
          {
            addressModel.countryId = int.parse(availableCountries[0].value);
          }else{
            addressModel.countryId = int.parse(addressModel.availableCountries[0].value);
          }
        }
      }

      if(addressModel.stateProvinceEnabled && addressModel.countryEnabled)
      {
        if(addressModel.stateProvinceId == null || addressModel.stateProvinceId == "")
        {
          List<CountryStateModel> availableStates = addressModel.availableStates.where((element) => element.selected).toList();
          if(availableStates.isNotEmpty)
          {
            addressModel.stateProvinceId =  int.parse(availableStates[0].value);
          }else{
            addressModel.stateProvinceId =  int.parse(addressModel.availableStates[0].value);
          }
        }
      }

    }

    getHeaderData(context: context);
    notifyListeners();
  }

  getHeaderData({required BuildContext context}) async {

    Response response = await CommonService().getHeaderData(context: context);
    storage.setItem(StringConstants.CACHE_HEADER, response.body);
    if(response.statusCode == 200)
    {
      headerModel = headerInfoResponseModelFromJson(response.body);
    }
    isPageLoader=false;
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
      addressModel.stateProvinceId = stateModelList[0].id;
    }

    isAPILoader = false;
    notifyListeners();
  }

  buttonClickEvent({required BuildContext context})async
  {
    isAPILoader=true;
    notifyListeners();
    Map<String, String> customerAttributesSelected = {};
    String prefixString = "address_attribute_";

    for(var item in addressModel.customAddressAttributes)
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
    final body='{ '
        '"firstName": "${firstNameController.text}",'
        '"lastName": "${lastNameController.text}",'
        '"email": "${emailController.text}",'
        '"company": "${companyNameController.text}",'
        '"countryId": ${addressModel.countryId},'
        '"stateProvinceId": ${addressModel.stateProvinceId},'
        '"county": "${countyController.text}",'
        '"city": "${cityController.text}",'
        '"address1": "${address1Controller.text}",'
        '"address2": "${address2Controller.text}",'
        '"zipPostalCode": "${zipCodeController.text}",'
        '"phoneNumber": "${phoneNumberController.text}",'
        '"faxNumber": "${faxNumberController.text}",'
        '"CustomAddressAttributes":$customerAttributesSelected'
        '}';

    Response response;
    if(formType == FormType.Edit)
    {
      response = await AddressService().putAddress(context: context, param: '/${addressModel.id}', body: body);
    }else{
      response=await AddressService().addAddress(context: context, body: body);
    }
    if(response.statusCode==200){
      isAPILoader = false;
      notifyListeners();
      Navigator.pop(context);
    }else if(response.statusCode==400){
      InvalidResponseModel errors = invalidResponseModelFromJson(response.body);
      FlushBarMessage().failedMessage(context: context, title: errors.errors.join("\n"));
      isAPILoader=false;
    }
    notifyListeners();
  }
}