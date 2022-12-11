/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nopcommerce/Common/CheckInternet.dart';
import 'package:nopcommerce/Common/FlushbarMessage.dart';
import 'package:nopcommerce/Models/AllowedQuantityModel.dart';
import 'package:nopcommerce/Models/CountryStateModel.dart';
import 'package:nopcommerce/Screens/Products/CompareProduct/Models/CompareProductModel.dart';
import 'package:nopcommerce/Screens/Products/ProductEstimateShipping/Models/ProductEstimateShippingChangeRequestModel.dart';
import 'package:nopcommerce/Screens/Products/ProductEstimateShipping/Models/ProductEstimateShippingModel.dart';
import 'package:nopcommerce/Utils/Enum/AddToCartType.dart';
import 'package:nopcommerce/Utils/Enum/CustomerAttributes.dart';
import 'package:nopcommerce/Common/FileConfig.dart';
import 'package:nopcommerce/Models/CommonProductResponseModel.dart';
import 'package:nopcommerce/Models/HeaderInfoResponseModel.dart';
import 'package:nopcommerce/Models/InvalidResponseModel.dart';
import 'package:nopcommerce/Models/TaxTypeModel.dart';
import 'package:nopcommerce/Models/UploadFileModel.dart';
import 'package:nopcommerce/Screens/Products/ProductReview/Models/GetProductReviewsModel.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Screens/Products/ProductDetails/Model/ProductDetailsAttributeChangeModel.dart';
import 'package:nopcommerce/Models/ProductBoxModel.dart';
import 'package:nopcommerce/Utils/CacheDatabase.dart';
import 'package:nopcommerce/Services/CommonService.dart';
import 'package:nopcommerce/Services/ProductDetailService.dart';
import 'package:nopcommerce/Services/ShoppingCartService.dart';
import 'package:nopcommerce/Services/WishlistService.dart';
import 'package:nopcommerce/Utils/SQFliteDatabase.dart';
import 'package:nopcommerce/Utils/Strings.dart';
import 'package:nopcommerce/Widgets/DialogBoxWidget.dart';
import 'package:nopcommerce/Widgets/DropdownWidget/DropdownModel.dart';
import 'Model/GetProductDetailsModel.dart';
import 'Model/GetSubscribesModel.dart';
import 'package:nopcommerce/Models/CustomProperties.dart';

class ProductDetailsProvider extends ChangeNotifier {

  bool isPageLoader = true;
  bool isHeaderLoader = true;
  bool isProductReviewLoader = true;
  bool isRelatedProductsLoader = true;
  bool isAlsoPurchaseProductsLoader = true;
  int productId=0;
  int updateId=0;
  bool isCart=false;
  late GetProductDetailsModel getProductDetailsModel;
  late GetProductReviewsModel getProductReviewsModel;
  List<ProductBoxModel> getProductsAlsoPurchasedModel=[];
  List<ProductBoxModel> getRelatedProductsModel=[];
  int estimateCountry=0;
  String estimateCountryName="";
  int estimateState=0;
  String estimateStateName='';
  late TaxTypeModel taxTypeModel;
  String selectedTax="";
  Map<int, ProductEstimateShippingChangeRequestModel> associatePreEstimateShipping= {};
  bool isEstimateLoad = false;
  Map<int,ProductEstimateShippingModel> productEstimateShippingModelMap={};
  Map<String,String> productChangedAttributes={};
  Map<int,ProductDetailsAttributeChangeModel> associateProductDetailsAttributeChangeModel={};
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
  List<DropDownModel> countryList=[];

  late Directory downloadsDirectory;
  int indexImg=0;
  int selectId=0;
  int startSelectedDay=0;
  int startSelectedMonth=0;
  int startSelectedYear=0;
  int endSelectedDay=0;
  int endSelectedMonth=0;
  int endSelectedYear=0;
  Map<int, TextEditingController> datePickerMap = {};
  late GetSubscribesModel getSubscribesModel;
  String max='';
  bool answer=false;
  Map<int, String> fileUploadMap = {};
  UploadFileModel uploadFileModel = new UploadFileModel(success: false, uploadedFileGuid: "", message: "");
  bool isDownloaded=false;
  bool isAPILoader=false;
  Map<int,ProductEstimateShippingChangeRequestModel> estimateShippingMap = {};


  pageLoadData({required BuildContext context, required int productId, required int updateId, required bool isCart}) async
  {

    isHeaderLoader = true;
    isEstimateLoad = false;
    isProductReviewLoader = true;
    isRelatedProductsLoader = true;
    isAlsoPurchaseProductsLoader = true;
    this.productId=0;
    this.updateId=0;
    this.isCart=false;
    getProductsAlsoPurchasedModel.clear();
    getRelatedProductsModel.clear();
    estimateCountry=0;
    estimateCountryName="";
    estimateState=0;
    estimateStateName='';
    selectedTax="";
    associatePreEstimateShipping= {};
    productChangedAttributes={};
    indexImg=0;
    selectId=0;
    startSelectedDay=0;
    startSelectedMonth=0;
    startSelectedYear=0;
    endSelectedDay=0;
    endSelectedMonth=0;
    endSelectedYear=0;
    datePickerMap = {};
    max='';
    answer=false;
    fileUploadMap = {};
    uploadFileModel = new UploadFileModel(success: false, uploadedFileGuid: "", message: "");
    isDownloaded=false;
    estimateShippingMap = {};

    isPageLoader=true;
    this.productId = productId;
    this.updateId = updateId;
    notifyListeners();

    if(updateId!=0){
      this.isCart=isCart;
    }
    getProductDetails(context: context);
  }

  getProductDetails({required BuildContext context}) async
  {
    Response response = await ProductDetailsService().getProductDetails(context: context, params: "/$productId?updatecartitemid=$updateId");
    if(response.statusCode == 200)
    {
      storage.setItem(StringConstants.CACHE_PRODUCT_DETAILS, response.body);
      getProductDetailsModel = getProductDetailsModelFromJson(response.body);
      if(getProductDetailsModel.productEstimateShipping.enabled)
      {

        if(getProductDetailsModel.productEstimateShipping.countryId == null || getProductDetailsModel.productEstimateShipping.countryId == "")
        {
          List<CountryStateModel> countries = getProductDetailsModel.productEstimateShipping.availableCountries.where((element) => element.selected).toList();
          if(countries.isNotEmpty)
          {
            getProductDetailsModel.productEstimateShipping.countryId = countries[0].value;
          }else{
            getProductDetailsModel.productEstimateShipping.countryId = getProductDetailsModel.productEstimateShipping.availableCountries[0].value;
          }
        }

        if(getProductDetailsModel.productEstimateShipping.stateProvinceId == null || getProductDetailsModel.productEstimateShipping.stateProvinceId == ''){

          List<CountryStateModel> states = getProductDetailsModel.productEstimateShipping.availableStates.where((element) => element.selected).toList();
          if(states.isNotEmpty)
          {
            getProductDetailsModel.productEstimateShipping.stateProvinceId = states[0].value;
          }else{
            getProductDetailsModel.productEstimateShipping.stateProvinceId = getProductDetailsModel.productEstimateShipping.availableStates[0].value;
          }

        }

        getProductDetailsModel.productEstimateShipping.city = getProductDetailsModel.productEstimateShipping.city == null ? "" : getProductDetailsModel.productEstimateShipping.city;
        getProductDetailsModel.productEstimateShipping.zipPostalCode = getProductDetailsModel.productEstimateShipping.zipPostalCode == null ? "" : getProductDetailsModel.productEstimateShipping.zipPostalCode;

      }

      if(getProductDetailsModel.addToCart.allowedQuantities.isNotEmpty){
        for(var i in getProductDetailsModel.addToCart.allowedQuantities){
          if(getProductDetailsModel.addToCart.enteredQuantity==null){
            if(i.selected){
              getProductDetailsModel.addToCart.enteredQuantity=int.parse(i.value);
            }
          }

        }
        List<AllowedQuantity> checkList=getProductDetailsModel.addToCart.allowedQuantities.where((element) => int.parse(element.value)==getProductDetailsModel.addToCart.enteredQuantity).toList();
        if(checkList.isNotEmpty){
          getProductDetailsModel.addToCart.enteredQuantity=int.parse(checkList[0].value);
        }else{
          getProductDetailsModel.addToCart.enteredQuantity=int.parse(getProductDetailsModel.addToCart.allowedQuantities[0].value);
        }
      }
      if(getProductDetailsModel.addToCart.customerEntersPrice)
      {
        getProductDetailsModel.addToCart.customerEnteredPrice = getProductDetailsModel.addToCart.customerEnteredPrice.ceil().toDouble();
      }

      notifyListeners();
    }

    getProductReview(context: context);
  }


  getTaxData({required BuildContext context})async{
    Response response = await CommonService().getTaxType(context: context);
    if(response.statusCode == 200)
    {
      storage.setItem(StringConstants.CACHE_TAX_TYPE, response.body);
      taxTypeModel = taxTypeModelFromJson(response.body);
      selectedTax = taxTypeModel.currentTaxType;
      notifyListeners();
    }

    pageLoadAttributeOnChanged(context: context);
  }

  getProductReview({required BuildContext context}) async
  {
    Response response = await ProductDetailsService().getProductReview(context: context, params: "/$productId");

    if(response.statusCode == 200)
    {

      storage.setItem(StringConstants.CACHE_PRODUCT_DETAILS_REVIEW, response.body);
      getProductReviewsModel = getProductReviewsModelFromJson(response.body);

      isProductReviewLoader = false;
      notifyListeners();

      getProductsAlsoPurchase(context: context);
    }
  }

  getProductsAlsoPurchase({required BuildContext context}) async
  {
    Response response = await ProductDetailsService().getProductsAlsoPurchase(context: context, params: "/$productId");
    if(response.statusCode == 200)
    {
      storage.setItem(StringConstants.CACHE_PRODUCT_ALSO_PURCHASE, response.body);
      getProductsAlsoPurchasedModel = commonProductResponseModelFromJson(response.body);

      isAlsoPurchaseProductsLoader = false;
      notifyListeners();
    }
    getRelatedProducts(context: context);
  }

  getRelatedProducts({required BuildContext context}) async
  {
    Response response = await ProductDetailsService().getRelatedProducts(context: context, params: "/$productId");
    if(response.statusCode == 200)
    {
      storage.setItem(StringConstants.CACHE_RELATED_PRODUCTS, response.body);
      getRelatedProductsModel = commonProductResponseModelFromJson(response.body);

      isRelatedProductsLoader = false;
      notifyListeners();
    }

    if(getProductDetailsModel.productEstimateShipping.enabled)
    {
      if(getProductDetailsModel.associatedProducts.isNotEmpty)
      {
        for(var item in getProductDetailsModel.associatedProducts)
        {
          estimateShippingData(context: context,productId: item.id);
        }
      }else{
        estimateShippingData(context: context,productId: getProductDetailsModel.id);
      }
    }else{
      getTaxData(context: context);
    }
    notifyListeners();
  }

  estimateShippingData({required BuildContext context,required int productId}) async {

    List<CountryStateModel> availableCountries = getProductDetailsModel.productEstimateShipping.availableCountries.where((element) => element.selected).toList();
    if(availableCountries.isNotEmpty)
    {
      estimateCountry = int.parse(availableCountries[0].value);
      estimateCountryName = availableCountries[0].text;
    }else{
      estimateCountry = int.parse(getProductDetailsModel.productEstimateShipping.availableCountries[0].value);
      estimateCountryName = getProductDetailsModel.productEstimateShipping.availableCountries[0].text;
    }

    List<CountryStateModel> availableStates = getProductDetailsModel.productEstimateShipping.availableStates.where((element) => element.selected).toList();
    if(availableStates.isNotEmpty)
    {
      estimateState = int.parse(availableStates[0].value);
      estimateStateName=availableStates[0].text;
    }else{
      estimateState = int.parse(getProductDetailsModel.productEstimateShipping.availableStates[0].value);
      estimateStateName=getProductDetailsModel.productEstimateShipping.availableStates[0].text;
    }

    final body='{'
        '"zipPostalCode": "${getProductDetailsModel.productEstimateShipping.zipPostalCode == null ? "" : getProductDetailsModel.productEstimateShipping.zipPostalCode}",'
        '"city": "${getProductDetailsModel.productEstimateShipping.city == null ? "" :getProductDetailsModel.productEstimateShipping.city}",'
        '"countryId": $estimateCountry,'
        '"stateProvinceId": $estimateState,'
        '"attributes": {}'
        '}';

    Response response = await ProductDetailsService().postEstimateShipping(context: context, params: "/$productId", body: body);

    if(response.statusCode == 200)
    {
      productEstimateShippingModelMap[productId] = productEstimateShippingModelFromJson(response.body);
      notifyListeners();

        List<ShippingOption> shippingOptions = productEstimateShippingModelMap[productId]!.shippingOptions.where((element) => element.selected).toList();
        String name="";
        String price="";
        String date="";
        if(shippingOptions.isNotEmpty)
        {
          name = shippingOptions[0].name;
          date = shippingOptions[0].deliveryDateFormat;
          price = shippingOptions[0].price;
        }else{
          for(var i in productEstimateShippingModelMap[productId]!.shippingOptions){
            if(i.selected){
              name = i.name;
              date = i.deliveryDateFormat;
              price = i.price;
            }else{
              name = productEstimateShippingModelMap[productId]!.shippingOptions[0].name;
              date = productEstimateShippingModelMap[productId]!.shippingOptions[0].deliveryDateFormat;
              price = productEstimateShippingModelMap[productId]!.shippingOptions[0].price;
            }
          }
        }

      estimateShippingMap[productId] = ProductEstimateShippingChangeRequestModel(productId: productId, zipPostalCode: getProductDetailsModel.productEstimateShipping.zipPostalCode == null ? "" : getProductDetailsModel.productEstimateShipping.zipPostalCode, city: getProductDetailsModel.productEstimateShipping.city == null ? "" :getProductDetailsModel.productEstimateShipping.city, countryId: estimateCountry, stateId: estimateCountry, name: name, date: date, price: price, stateName: estimateStateName,countryName: estimateCountryName);
      isEstimateLoad = true;
      notifyListeners();
      pageLoadAttributeOnChanged(context: context);
    }
  }

  getHeaderData({required BuildContext context})async {
    Response response = await CommonService().getHeaderData(context: context);
    if(response.statusCode == 200)
    {
      storage.setItem(StringConstants.CACHE_HEADER, response.body);
      headerModel = headerInfoResponseModelFromJson(response.body);
      isHeaderLoader = false;
      isPageLoader = false;
      if(headerModel.alertMessage != "")
      {
        DialogBoxWidget().confirmationDialogBox(context: context, title: "Notification", content: headerModel.alertMessage, cancelText: "Cancel", submitText: "Ok", isCancelable: true, onSubmit: (){});
      }
      notifyListeners();
    }else{
      storage.setItem(StringConstants.CACHE_HEADER, null);
    }
    notifyListeners();
  }

  attributeComponentLoad({required BuildContext context})
  {

    if(getProductDetailsModel.giftCard.recipientName == null)
    {
      getProductDetailsModel.giftCard.recipientName = "";
    }

    if(getProductDetailsModel.giftCard.recipientEmail == null)
    {
      getProductDetailsModel.giftCard.recipientEmail="";
    }

    if(getProductDetailsModel.giftCard.senderName == null)
    {
      getProductDetailsModel.giftCard.senderName="";
    }

    if(getProductDetailsModel.giftCard.senderEmail == null)
    {
      getProductDetailsModel.giftCard.senderEmail="";
    }

    if(getProductDetailsModel.giftCard.message == null)
    {
      getProductDetailsModel.giftCard.message="";
    }
  }

  pageLoadAttributeOnChanged({required BuildContext context}) async{

    isAPILoader = true;
    notifyListeners();

    if(getProductDetailsModel.associatedProducts.isEmpty)
    {
      if(await CheckConnectivity().checkInternet(context)){

        for(var attr in getProductDetailsModel.productAttributes)
        {
          List<String> idList = [];
          if (attr.attributeControlType == AttributeControlType.Checkboxes || attr.attributeControlType == AttributeControlType.ReadonlyCheckboxes) {
            idList.clear();
            for (var j in attr.values) {
              if (j.isPreSelected) {
                idList.add('${j.id}');
              }
            }

            String checkBoxData = '"${idList.join(",")}"';
            productChangedAttributes['"product_attribute_${attr.id}"'] = checkBoxData;

            for(var item in attr.values.where((element) => element.customerEntersQty))
            {
              productChangedAttributes['"product_attribute_${attr.id}_${item.id}_qty"']  = '"${item.quantity}"';
            }

          } else {

            // attr.values.add(new AttributeValue(name: LocalResourceProvider().getResourseByKey("Products.ProductAttributes.DropdownList.DefaultItem"), colorSquaresRgb: "", imageSquaresPictureModel: PictureModel(imageUrl: "", thumbImageUrl: "", fullSizeImageUrl: "", title: "", alternateText: "", customProperties: CustomProperties()), priceAdjustment: "", priceAdjustmentUsePercentage: false, priceAdjustmentValue: 0, isPreSelected: false, pictureId: getProductDetailsModel.id, customerEntersQty: false, quantity: 0, id: 0, customProperties: CustomProperties()));
            // notifyListeners();

            if(attr.defaultValue == null || attr.defaultValue == ""){
              for(var i in attr.values){
                if(i.isPreSelected){
                  attr.defaultValue = i.id.toString();
                }
              }
            }

            if (attr.defaultValue != null) {

              idList.add('"${attr.defaultValue}"');
              productChangedAttributes['"product_attribute_${attr.id}"']  = '"${attr.defaultValue}"';
            } else {
              productChangedAttributes['"product_attribute_${attr.id}"']  = "''";
            }

            for(var item in attr.values.where((element) => element.customerEntersQty))
            {
              productChangedAttributes['"product_attribute_${attr.id}_${item.id}_qty"']  = '"${item.quantity}"';
            }
          }
        }
        if(getProductDetailsModel.isRental){
          productChangedAttributes['"rental_start_date_${getProductDetailsModel.id}"'] = '"${getProductDetailsModel.rentalStartDate}"';
          productChangedAttributes['"rental_end_date_${getProductDetailsModel.id}"'] = '"${getProductDetailsModel.rentalEndDate}"';
        }

        if(getProductDetailsModel.addToCart.customerEntersPrice){
          if(getProductDetailsModel.addToCart.customerEnteredPrice == null)
          {
            productChangedAttributes['"addtocart_${getProductDetailsModel.id}.CustomerEnteredPrice"'] = '"0"';
          }else{
            productChangedAttributes['"addtocart_${getProductDetailsModel.id}.CustomerEnteredPrice"'] = '"${getProductDetailsModel.addToCart.customerEnteredPrice}"';
          }

        }

        if(getProductDetailsModel.giftCard.isGiftCard){
          if(getProductDetailsModel.giftCard.recipientName==null)
          {
            productChangedAttributes['"giftcard_${getProductDetailsModel.id}.RecipientName"'] = '""';
          }else{
            productChangedAttributes['"giftcard_${getProductDetailsModel.id}.RecipientName"'] = '"${getProductDetailsModel.giftCard.recipientName}"';
          }

          if(getProductDetailsModel.giftCard.recipientEmail == null)
          {
            productChangedAttributes['"giftcard_${getProductDetailsModel.id}.RecipientEmail"'] = '""';
          }else{
            productChangedAttributes['"giftcard_${getProductDetailsModel.id}.RecipientEmail"'] = '"${getProductDetailsModel.giftCard.recipientEmail}"';
          }

          if(getProductDetailsModel.giftCard.senderName == null)
          {
            productChangedAttributes['"giftcard_${getProductDetailsModel.id}.SenderName"'] = '""';
          }else{
            productChangedAttributes['"giftcard_${getProductDetailsModel.id}.SenderName"'] = '"${getProductDetailsModel.giftCard.senderName}"';
          }

          if(getProductDetailsModel.giftCard.senderEmail == null)
          {
            productChangedAttributes['"giftcard_${getProductDetailsModel.id}.SenderEmail"'] = '""';
          }else{
            productChangedAttributes['"giftcard_${getProductDetailsModel.id}.SenderEmail"'] = '"${getProductDetailsModel.giftCard.senderEmail}"';
          }

          if(getProductDetailsModel.giftCard.message == null)
          {
            productChangedAttributes['"giftcard_${getProductDetailsModel.id}.Message"'] = '""';
          }else{
            productChangedAttributes['"giftcard_${getProductDetailsModel.id}.Message"'] = '"${getProductDetailsModel.giftCard.message}"';
          }

        }

        final body='{ '
            '"validateAttributeConditions": true,'
            '"loadPicture": true,'
            '"attributes":$productChangedAttributes'
            '}';


        Response response = await ProductDetailsService().postAttributeChange(context: context, params: "/$productId", body: body);
        if(response.statusCode == 200)
        {

          associateProductDetailsAttributeChangeModel[productId] = productDetailsAttributeChangeModelFromJson(response.body);
          if(productDetailsAttributeChangeModelFromJson(response.body).gtin != null && productDetailsAttributeChangeModelFromJson(response.body).gtin != "")
          {
            getProductDetailsModel.gtin = productDetailsAttributeChangeModelFromJson(response.body).gtin;
          }
          if(productDetailsAttributeChangeModelFromJson(response.body).sku != null && productDetailsAttributeChangeModelFromJson(response.body).sku != "")
          {
            getProductDetailsModel.sku = productDetailsAttributeChangeModelFromJson(response.body).sku;
          }
          if(productDetailsAttributeChangeModelFromJson(response.body).price != null && productDetailsAttributeChangeModelFromJson(response.body).price != "")
          {
            getProductDetailsModel.productPrice.price = productDetailsAttributeChangeModelFromJson(response.body).price;
          }
          if(productDetailsAttributeChangeModelFromJson(response.body).basepricepangv != null && productDetailsAttributeChangeModelFromJson(response.body).basepricepangv != "")
          {
            getProductDetailsModel.productPrice.basePricePAngV = productDetailsAttributeChangeModelFromJson(response.body).basepricepangv;
          }
          if(productDetailsAttributeChangeModelFromJson(response.body).stockAvailability != null && productDetailsAttributeChangeModelFromJson(response.body).stockAvailability != "")
          {
            getProductDetailsModel.stockAvailability = productDetailsAttributeChangeModelFromJson(response.body).stockAvailability;
          }
          if(productDetailsAttributeChangeModelFromJson(response.body).pictureDefaultSizeUrl != null && productDetailsAttributeChangeModelFromJson(response.body).pictureDefaultSizeUrl != "")
          {
            getProductDetailsModel.defaultPictureModel.imageUrl = productDetailsAttributeChangeModelFromJson(response.body).pictureDefaultSizeUrl;
          }
          if(productDetailsAttributeChangeModelFromJson(response.body).isFreeShipping != null && productDetailsAttributeChangeModelFromJson(response.body).isFreeShipping != "")
          {
            getProductDetailsModel.isFreeShipping = productDetailsAttributeChangeModelFromJson(response.body).isFreeShipping;
          }
        }
      }

      notifyListeners();

    }else{

      if(await CheckConnectivity().checkInternet(context)){
        {
          for(var product in getProductDetailsModel.associatedProducts){

            for(var attr in product.productAttributes)
            {
              List<String> idList = [];
              if (attr.attributeControlType == AttributeControlType.Checkboxes || attr.attributeControlType == AttributeControlType.ReadonlyCheckboxes) {
                idList.clear();

                for(var j in attr.values) {
                  if(j.isPreSelected) {
                    idList.add('${j.id}');
                  }
                }

                String checkBoxData='"${idList.join(",")}"';
                productChangedAttributes['"product_attribute_${attr.id}"'] = checkBoxData;

                for(var item in attr.values.where((element) => element.customerEntersQty))
                {
                  productChangedAttributes['"product_attribute_${attr.id}_${item.id}_qty"']  = '"${item.quantity}"';
                }

              } else {


                if(attr.defaultValue == null || attr.defaultValue == ""){
                  for(var i in attr.values){
                    if(i.isPreSelected){
                      attr.defaultValue = i.id.toString();
                    }
                  }
                }

                if (attr.defaultValue != null) {
                  idList.add('"${attr.defaultValue}"');
                  productChangedAttributes['"product_attribute_${attr.id}"']  = '"${attr.defaultValue}"';
                } else {
                  productChangedAttributes['"product_attribute_${attr.id}"']  = "''";
                }

                for(var item in attr.values.where((element) => element.customerEntersQty))
                {
                  productChangedAttributes['"product_attribute_${attr.id}_${item.id}_qty"']  = '"${item.quantity}"';
                }
              }
            }

            if(product.isRental){
              productChangedAttributes['"rental_start_date_${product.id}"'] = '"${product.rentalStartDate}"';
              productChangedAttributes['"rental_end_date_${product.id}"'] = '"${product.rentalEndDate}"';
            }

            if(product.addToCart.customerEntersPrice){

              productChangedAttributes['"addtocart_${product.id}.CustomerEnteredPrice"'] = '"${product.addToCart.customerEnteredPrice}"';

            }
            if(product.giftCard.isGiftCard){
              productChangedAttributes['"giftcard_${product.id}.RecipientName"'] = '"${product.giftCard.recipientName}"';
              productChangedAttributes['"giftcard_${product.id}.RecipientEmail"'] = '"${product.giftCard.recipientEmail}"';
              productChangedAttributes['"giftcard_${product.id}.SenderName"'] = '"${product.giftCard.senderName}"';
              productChangedAttributes['"giftcard_${product.id}.SenderEmail"'] = '"${product.giftCard.senderEmail}"';
              productChangedAttributes['"giftcard_${product.id}.Message"'] = '"${product.giftCard.message}"';
            }

            final body='{ '
                '"validateAttributeConditions": true,'
                '"loadPicture": true,'
                '"attributes":$productChangedAttributes'
                '}';

            Response response = await ProductDetailsService().postAttributeChange(context: context, params: "/${product.id}", body: body);
            if(response.statusCode == 200)
            {
              associateProductDetailsAttributeChangeModel[product.id] = productDetailsAttributeChangeModelFromJson(response.body);

              if(productDetailsAttributeChangeModelFromJson(response.body).gtin != null && productDetailsAttributeChangeModelFromJson(response.body).gtin != "")
              {
                product.gtin = productDetailsAttributeChangeModelFromJson(response.body).gtin;
              }
              if(productDetailsAttributeChangeModelFromJson(response.body).sku != null && productDetailsAttributeChangeModelFromJson(response.body).sku != "")
              {
                product.sku = productDetailsAttributeChangeModelFromJson(response.body).sku;
              }
              if(productDetailsAttributeChangeModelFromJson(response.body).price != null && productDetailsAttributeChangeModelFromJson(response.body).price != "")
              {
                product.productPrice.price = productDetailsAttributeChangeModelFromJson(response.body).price;
              }
              if(productDetailsAttributeChangeModelFromJson(response.body).basepricepangv != null && productDetailsAttributeChangeModelFromJson(response.body).basepricepangv != "")
              {
                product.productPrice.basePricePAngV = productDetailsAttributeChangeModelFromJson(response.body).basepricepangv;
              }
              if(productDetailsAttributeChangeModelFromJson(response.body).stockAvailability != null && productDetailsAttributeChangeModelFromJson(response.body).stockAvailability != "")
              {
                product.stockAvailability = productDetailsAttributeChangeModelFromJson(response.body).stockAvailability;
              }
              if(productDetailsAttributeChangeModelFromJson(response.body).pictureDefaultSizeUrl != null && productDetailsAttributeChangeModelFromJson(response.body).pictureDefaultSizeUrl != "")
              {
                product.defaultPictureModel.imageUrl = productDetailsAttributeChangeModelFromJson(response.body).pictureDefaultSizeUrl;
              }
              if(productDetailsAttributeChangeModelFromJson(response.body).isFreeShipping != null && productDetailsAttributeChangeModelFromJson(response.body).isFreeShipping != "")
              {
                product.isFreeShipping = productDetailsAttributeChangeModelFromJson(response.body).isFreeShipping;
              }

              notifyListeners();
            }
          }

        }
      }
    }

    isAPILoader = false;
    notifyListeners();
    getHeaderData(context: context);
  }

  attributeOnChanged({required BuildContext context,required String addToCartType,required GetProductDetailsModel getProductDetailsModel}) async{

    isAPILoader = true;
    notifyListeners();

    if(await CheckConnectivity().checkInternet(context)){

      productChangedAttributes={};
      for(var attr in getProductDetailsModel.productAttributes)
      {
        List<String> idList = [];
        if (attr.attributeControlType == AttributeControlType.Checkboxes || attr.attributeControlType == AttributeControlType.ReadonlyCheckboxes) {
          idList.clear();
          for (var j in attr.values) {
            if (j.isPreSelected) {
              idList.add('${j.id}');
            }
          }

          String checkBoxData = '"${idList.join(",")}"';
          productChangedAttributes['"product_attribute_${attr.id}"'] = checkBoxData;

          for(var item in attr.values.where((element) => element.customerEntersQty))
          {
            productChangedAttributes['"product_attribute_${attr.id}_${item.id}_qty"']  = '"${item.quantity}"';
          }

        } else {
          if (attr.defaultValue != null) {

            idList.add('"${attr.defaultValue}"');
            productChangedAttributes['"product_attribute_${attr.id}"']  = '"${attr.defaultValue}"';
          } else {
            productChangedAttributes['"product_attribute_${attr.id}"']  = "''";
          }

          for(var item in attr.values.where((element) => element.customerEntersQty))
          {
            productChangedAttributes['"product_attribute_${attr.id}_${item.id}_qty"']  = '"${item.quantity}"';
          }
        }
      }
      if(getProductDetailsModel.isRental){
        productChangedAttributes['"rental_start_date_${getProductDetailsModel.id}"'] = '"${getProductDetailsModel.rentalStartDate}"';
        productChangedAttributes['"rental_end_date_${getProductDetailsModel.id}"'] = '"${getProductDetailsModel.rentalEndDate}"';
      }

      if(getProductDetailsModel.addToCart.customerEntersPrice){
        if(getProductDetailsModel.addToCart.customerEnteredPrice == null)
        {
          productChangedAttributes['"addtocart_${getProductDetailsModel.id}.CustomerEnteredPrice"'] = '"0"';
        }else{
          productChangedAttributes['"addtocart_${getProductDetailsModel.id}.CustomerEnteredPrice"'] = '"${getProductDetailsModel.addToCart.customerEnteredPrice}"';
        }

      }

      if(getProductDetailsModel.giftCard.isGiftCard){
        if(getProductDetailsModel.giftCard.recipientName==null)
        {
          productChangedAttributes['"giftcard_${getProductDetailsModel.id}.RecipientName"'] = '""';
        }else{
          productChangedAttributes['"giftcard_${getProductDetailsModel.id}.RecipientName"'] = '"${getProductDetailsModel.giftCard.recipientName}"';
        }

        if(getProductDetailsModel.giftCard.recipientEmail == null)
        {
          productChangedAttributes['"giftcard_${getProductDetailsModel.id}.RecipientEmail"'] = '""';
        }else{
          productChangedAttributes['"giftcard_${getProductDetailsModel.id}.RecipientEmail"'] = '"${getProductDetailsModel.giftCard.recipientEmail}"';
        }

        if(getProductDetailsModel.giftCard.senderName == null)
        {
          productChangedAttributes['"giftcard_${getProductDetailsModel.id}.SenderName"'] = '""';
        }else{
          productChangedAttributes['"giftcard_${getProductDetailsModel.id}.SenderName"'] = '"${getProductDetailsModel.giftCard.senderName}"';
        }

        if(getProductDetailsModel.giftCard.senderEmail == null)
        {
          productChangedAttributes['"giftcard_${getProductDetailsModel.id}.SenderEmail"'] = '""';
        }else{
          productChangedAttributes['"giftcard_${getProductDetailsModel.id}.SenderEmail"'] = '"${getProductDetailsModel.giftCard.senderEmail}"';
        }

        if(getProductDetailsModel.giftCard.message == null)
        {
          productChangedAttributes['"giftcard_${getProductDetailsModel.id}.Message"'] = '""';
        }else{
          productChangedAttributes['"giftcard_${getProductDetailsModel.id}.Message"'] = '"${getProductDetailsModel.giftCard.message}"';
        }

      }

      final body='{ '
          '"validateAttributeConditions": true,'
          '"loadPicture": true,'
          '"attributes":$productChangedAttributes'
          '}';


      Response response = await ProductDetailsService().postAttributeChange(context: context, params: "/${getProductDetailsModel.id}", body: body);
      if(response.statusCode == 200)
      {
        associateProductDetailsAttributeChangeModel[getProductDetailsModel.id] = productDetailsAttributeChangeModelFromJson(response.body);
        getProductDetailsModel.gtin = productDetailsAttributeChangeModelFromJson(response.body).gtin;
        getProductDetailsModel.sku = productDetailsAttributeChangeModelFromJson(response.body).sku;
        getProductDetailsModel.productPrice.price = productDetailsAttributeChangeModelFromJson(response.body).price;
        getProductDetailsModel.productPrice.basePricePAngV = productDetailsAttributeChangeModelFromJson(response.body).basepricepangv;
        getProductDetailsModel.stockAvailability = productDetailsAttributeChangeModelFromJson(response.body).stockAvailability;
        getProductDetailsModel.defaultPictureModel.imageUrl = productDetailsAttributeChangeModelFromJson(response.body).pictureDefaultSizeUrl;
        getProductDetailsModel.isFreeShipping = productDetailsAttributeChangeModelFromJson(response.body).isFreeShipping;

        notifyListeners();
      }
    }

    if(addToCartType == AddToCartType.Cart)
    {
      final body='{'
          ' "quantity": ${getProductDetailsModel.addToCart.enteredQuantity},'
          ' "updateCartItemId": $updateId,'
          ' "attributes": $productChangedAttributes'
          '}';

      Response response = await ShoppingCartService().postProductDetailsAddToCart(context: context, params: "/${getProductDetailsModel.id}", body: body);

      if(response.statusCode == 200){
        FlushBarMessage().successMessage(context: context, title: LocalResourceProvider().getResourseByKey('products.productHasBeenAddedToTheCart'));
      }else if(response.statusCode == 400){
        InvalidResponseModel invalidResponseModel = invalidResponseModelFromJson(response.body);
        FlushBarMessage().failedMessage(context: context, title: invalidResponseModel.errors.join("\n"));
      }
    }else if(addToCartType == AddToCartType.Wishlist)
    {
      final body='{'
          ' "quantity": ${getProductDetailsModel.addToCart.enteredQuantity},'
          ' "updateCartItemId": $updateId,'
          ' "attributes": $productChangedAttributes'
          '}';

      Response response = await WishlistService().productDetailsAddToWishlist(context: context, params: "/${getProductDetailsModel.id}", body: body);
      if(response.statusCode == 200){
        getHeaderData(context: context);
        FlushBarMessage().successMessage(context: context, title: LocalResourceProvider().getResourseByKey('products.productHasBeenAddedToTheWishlist'));
      }else if(response.statusCode == 400){
        InvalidResponseModel invalidResponseModel = invalidResponseModelFromJson(response.body);
        FlushBarMessage().failedMessage(context: context, title: invalidResponseModel.errors.join("\n"));

      }
    }

    isAPILoader = false;
    notifyListeners();
    getHeaderData(context: context);
  }

  downloadSample({required BuildContext context,required int productId}) async
  {
    bool permissionGranted = await FileConfig().permissionCheck(context: context, messageType: StringConstants.STORAGE_PERMISSION_MESSAGE);
    if(permissionGranted)
    {
      isDownloaded=true;
      isAPILoader=true;
      notifyListeners();

      Response response = await ProductDetailsService().getDownloadProduct(context: context, params: "/$productId");
      if(response.statusCode == 200)
      {
        String base64 = base64Encode(response.bodyBytes);
        var fileType =response.headers["content-disposition"].toString().split(";");
        var separateName = fileType[1].split("=");
        var fileName = separateName[1].split(".");

        FileConfig().saveFile(context: context, base64: base64, fileName: fileName[0], fileType: fileName[1]);

      }
    }
    isDownloaded = false;
    isAPILoader = false;
    notifyListeners();
  }

  attributeUploadFile({required BuildContext context, required ProductAttribute productAttribute, required var base64, required String fileName}) async
  {
    isAPILoader = true;
    notifyListeners();

    final body = '{ '
        '"fileBase64String": "$base64",'
        '"fileName": "$fileName"'
        '}';

    Response response = await ProductDetailsService().postUploadFileAttributeChange(context: context,params: "/${productAttribute.id}",body: body);
    if(response.statusCode == 200)
    {
      uploadFileModel = uploadFileModelFromJson(response.body);
      if(uploadFileModel.success)
      {
        productAttribute.defaultValue = fileName;
        FlushBarMessage().successMessage(context: context, title: uploadFileModel.message);
      }else{
        FlushBarMessage().failedMessage(context: context, title: uploadFileModel.message);
      }
    }
    isAPILoader = false;
    notifyListeners();
  }

  backInStockClickEvent({required BuildContext context}) async
  {
    isAPILoader = true;
    notifyListeners();

    Response response = await ProductDetailsService().getBackInStockSubscribe(context: context, params: "/$productId");
    if(response.statusCode == 200)
    {
      getSubscribesModel = getSubscribesModelFromJson(response.body);
      max = LocalResourceProvider().getResourseByKey("backInStockSubscriptions.maxSubscriptions");
      max = max.replaceAll('{0}',getSubscribesModel.maximumBackInStockSubscriptions.toString());

    }

    isAPILoader = false;
    notifyListeners();
  }

  backInStockSubscribe({required BuildContext context}) async
  {
    isAPILoader = true;
    notifyListeners();

    Response response = await ProductDetailsService().postSubscription(context: context, params: "/$productId");
    if(response.statusCode == 200)
    {

    }

    isAPILoader = false;
    notifyListeners();
  }


  addToCompareOnClickEvent({required BuildContext context,required int productId}){

    SQFLiteDatabase().dbHelper.addCompareProduct(model: CompareProductResourseModel(productId: productId));
    FlushBarMessage().successMessage(context: context, title: LocalResourceProvider().getResourseByKey("products.producthasbeenaddedtocomparelist"));
  }

  updateEstimateData({required BuildContext context,required GetProductDetailsModel getProductDetailsModel,required ProductEstimateShippingChangeRequestModel requestModel})
  {
    getProductDetailsModel.productEstimateShipping.countryId=requestModel.countryId.toString();
    getProductDetailsModel.productEstimateShipping.zipPostalCode=requestModel.zipPostalCode;
    getProductDetailsModel.productEstimateShipping.city=requestModel.city;
    getProductDetailsModel.productEstimateShipping.stateProvinceId=requestModel.stateId.toString();
    estimateShippingMap[getProductDetailsModel.id] = ProductEstimateShippingChangeRequestModel(productId: productId, zipPostalCode: requestModel.zipPostalCode, city: requestModel.city, countryId: requestModel.countryId, stateId: requestModel.stateId, name: requestModel.name, date: requestModel.date, price: requestModel.price, stateName: requestModel.stateName,countryName: requestModel.countryName);
    notifyListeners();
  }


  ///CACHE DATA
  loadCacheData({required BuildContext context, required int productId, required int updateId, required bool isCart}) async
  {
    if(this.productId == productId)
    {
      isHeaderLoader = true;
      isProductReviewLoader = true;
      isRelatedProductsLoader = true;
      isAlsoPurchaseProductsLoader = true;
      this.productId=0;
      this.updateId=0;
      this.isCart=false;
      getProductsAlsoPurchasedModel.clear();
      getRelatedProductsModel.clear();
      estimateCountry=0;
      estimateCountryName="";
      estimateState=0;
      estimateStateName='';
      selectedTax="";
      associatePreEstimateShipping= {};
      productChangedAttributes={};
      indexImg=0;
      selectId=0;
      startSelectedDay=0;
      startSelectedMonth=0;
      startSelectedYear=0;
      endSelectedDay=0;
      endSelectedMonth=0;
      endSelectedYear=0;
      datePickerMap = {};
      max='';
      answer=false;
      fileUploadMap = {};
      uploadFileModel = new UploadFileModel(success: false, uploadedFileGuid: "", message: "");
      isDownloaded=false;
      estimateShippingMap = {};
      isPageLoader=true;
      this.productId = productId;
      this.updateId = updateId;
      notifyListeners();

      if(updateId!=0){
        this.isCart=isCart;
      }

      var products = await getCacheProductDetails(context: context);
      if(products != null)
      {
        if(getProductDetailsModel.id == productId)
        {
          await getCacheProductReview(context: context);
          await getCacheProductAlsoPurchase(context: context);
          await getCacheRelatedProducts(context: context);

          await pageLoadAttributeOnChanged(context: context);

          var cacheHeader = await getCacheHeader(context: context);

          if(cacheHeader != null)
          {
            if(headerModel.alertMessage != "")
            {
              DialogBoxWidget().confirmationDialogBox(context: context, title: "Notification", content: headerModel.alertMessage, cancelText: "Cancel", submitText: "Ok", isCancelable: true, onSubmit: (){});
            }
            isHeaderLoader = false;
            notifyListeners();
          }
        }
      }
    }
  }

  getCacheProductDetails({required BuildContext context}) async {
    await storage.ready;
    String res = storage.getItem(StringConstants.CACHE_PRODUCT_DETAILS);
    if(res != null)
    {
      getProductDetailsModel = getProductDetailsModelFromJson(res);
      notifyListeners();
      return getProductDetailsModel;
    }else{
      return null;
    }
  }

  getCacheRelatedProducts({required BuildContext context}) async {
    await storage.ready;
    String res = storage.getItem(StringConstants.CACHE_RELATED_PRODUCTS);
    if(res != null)
    {
      getRelatedProductsModel = commonProductResponseModelFromJson(res);
      if(getProductDetailsModel.productEstimateShipping.enabled)
      {
        if(getProductDetailsModel.associatedProducts.isNotEmpty)
        {
          for(var item in getProductDetailsModel.associatedProducts)
          {
            estimateShippingData(context: context,productId: item.id);
          }
        }else{
          estimateShippingData(context: context,productId: getProductDetailsModel.id);
        }
      }else{
        getTaxData(context: context);
      }
      notifyListeners();
      return getRelatedProductsModel;
    }else{
      return null;
    }
  }

  getCacheProductReview({required BuildContext context}) async {
    await storage.ready;
    String res = storage.getItem(StringConstants.CACHE_PRODUCT_DETAILS_REVIEW);
    if(res != null)
    {
      getProductReviewsModel = getProductReviewsModelFromJson(res);
      notifyListeners();
      return getProductReviewsModel;
    }else{
      return null;
    }
  }

  getCacheProductAlsoPurchase({required BuildContext context}) async {
    await storage.ready;
    String res = storage.getItem(StringConstants.CACHE_PRODUCT_ALSO_PURCHASE);
    if(res != null)
    {
      getProductsAlsoPurchasedModel = commonProductResponseModelFromJson(res);
      notifyListeners();
      return getProductsAlsoPurchasedModel;
    }else{
      return null;
    }
  }

  getCacheTaxType({required BuildContext context}) async {
    await storage.ready;
    String res = storage.getItem(StringConstants.CACHE_TAX_TYPE);
    if(res != null)
    {
      taxTypeModel = taxTypeModelFromJson(res);
      notifyListeners();
      return taxTypeModel;
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
      notifyListeners();
      return headerModel;
    }else{
      return null;
    }
  }
}