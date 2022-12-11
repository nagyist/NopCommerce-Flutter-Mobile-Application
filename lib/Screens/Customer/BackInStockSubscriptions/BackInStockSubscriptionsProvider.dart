/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nopcommerce/Models/HeaderInfoResponseModel.dart';
import 'package:nopcommerce/Screens/Customer/BackInStockSubscriptions/Models/GetCustomerSubscriptionsResponseModel.dart';
import 'package:nopcommerce/Services/BackInStockSubscriptionService.dart';
import 'package:nopcommerce/Services/CommonService.dart';
import 'package:nopcommerce/Utils/CacheDatabase.dart';
import 'package:nopcommerce/Utils/Strings.dart';
import 'package:nopcommerce/Widgets/DialogBoxWidget.dart';
import 'package:nopcommerce/Models/CustomProperties.dart';

class BackInStockSubscriptionsProvider extends ChangeNotifier {

  bool isPageLoader=false;
  bool isAPILoader=false;
  bool isAll=false;
  Map<int,bool> productList={};
  List<int> removeList=[];
  late GetCustomerSubscriptionsResponseModel getCustomerSubscriptionsResponseModel;
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

  pageLoadData({required BuildContext context}){
    getSubscriptionsData(context: context);
    notifyListeners();
  }

  getSubscriptionsData({required BuildContext context})async{
    Response response=await BackInStockSubscriptionsService().getCustomerSubscriptions(context: context);
    if(response.statusCode==200){
      storage.setItem(StringConstants.CACHE_BACK_IN_STOCK, response.body);
      getCustomerSubscriptionsResponseModel=getCustomerSubscriptionsResponseModelFromJson(response.body);
    }
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
    isAPILoader=false;
    notifyListeners();
  }

  deleteButtonClickEvent({required BuildContext context,required List<int> removePid})async
  {
    var body =
        '{'
        '"subscriptionIds": $removePid,'
        '"prepareCustomerSubscriptions": true'
        '}';
    Response response=await BackInStockSubscriptionsService().removeProductSubscriptions(context: context, body: body);
    if(response.statusCode==200){
      getSubscriptionsData(context: context);
    }
  }

  loadCacheData({required BuildContext context})async{
    isPageLoader=true;
    isAPILoader=false;
    isAll=false;
    productList.clear();
    removeList.clear();

    await getCacheSubscriptionsData(context: context);
    await getCacheHeader(context: context);
  }

  getCacheSubscriptionsData({required BuildContext context}) async {
    await storage.ready;
    String res = storage.getItem(StringConstants.CACHE_BACK_IN_STOCK);
    if(res != null)
    {
      getCustomerSubscriptionsResponseModel = getCustomerSubscriptionsResponseModelFromJson(res);
      isPageLoader = false;
      notifyListeners();
      return getCustomerSubscriptionsResponseModel;
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