/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nopcommerce/Models/CustomProperties.dart';
import 'package:nopcommerce/Models/HeaderInfoResponseModel.dart';
import 'package:nopcommerce/Models/ProductBoxModel.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Screens/Products/NewProducts/Model/NewProductResponseModel.dart';
import 'package:nopcommerce/Services/CommonService.dart';
import 'package:nopcommerce/Services/ProductServices.dart';
import 'package:nopcommerce/Utils/CacheDatabase.dart';
import 'package:nopcommerce/Utils/Strings.dart';
import 'package:nopcommerce/Widgets/DialogBoxWidget.dart';

class NewProductsProvider extends ChangeNotifier {
  bool isPageLoader = true;
  bool isAPILoader = false;
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
  List<ProductBoxModel> newProductList = [];

  pageLoadData({required BuildContext context}) async
  {
    getNewProducts(context: context);
  }

  loadCacheData({required BuildContext context}) async
  {
    isPageLoader = true;
    isAPILoader = false;

    await getCacheNewsProducts();
    await getCacheHeader(context: context);
  }

  getCacheNewsProducts() async {
    await storage.ready;
    String res = storage.getItem(StringConstants.CACHE_NEW_PRODUCTS);
    if(res != null)
    {
      newProductList = newProductResponseModelFromJson(res);
      return newProductList;
    }
    else{
      return null;
    }
  }

  getCacheHeader({required BuildContext context}) async {
    await storage.ready;
    String res = storage.getItem(StringConstants.CACHE_HEADER);
    if(res != null)
    {
      headerModel = headerInfoResponseModelFromJson(res);
      isPageLoader = false;
      if(headerModel.alertMessage != "")
      {
        DialogBoxWidget().confirmationDialogBox(context: context, title: LocalResourceProvider().getResourseByKey("common.notification"), content: headerModel.alertMessage, cancelText: "Cancel", submitText: "Ok", isCancelable: true, onSubmit: (){});
      }
      notifyListeners();
      return headerModel;
    }else{
      return null;
    }
  }

  getNewProducts({required BuildContext context}) async
  {
    Response response = await ProductService().getNewProducts(context: context);
    storage.setItem(StringConstants.CACHE_NEW_PRODUCTS,response.body);
    if(response.statusCode == 200)
    {
      newProductList = newProductResponseModelFromJson(response.body);
      notifyListeners();
    }
    getHeaderData(context: context);
  }

  getHeaderData({required BuildContext context})async {
    Response response = await CommonService().getHeaderData(context: context);
    storage.setItem(StringConstants.CACHE_HEADER, response.body);
    if(response.statusCode == 200)
    {
      headerModel = headerInfoResponseModelFromJson(response.body);
      isPageLoader = false;
      if(headerModel.alertMessage != "")
      {
        DialogBoxWidget().confirmationDialogBox(context: context, title: LocalResourceProvider().getResourseByKey("common.notification"), content: headerModel.alertMessage, cancelText: "Cancel", submitText: "Ok", isCancelable: true, onSubmit: (){});
      }
      notifyListeners();
    }
    isAPILoader = false;
    isPageLoader = false;
    notifyListeners();
  }
}