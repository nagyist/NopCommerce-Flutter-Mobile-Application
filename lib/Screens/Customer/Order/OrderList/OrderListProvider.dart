/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nopcommerce/Common/FlushbarMessage.dart';
import 'package:nopcommerce/Models/HeaderInfoResponseModel.dart';
import 'package:nopcommerce/Models/InvalidResponseModel.dart';
import 'package:nopcommerce/Screens/Customer/Order/OrderList/Model/CustomerOrderModel.dart';
import 'package:nopcommerce/Services/CommonService.dart';
import 'package:nopcommerce/Services/OrderServices.dart';
import 'package:nopcommerce/Utils/CacheDatabase.dart';
import 'package:nopcommerce/Utils/Strings.dart';
import 'package:nopcommerce/Widgets/DialogBoxWidget.dart';
import 'package:nopcommerce/Models/CustomProperties.dart';

class OrderListProvider extends ChangeNotifier {

  bool isPageLoader = false;
  bool isAPILoader = false;
  late CustomerOrdersModel customerOrderModel;
  String commentTitle="";
  String commentText="";
  ScrollController scrollController = ScrollController();
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

  pageLoadData({required BuildContext context})async{
    getCustomerOrderList(context: context);
    notifyListeners();
  }

  getCustomerOrderList({required BuildContext context})async{

    Response response = await OrderServices().getListOfOrderData(context: context);
    if(response.statusCode==200){
      storage.setItem(StringConstants.CACHE_ORDER_LIST, response.body);
      customerOrderModel= customerOrdersModelFromJson(response.body);
    }
    notifyListeners();
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

  cancelOnClickEvent({required BuildContext context,required int recurringPaymentId})async{

    isAPILoader=true;
    notifyListeners();
    Response response=await OrderServices().cancelRecurringPayment(context: context, param: '/$recurringPaymentId');
    if(response.statusCode==200){
      customerOrderModel=customerOrdersModelFromJson(response.body);
      await getCustomerOrderList(context: context);
      isAPILoader=false;
    }else if(response.statusCode==400){
      InvalidResponseModel errors = invalidResponseModelFromJson(response.body);
      FlushBarMessage().failedMessage(context: context, title: errors.errors.join("\n"));
      isAPILoader=false;
    }
    isAPILoader=false;
    notifyListeners();
  }

  retryLastRecurringPayment({required BuildContext context,required int recurringPaymentId,required String commentTitle,required String commentText})async{

    isAPILoader=true;
    notifyListeners();

    final body='{'
        '"CommentTitle": "$commentTitle",'
        '"CommentText": "$commentText",'
        '}';

    Response response=await OrderServices().retryLastRecurringPayment(context: context, param: '/$recurringPaymentId',body: body);
    if(response.statusCode==200){
      customerOrderModel=customerOrdersModelFromJson(response.body);
      await getCustomerOrderList(context: context);
      isAPILoader=false;
    }else if(response.statusCode==400){
      InvalidResponseModel errors = invalidResponseModelFromJson(response.body);
      FlushBarMessage().failedMessage(context: context, title: errors.errors.join("\n"));
      isAPILoader=false;
    }
    isAPILoader=false;
    notifyListeners();
  }

  loadCacheData({required BuildContext context})async{
    isPageLoader = true;
    isAPILoader = false;
    await getCacheCustomerOrderList(context: context);
    await getCacheHeader(context: context);

  }

  getCacheCustomerOrderList({required BuildContext context}) async {
    await storage.ready;
    String res = storage.getItem(StringConstants.CACHE_ORDER_LIST);
    if(res != null)
    {
      customerOrderModel = customerOrdersModelFromJson(res);
      isPageLoader = false;
      notifyListeners();
      return customerOrderModel;
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