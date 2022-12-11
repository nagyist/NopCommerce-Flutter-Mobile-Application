/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nopcommerce/Screens/Customer/Order/OrderDetails/Model/GetOrderDetailsModel.dart';
import 'package:nopcommerce/Models/HeaderInfoResponseModel.dart';
import 'package:nopcommerce/Services/CommonService.dart';
import 'package:nopcommerce/Services/OrderServices.dart';
import 'package:nopcommerce/Widgets/DialogBoxWidget.dart';
import 'package:nopcommerce/Models/CustomProperties.dart';

class OrderConfirmPageProvider extends ChangeNotifier {

  bool isPageLoader = true;
  bool isAPILoader = false;
  int orderId=0;
  late GetOrderDetailsModel getOrderDetailsModel;
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

  pageLoadData({required BuildContext context, required int orderId})
  {
    isPageLoader = true;
    isAPILoader = false;
    this.orderId = orderId;
    getOrderDetails(context: context);
    notifyListeners();

  }

  getOrderDetails({required BuildContext context}) async
  {
    Response response = await OrderServices().getOrderDetail(context: context, param: "/$orderId");
    if(response.statusCode == 200)
    {
      getOrderDetailsModel = getOrderDetailsModelFromJson(response.body);
    }

    getHeaderData(context: context);
    notifyListeners();
  }

  getHeaderData({required BuildContext context}) async {

    Response response = await CommonService().getHeaderData(context: context);
    if(response.statusCode == 200)
    {
      headerModel = headerInfoResponseModelFromJson(response.body);

      if(headerModel.alertMessage != "")
      {
        DialogBoxWidget().confirmationDialogBox(context: context, title: "Notification", content: headerModel.alertMessage, cancelText: "Cancel", submitText: "Ok", isCancelable: true, onSubmit: (){});
      }
    }
    isPageLoader = false;
    isAPILoader=false;
    notifyListeners();
  }


}