/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nopcommerce/Models/GetCatalogRootModel.dart';
import 'package:nopcommerce/Screens/Products/ProductTag/Model/GetPopularProductTagsModel.dart';
import 'package:nopcommerce/Models/HeaderInfoResponseModel.dart';
import 'package:nopcommerce/Screens/Catalog/SearchProducts/Model/SearchProductsModel.dart';
import 'package:nopcommerce/Services/CommonService.dart';
import 'package:nopcommerce/Services/ProductByCategoryService.dart';
import 'package:nopcommerce/Services/ProductServices.dart';
import 'package:nopcommerce/Utils/CacheDatabase.dart';
import 'package:nopcommerce/Utils/Strings.dart';
import 'package:nopcommerce/Utils/hide_keyboard.dart';
import 'package:nopcommerce/Widgets/DialogBoxWidget.dart';
import 'Model/SearchProductRequestModel.dart';
import 'package:nopcommerce/Models/CustomProperties.dart';

class SearchProductsProvider extends ChangeNotifier {
  bool isPageLoader = true;
  bool isAPILoader = false;
  bool isAppBarSearch = false;
  String searchTerms = "";

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
  late GetPopularProductTagsModel getPopularProductTagsModel;
  List<GetCatalogRootModel> getCatalogRootModel = [];
  late SearchProductRequestModel searchProductRequestModel;
  late SearchProductModel searchProductModel;
  int minPrice = 0;
  int maxPrice = 1000000;
  int orderBy = 0;
  int pageNumber = 0;
  int pageSize = 0;
  int cId = 0;
  int mId = 0;
  int vId = 0;
  bool isc = false;
  bool sId = false;
  bool advs = false;
  RangeValues currentRangeValues =  RangeValues(0, 1000);
  int selectedAttribute = 0;

  pageLoadData({required BuildContext context, required String searchTerms, required bool isAppBarSearch}) async
  {
    isPageLoader = true;
    isAPILoader = false;
    this.searchTerms = searchTerms;
    this.isAppBarSearch = isAppBarSearch;
    currentRangeValues =  RangeValues(minPrice.toDouble(), maxPrice.toDouble());
    notifyListeners();
    getPopularProductTags(context: context);
  }

  getPopularProductTags({required BuildContext context}) async
  {
    Response response = await ProductService().popularProductTags(context: context);
    storage.setItem(StringConstants.CACHE_POPULAR_TAGS, response.body);
    if(response.statusCode == 200)
    {
      getPopularProductTagsModel = getPopularProductTagsModelFromJson(response.body);
    }

    notifyListeners();
    getCategories(context: context);
  }

  getCategories({required BuildContext context}) async
  {
    Response response = await ProductByCategoryService().catalogRoot(context: context);
    storage.setItem(StringConstants.CACHE_POPULAR_TAGS, response.body);
    if(response.statusCode == 200)
    {
      getCatalogRootModel = getCatalogRootModelFromJson(response.body);
    }
    notifyListeners();

    searchProductRequestModel = new SearchProductRequestModel(searchTerms: searchTerms, minPrice: minPrice, maxPrice: maxPrice, orderBy: orderBy, pageNumber: pageNumber, pageSize: pageSize, cId: cId, mId: mId, vId: vId, isc: isc, advs: advs, sId: sId,isAppBarSearch: isAppBarSearch);

    searchProducts(context: context, searchProductRequestModel: searchProductRequestModel);
  }

  searchProducts({required BuildContext context,required SearchProductRequestModel searchProductRequestModel}) async
  {
    String params = "";

    if(!searchProductRequestModel.isAppBarSearch)
    {
      params = "?Price=${searchProductRequestModel.minPrice}-${searchProductRequestModel.maxPrice}&"
          "OrderBy=${searchProductRequestModel.orderBy}&"
          "PageNumber=${searchProductRequestModel.pageNumber}&"
          "PageSize=${searchProductRequestModel.pageSize}&"
          "cid=${searchProductRequestModel.cId}"
          "&mid=${searchProductRequestModel.mId}"
          "&vid=${searchProductRequestModel.vId}"
          "&isc=${searchProductRequestModel.isc}"
          "&sid=${searchProductRequestModel.sId}"
          "&advs=${searchProductRequestModel.advs}";
    }else{
      params = "?q=${searchProductRequestModel.searchTerms}"
          "&Price=${searchProductRequestModel.minPrice}-${searchProductRequestModel.maxPrice}&"
          "OrderBy=${searchProductRequestModel.orderBy}&"
          "PageNumber=${searchProductRequestModel.pageNumber}&"
          "PageSize=${searchProductRequestModel.pageSize}&"
          "cid=${searchProductRequestModel.cId}"
          "&mid=${searchProductRequestModel.mId}"
          "&vid=${searchProductRequestModel.vId}"
          "&isc=${searchProductRequestModel.isc}"
          "&sid=${searchProductRequestModel.sId}"
          "&advs=${searchProductRequestModel.advs}";
    }
    Response response = await ProductService().searchProducts(context: context,params: params);
    if(response.statusCode == 200)
    {
      searchProductModel = searchProductModelFromJson(response.body);
      if(searchProductModel.catalogProductsModel.priceRangeFilter.enabled)
      {
        currentRangeValues =  RangeValues(searchProductModel.catalogProductsModel.priceRangeFilter.selectedPriceRange.from, searchProductModel.catalogProductsModel.priceRangeFilter.selectedPriceRange.to);
      }

      if(searchProductModel.catalogProductsModel.priceRangeFilter.enabled)
      {
        selectedAttribute = 0;
      }else if(searchProductModel.catalogProductsModel.specificationFilter.enabled){
        selectedAttribute = 1;
      }else if(searchProductModel.catalogProductsModel.manufacturerFilter.enabled){
        selectedAttribute = 2;
      }else{
        selectedAttribute = 3;
      }
      notifyListeners();
    }
    isAPILoader = false;
    getHeaderData(context: context);
    notifyListeners();
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
    isPageLoader = false;
    isAPILoader = false;
    notifyListeners();
  }

  searchButtonClick({required BuildContext context, required String searchTerms}) async
  {
    KeyboardUtil.hideKeyboard(context);

    isAPILoader = true;
    notifyListeners();

    searchProductRequestModel = new SearchProductRequestModel(searchTerms: searchTerms, minPrice: currentRangeValues.start.toInt(), maxPrice: currentRangeValues.end.toInt(), orderBy: searchProductModel.catalogProductsModel.orderBy, pageNumber: searchProductModel.catalogProductsModel.pageNumber, pageSize: searchProductModel.catalogProductsModel.pageSize, cId: searchProductModel.cid, mId: searchProductModel.mid, vId: searchProductModel.vid, isc: searchProductModel.isc, advs: searchProductModel.advs, sId: searchProductModel.sid,isAppBarSearch: true);

    await searchProducts(context: context, searchProductRequestModel: searchProductRequestModel);

  }

  clearAttributes({required BuildContext context})
  {
    isAPILoader= true;
    notifyListeners();

    if(searchProductModel.catalogProductsModel.priceRangeFilter.enabled)
    {
      currentRangeValues =  RangeValues(searchProductModel.catalogProductsModel.priceRangeFilter.availablePriceRange.from, searchProductModel.catalogProductsModel.priceRangeFilter.availablePriceRange.to);
    }

    searchProductRequestModel = new SearchProductRequestModel(searchTerms: searchProductModel.q, minPrice: currentRangeValues.start.toInt(), maxPrice: currentRangeValues.end.toInt(), orderBy: searchProductModel.catalogProductsModel.orderBy, pageNumber: searchProductModel.catalogProductsModel.pageNumber, pageSize: searchProductModel.catalogProductsModel.pageSize, cId: searchProductModel.cid, mId: searchProductModel.mid, vId: searchProductModel.vid, isc: searchProductModel.isc, advs: searchProductModel.advs, sId: searchProductModel.sid,isAppBarSearch: true);

    searchProducts(context: context, searchProductRequestModel: searchProductRequestModel);
  }
}