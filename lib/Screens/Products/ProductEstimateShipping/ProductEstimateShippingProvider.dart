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
import 'package:nopcommerce/Models/HeaderInfoResponseModel.dart';
import 'package:nopcommerce/Models/InvalidResponseModel.dart';
import 'package:nopcommerce/Models/StateModel.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Screens/Products/ProductDetails/Model/GetProductDetailsModel.dart';
import 'package:nopcommerce/Services/CommonService.dart';
import 'package:nopcommerce/Services/ProductServices.dart';
import 'package:nopcommerce/Widgets/DropdownWidget/DropdownModel.dart';
import 'Models/ProductEstimateShippingChangeRequestModel.dart';
import 'Models/ProductEstimateShippingModel.dart';
import 'Models/ProductEstimateShippingRequestModel.dart';

class ProductEstimateShippingProvider extends ChangeNotifier {

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
  String countryId="";
  String stateProvinceId="";
  List<StateModel> stateModelList=[];
  late GetProductDetailsModel getProductDetailsModel;
  late ProductEstimateShippingModel productEstimateShippingModel;

  pageLoadData({required BuildContext context,required GetProductDetailsModel getProductDetailsModel,required ProductEstimateShippingChangeRequestModel productEstimateShippingChangeRequestModel}) async
  {
    isPageLoader=true;
    this.getProductDetailsModel = getProductDetailsModel;
    this.productEstimateShippingChangeRequestModel = productEstimateShippingChangeRequestModel;
    notifyListeners();

    initMethode(context: context);
  }

  initMethode({required BuildContext context})async{

    if(await CheckConnectivity().checkInternet(context)){
      countryDropDownList.clear();
      for(var item in getProductDetailsModel.productEstimateShipping.availableCountries)
      {
        countryDropDownList.add(new DropDownModel(text: item.text, value: item.value));
      }
      countryId = getProductDetailsModel.productEstimateShipping.countryId;
      getPreLoadStatesByCountryId(context: context,countryId: int.parse(countryId));

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

      stateProvinceId = getProductDetailsModel.productEstimateShipping.stateProvinceId;
      if(stateProvinceId == null)
      {
        stateProvinceId = "0";
      }

      stateProvinceId = stateModelList.where((element) => element.id.toString() == getProductDetailsModel.productEstimateShipping.stateProvinceId).first.id.toString();

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

      stateProvinceId = stateModelList[0].id.toString();

      isAPILoader = false;
      notifyListeners();
    }
  }

  productEstimateShippingData({required BuildContext context}) async {
    isAPILoader = true;
    notifyListeners();

    if(getProductDetailsModel.productEstimateShipping.useCity)
    {
      if(getProductDetailsModel.productEstimateShipping.city != null)
      {
        cityController.text = getProductDetailsModel.productEstimateShipping.city;
      }
    }else{
      if(getProductDetailsModel.productEstimateShipping.zipPostalCode != null)
      {
        zipPostalCodeController.text = getProductDetailsModel.productEstimateShipping.zipPostalCode;
      }
    }
    productEstimateShippingRequestModel = ProductEstimateShippingRequestModel(productId: getProductDetailsModel.id,zipPostalCode: zipPostalCodeController.text.toString(),city: cityController.text.toString(),stateId: int.parse(stateProvinceId),countyId: int.parse(countryId),attributes: {});
    isAPILoader = false;
    //isPageLoader = false;
    notifyListeners();

    if(int.parse(countryId) != 0)
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

    Response response = await ProductService().postProductEstimateShipping(context: context, params: "/${getProductDetailsModel.id}", body: body);
    if(response.statusCode == 200)
    {
      productEstimateShippingModel= productEstimateShippingModelFromJson(response.body);

      for(var item in productEstimateShippingModel.shippingOptions)
      {
        item.selected = false;
        notifyListeners();
      }

      productEstimateShippingModel.shippingOptions.where((element) => element.name == productEstimateShippingChangeRequestModel.name).first.selected = true;
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
    countryId = value;
    notifyListeners();

    onChangeEvent(context: context);

    getStatesByCountryId(context: context,countryId: int.parse(countryId));
  }

  stateDropdownChange({required BuildContext context,required String value})
  {
    isAPILoader=true;
    stateProvinceId = value;
    notifyListeners();

    onChangeEvent(context: context);
  }

  onChangeEvent({required BuildContext context})
  {
    if(countryId == "0")
    {
      isAPILoader=false;
      FlushBarMessage().failedMessage(context: context, title: LocalResourceProvider().getResourseByKey("shipping.estimateshipping.country.required"));
      isEstimateShippingOption= false;
      notifyListeners();
    }else{
      isAPILoader = true;
      notifyListeners();

      if(getProductDetailsModel.productEstimateShipping.useCity && cityController.text.isEmpty){
        FlushBarMessage().failedMessage(context: context, title: LocalResourceProvider().getResourseByKey("shipping.estimateshipping.city.required"));
        isAPILoader = false;
        isEstimateShippingOption= false;
        notifyListeners();
      }else if(!getProductDetailsModel.productEstimateShipping.useCity && zipPostalCodeController.text.isEmpty){
        FlushBarMessage().failedMessage(context: context, title: LocalResourceProvider().getResourseByKey("shipping.estimateshipping.zippostalcode.required"));
        isAPILoader = false;
        isEstimateShippingOption= false;
        notifyListeners();
      }else{
        productEstimateShippingRequestModel = ProductEstimateShippingRequestModel(productId: getProductDetailsModel.id,zipPostalCode: zipPostalCodeController.text, city: cityController.text,countyId: int.parse(countryId),stateId: int.parse(stateProvinceId),attributes: {});
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
    if(countryId == "0")
    {
      isAPILoader=false;
      FlushBarMessage().failedMessage(context: context, title: LocalResourceProvider().getResourseByKey("shipping.estimateshipping.country.required"));
      isEstimateShippingOption= false;
      notifyListeners();
    }else{
      isAPILoader = true;
      notifyListeners();

      if(getProductDetailsModel.productEstimateShipping.useCity && cityController.text.isEmpty){
        FlushBarMessage().failedMessage(context: context, title: LocalResourceProvider().getResourseByKey("shipping.estimateshipping.city.required"));
        isAPILoader = false;
        isEstimateShippingOption= false;
        notifyListeners();
      }else if(!getProductDetailsModel.productEstimateShipping.useCity && zipPostalCodeController.text.isEmpty){
        FlushBarMessage().failedMessage(context: context, title: LocalResourceProvider().getResourseByKey("shipping.estimateshipping.zippostalcode.required"));
        isAPILoader = false;
        isEstimateShippingOption= false;
        notifyListeners();
      }else{
        if(getProductDetailsModel.productEstimateShipping.useCity)
        {
          if(getProductDetailsModel.productEstimateShipping.city != null)
          {
            getProductDetailsModel.productEstimateShipping.city = cityController.text.toString();
          }
        }else{
          if(getProductDetailsModel.productEstimateShipping.zipPostalCode != null)
          {
            getProductDetailsModel.productEstimateShipping.zipPostalCode = zipPostalCodeController.text;
          }
        }
        ProductEstimateShippingChangeRequestModel requestModel = new ProductEstimateShippingChangeRequestModel(productId: getProductDetailsModel.id, zipPostalCode: zipPostalCodeController.text.toString(), city: cityController.text.toString(), countryId: int.parse(countryId), stateId: int.parse(stateProvinceId), name: productEstimateShippingModel.shippingOptions.where((element) => element.selected).first.name ,date: productEstimateShippingModel.shippingOptions.where((element) => element.selected).first.deliveryDateFormat ,price: productEstimateShippingModel.shippingOptions.where((element) => element.selected).first.price,stateName: stateDropDownList.where((element) => element.value == stateProvinceId).first.text,countryName: getProductDetailsModel.productEstimateShipping.availableCountries.where((element) => element.value == countryId).first.text);
        notifyListeners();
        Navigator.pop(context, requestModel);
      }
    }

  }
}