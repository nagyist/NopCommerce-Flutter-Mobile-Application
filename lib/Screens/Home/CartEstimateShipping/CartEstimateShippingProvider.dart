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
import 'package:nopcommerce/Models/CountryStateModel.dart';
import 'package:nopcommerce/Models/InvalidResponseModel.dart';
import 'package:nopcommerce/Models/StateModel.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Screens/Home/Models/ShoppingCartModel/EstimateShippingResponseModel.dart';
import 'package:nopcommerce/Screens/Products/ProductEstimateShipping/Models/ProductEstimateShippingChangeRequestModel.dart';
import 'package:nopcommerce/Screens/Products/ProductEstimateShipping/Models/ProductEstimateShippingModel.dart';
import 'package:nopcommerce/Screens/Products/ProductEstimateShipping/Models/ProductEstimateShippingRequestModel.dart';
import 'package:nopcommerce/Services/CommonService.dart';
import 'package:nopcommerce/Services/ShoppingCartService.dart';
import 'package:nopcommerce/Widgets/DropdownWidget/DropdownModel.dart';

class CartEstimateShippingProvider extends ChangeNotifier {

  bool isPageLoader = true;
  bool isAPILoader = false;
  bool isEstimateShippingOption = true;
  List<DropDownModel> countryDropDownList=[];
  List<DropDownModel> stateDropDownList=[];
  bool estimateShipping= false;
  TextEditingController zipPostalCodeController=new TextEditingController();
  TextEditingController cityController=new TextEditingController();
  late ProductEstimateShippingRequestModel productEstimateShippingRequestModel;
  late ProductEstimateShippingChangeRequestModel productEstimateShippingChangeRequestModel;

  List<StateModel> stateModelList=[];
  late EstimateShippingResponseModel estimateShippingResponseModel;
  late ProductEstimateShippingModel productEstimateShippingModel;

  pageLoadData({required BuildContext context,required EstimateShippingResponseModel estimateShippingResponseModel,required ProductEstimateShippingChangeRequestModel productEstimateShippingChangeRequestModel}) async
  {
    isPageLoader=true;
    this.estimateShippingResponseModel = estimateShippingResponseModel;
    this.productEstimateShippingChangeRequestModel = productEstimateShippingChangeRequestModel;
    notifyListeners();

    initMethode(context: context);
  }

  initMethode({required BuildContext context})async{

    if(await CheckConnectivity().checkInternet(context)){
      countryDropDownList.clear();
      for(var item in estimateShippingResponseModel.availableCountries)
      {
        countryDropDownList.add(new DropDownModel(text: item.text, value: item.value));
      }

      stateDropDownList.clear();
      for(var item in estimateShippingResponseModel.availableStates)
      {
        stateDropDownList.add(new DropDownModel(text: item.text, value: item.value));
      }

      if(estimateShippingResponseModel.countryId == null || estimateShippingResponseModel.countryId == "")
      {
        List<CountryStateModel> countries = estimateShippingResponseModel.availableCountries.where((element) => element.selected).toList();
        if(countries.isNotEmpty)
        {
          estimateShippingResponseModel.countryId = int.parse(countries[0].value);
        }else{
          estimateShippingResponseModel.countryId = int.parse(estimateShippingResponseModel.availableCountries[0].value);
        }
      }

      if(estimateShippingResponseModel.stateProvinceId == null || estimateShippingResponseModel.stateProvinceId == ''){

        List<CountryStateModel> states = estimateShippingResponseModel.availableStates.where((element) => element.selected).toList();
        if(states.isNotEmpty)
        {
          estimateShippingResponseModel.stateProvinceId = int.parse(states[0].value);
        }else{
          estimateShippingResponseModel.stateProvinceId = int.parse(estimateShippingResponseModel.availableStates[0].value);
        }

      }

      estimateShippingResponseModel.city = estimateShippingResponseModel.city == null ? "" : estimateShippingResponseModel.city;
      estimateShippingResponseModel.zipPostalCode = estimateShippingResponseModel.zipPostalCode == null ? "" : estimateShippingResponseModel.zipPostalCode;

      getPreLoadStatesByCountryId(context: context,countryId: estimateShippingResponseModel.countryId);

    }
  }

  getPreLoadStatesByCountryId({required BuildContext context, required int countryId})async
  {
    Response response = await CommonService().getStateData(context: context,countryId: countryId);
    if(response.statusCode == 200)
    {
      stateDropDownList.clear();
      stateModelList = stateModelFromJson(response.body);
      for(var item in stateModelList)
      {
        stateDropDownList.add(new DropDownModel(text: item.name, value: item.id.toString()));
      }

      if(estimateShippingResponseModel.stateProvinceId == null)
      {
        estimateShippingResponseModel.stateProvinceId = 0;
      }

      estimateShippingResponseModel.stateProvinceId = stateModelList.where((element) => element.id.toString() == estimateShippingResponseModel.stateProvinceId.toString()).first.id;

      isAPILoader = false;
      notifyListeners();

      productEstimateShippingData(context: context);
    }
  }

  getStatesByCountryId({required BuildContext context, required int countryId})async
  {
    Response response = await CommonService().getStateData(context: context,countryId: countryId);

    if(response.statusCode == 200)
    {
      stateDropDownList.clear();
      stateModelList = stateModelFromJson(response.body);
      for(var item in stateModelList)
      {
        stateDropDownList.add(new DropDownModel(text: item.name, value: item.id.toString()));
      }

      estimateShippingResponseModel.stateProvinceId = stateModelList[0].id;

      isAPILoader = false;
      notifyListeners();
    }
  }

  productEstimateShippingData({required BuildContext context}) async {
    isAPILoader = true;
    notifyListeners();

    if(estimateShippingResponseModel.useCity)
    {
      if(estimateShippingResponseModel.city != null)
      {
        cityController.text = estimateShippingResponseModel.city;
      }
    }else{
      if(estimateShippingResponseModel.zipPostalCode != null)
      {
        zipPostalCodeController.text = estimateShippingResponseModel.zipPostalCode;
      }
    }
    productEstimateShippingRequestModel = ProductEstimateShippingRequestModel(productId: 0,zipPostalCode: zipPostalCodeController.text.toString(),city: cityController.text.toString(),stateId: estimateShippingResponseModel.stateProvinceId,countyId: estimateShippingResponseModel.countryId,attributes: {});
    isAPILoader = false;
    //isPageLoader = false;
    notifyListeners();

    if(estimateShippingResponseModel.countryId != 0)
    {
      getEstimateShippingData(context: context);
    }else{
      isEstimateShippingOption = false;
      isPageLoader = false;
      notifyListeners();
    }

  }

  getEstimateShippingData({required BuildContext context}) async{

    isAPILoader= true;
    notifyListeners();

    final body='{'
        '"zipPostalCode": "${productEstimateShippingRequestModel.zipPostalCode}",'
        '"city": "${productEstimateShippingRequestModel.city}",'
        '"countryId": ${productEstimateShippingRequestModel.countyId},'
        '"stateProvinceId": ${productEstimateShippingRequestModel.stateId},'
        '"attributes": ${productEstimateShippingRequestModel.attributes}'
        '}';

    Response response = await ShoppingCartService().postProductEstimateShipping(context: context, body: body);
    if(response.statusCode == 200)
    {
      productEstimateShippingModel= productEstimateShippingModelFromJson(response.body);

      for(var item in productEstimateShippingModel.shippingOptions)
      {
        item.selected = false;
        notifyListeners();
      }

      List<ShippingOption> shippingOptions = productEstimateShippingModel.shippingOptions.where((element) => element.name == productEstimateShippingChangeRequestModel.name).toList();
      if(shippingOptions.isNotEmpty)
      {
        shippingOptions[0].selected = true;
        notifyListeners();
      }

      isAPILoader= false;
      isPageLoader= false;
      isEstimateShippingOption= true;
      notifyListeners();

    }else if(response.statusCode == 400){
      InvalidResponseModel invalidResponseModel = invalidResponseModelFromJson(response.body);
      FlushBarMessage().failedMessage(context: context, title: invalidResponseModel.errors.join("\n"));
      isAPILoader = false;
      notifyListeners();
    }
  }

  countryDropdownChange({required BuildContext context,required String value})
  {
    isAPILoader=true;
    estimateShippingResponseModel.countryId = int.parse(value);
    notifyListeners();

    onChangeEvent(context: context);

    getStatesByCountryId(context: context,countryId: estimateShippingResponseModel.countryId);
  }

  stateDropdownChange({required BuildContext context,required String value})
  {
    isAPILoader=true;
    estimateShippingResponseModel.stateProvinceId = int.parse(value);
    notifyListeners();

    onChangeEvent(context: context);
  }

  onChangeEvent({required BuildContext context})
  {
    if(estimateShippingResponseModel.countryId == 0)
    {
      isAPILoader=false;
      FlushBarMessage().failedMessage(context: context, title: LocalResourceProvider().getResourseByKey("shipping.estimateshipping.country.required"));
      isEstimateShippingOption= false;
      notifyListeners();
    }else{
      isAPILoader = true;
      notifyListeners();

      if(estimateShippingResponseModel.useCity && cityController.text.isEmpty){
        FlushBarMessage().failedMessage(context: context, title: LocalResourceProvider().getResourseByKey("shipping.estimateshipping.city.required"));
        isAPILoader = false;
        isEstimateShippingOption= false;
        notifyListeners();
      }else if(!estimateShippingResponseModel.useCity && zipPostalCodeController.text.isEmpty){
        FlushBarMessage().failedMessage(context: context, title: LocalResourceProvider().getResourseByKey("shipping.estimateshipping.zippostalcode.required"));
        isAPILoader = false;
        isEstimateShippingOption= false;
        notifyListeners();
      }else{
        productEstimateShippingRequestModel = ProductEstimateShippingRequestModel(productId: 0,zipPostalCode: zipPostalCodeController.text, city: cityController.text,countyId: estimateShippingResponseModel.countryId,stateId: estimateShippingResponseModel.stateProvinceId,attributes: {});
        notifyListeners();

        getEstimateShippingData(context: context);
      }
    }
  }

  estimateItemUpdate({required BuildContext context, required ShippingOption shippingOption})
  {

    for(var item in productEstimateShippingModel.shippingOptions)
    {
      item.selected = false;
      notifyListeners();
    }

    shippingOption.selected = true;
    notifyListeners();

  }

  applyEstimateShipping({required BuildContext context})
  {
    String countryName = "";
    String stateName = "";
    List<CountryStateModel> availableCountries = estimateShippingResponseModel.availableCountries.where((element) => element.value == estimateShippingResponseModel.countryId.toString()).toList();
    if(availableCountries.isNotEmpty)
    {
      countryName = availableCountries[0].text;
    }
    List<CountryStateModel> availableStates = estimateShippingResponseModel.availableStates.where((element) => element.value == estimateShippingResponseModel.stateProvinceId.toString()).toList();
    if(availableStates.isNotEmpty)
    {
      stateName = availableStates[0].text;
    }

    ProductEstimateShippingChangeRequestModel requestModel = new ProductEstimateShippingChangeRequestModel(productId: 0, zipPostalCode: zipPostalCodeController.text.toString(), city: cityController.text.toString(), countryId: estimateShippingResponseModel.countryId, stateId: estimateShippingResponseModel.stateProvinceId, name: productEstimateShippingModel.shippingOptions.where((element) => element.selected).first.name ,date: productEstimateShippingModel.shippingOptions.where((element) => element.selected).first.deliveryDateFormat ,price: productEstimateShippingModel.shippingOptions.where((element) => element.selected).first.price,stateName: stateName,countryName: countryName);
    notifyListeners();
    Navigator.pop(context, requestModel);

  }
}