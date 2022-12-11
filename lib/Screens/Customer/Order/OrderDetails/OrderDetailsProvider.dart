/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nopcommerce/Common/FlushbarMessage.dart';
import 'package:nopcommerce/Common/FileConfig.dart';
import 'package:nopcommerce/Models/HeaderInfoResponseModel.dart';
import 'package:nopcommerce/Models/InvalidResponseModel.dart';
import 'package:nopcommerce/Screens/Checkout/CheckoutPaypalView/CheckoutPaypalView.dart';
import 'package:nopcommerce/Screens/Customer/Order/OrderDetails/Model/GetOrderDetailsModel.dart';
import 'package:nopcommerce/Screens/Customer/DownloadableProduct/UserAgreement/UserAgreement.dart';
import 'package:nopcommerce/Screens/Home/MainScreen.dart';
import 'package:nopcommerce/Services/CommonService.dart';
import 'package:nopcommerce/Services/DownloadableProductService.dart';
import 'package:nopcommerce/Services/OrderServices.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Customer/Order/OrderDetail/OrderPrintView.dart';
import 'package:nopcommerce/Utils/Enum/PageTransitionType.dart';
import 'package:nopcommerce/Utils/Strings.dart';
import 'package:nopcommerce/Widgets/DialogBoxWidget.dart';
import 'package:nopcommerce/Widgets/PageTransition/page_transition.dart';
import 'package:nopcommerce/Models/CustomProperties.dart';

class OrderDetailsProvider extends ChangeNotifier {

  bool isPageLoader = true;
  bool isAPILoader = false;
  bool isOpen = false;
  List<String> errors = [];
  late DateTime date;
  late Directory? downloadsDirectory;
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

  pageLoadData({required BuildContext context}){
    isPageLoader = true;
    isAPILoader = false;
    isOpen = false;
    errors.clear();
    notifyListeners();
  }

  getOrderDetailsData({required BuildContext context, required int orderId}) async {

     Response response = await OrderServices().getOrderDetail(context: context, param:'/$orderId');
     if (response.statusCode == 200) {
      getOrderDetailsModel = getOrderDetailsModelFromJson(response.body);
      date = getOrderDetailsModel.createdOn;
    } else if(response.statusCode==400){
       InvalidResponseModel errors = invalidResponseModelFromJson(response.body);
       FlushBarMessage().failedMessage(context: context, title: errors.errors.join("\n"));
       isAPILoader=false;
     }
    notifyListeners();
    getHeaderData(context: context);
  }

  getHeaderData({required BuildContext context}) async {
    Response response = await CommonService().getHeaderData(context: context);
    if (response.statusCode == 200) {
      headerModel = headerInfoResponseModelFromJson(response.body);
      isPageLoader = false;
      if (headerModel.alertMessage != "") {
        DialogBoxWidget().confirmationDialogBox(context: context,
            title: "Notification",
            content: headerModel.alertMessage,
            cancelText: "Cancel",
            submitText: "Ok",
            isCancelable: true,
            onSubmit: () {});
      }
    }
    isPageLoader = false;
    isAPILoader=false;
    notifyListeners();
  }

  printButtonClickEvent({required BuildContext context,required int orderId})async
  {
    bool permissionGranted = await FileConfig().permissionCheck(context: context, messageType: StringConstants.STORAGE_PERMISSION_MESSAGE);
    if(permissionGranted)
    {
      isAPILoader = true;
      notifyListeners();
      Response response = await OrderServices().getPdfInvoiceOrder(context: context, param: '/$orderId');
      if(response.statusCode==200){
        String base = base64Encode(response.bodyBytes);
        isAPILoader = false;
        Navigator.push(context, PageTransition(type: selectedTransition, child: OrderPrintView(base64: base,printName: 'Order${getOrderDetailsModel.id}_$dateTimeName.pdf',orderNo: "#Order${getOrderDetailsModel.id}",)));
      }else if(response.statusCode==400){
        InvalidResponseModel errors = invalidResponseModelFromJson(response.body);
        FlushBarMessage().failedMessage(context: context, title: errors.errors.join("\n"));
        isAPILoader=false;
      }
    }
    notifyListeners();
  }

  pdfInvoiceButtonClickEvent({required BuildContext context,required int orderId}) async
  {
    bool permissionGranted = await FileConfig().permissionCheck(context: context, messageType: StringConstants.STORAGE_PERMISSION_MESSAGE);
    if(permissionGranted)
    {
      isAPILoader = true;
      notifyListeners();
      Response response = await await OrderServices().getPdfInvoiceOrder(context: context, param: '/$orderId');
      if(response.statusCode==200){
        String base64 = base64Encode(response.bodyBytes);
        FileConfig().saveFile(context: context, base64: base64, fileName: 'Order${getOrderDetailsModel.id}', fileType: 'pdf');
        isAPILoader = false;
      }else if(response.statusCode==400){
        InvalidResponseModel errors = invalidResponseModelFromJson(response.body);
        FlushBarMessage().failedMessage(context: context, title: errors.errors.join("\n"));
        isAPILoader=false;
      }
      isAPILoader = false;
      notifyListeners();
    }
    isAPILoader = false;
    notifyListeners();

  }

  ///Billing Address
  retryOnClickEvent({required BuildContext context,required int orderId})async{
    Response response=await OrderServices().rePaymentOrder(context: context, param: '/$orderId' );
    if(response.statusCode==200){
      Navigator.push(context, PageTransition(type: selectedTransition, child: CheckoutPaypalView(redirectionUrl: response.body,orderId: orderId)));
    }else if(response.statusCode==400){
      InvalidResponseModel errors = invalidResponseModelFromJson(response.body);
      FlushBarMessage().failedMessage(context: context, title: errors.errors.join("\n"));
      isAPILoader=false;
    }
    notifyListeners();
  }

  downloadButtonClickEvent({required BuildContext context,required int orderNoteId})async
  {
    bool permissionGranted = await FileConfig().permissionCheck(context: context, messageType: StringConstants.STORAGE_PERMISSION_MESSAGE);
    if(permissionGranted)
    {
      isAPILoader=true;
      notifyListeners();
      Response response= await DownloadableProductService().getOrderNoteDownload(context: context, param: '/$orderNoteId');
      if(response.statusCode==200){
        String base64 = base64Encode(response.bodyBytes);
        var fileType =response.headers["content-disposition"].toString().split(";");
        var separateName = fileType[1].split("=");
        var fileName = separateName[1].split(".");

        FileConfig().saveFile(context: context, base64: base64, fileName: fileName[0], fileType: fileName[1]);
        isAPILoader=false;
      }else if(response.statusCode==400){
        InvalidResponseModel errors = invalidResponseModelFromJson(response.body);
        FlushBarMessage().failedMessage(context: context, title: errors.errors.join("\n"));
        isAPILoader=false;
      }
    }
    notifyListeners();
  }

  reOrderOnClickEvent({required BuildContext context,required int orderId})async{
    isAPILoader=true;
    notifyListeners();
    Response response=await OrderServices().setReOrder(context: context, param: '/$orderId');
    if(response.statusCode==200){
      Navigator.push(context, PageTransition(type: selectedTransition, child: MainScreen(tabIndex: 2)));
      isAPILoader=false;
    }else if(response.statusCode==400){
      InvalidResponseModel errors = invalidResponseModelFromJson(response.body);
      FlushBarMessage().failedMessage(context: context, title: errors.errors.join("\n"));
      isAPILoader=false;
    }
    isAPILoader=false;
    notifyListeners();
  }

  ///product detail
  downloadableProductData({required BuildContext context,required String orderGuid,required bool isAgree})async
  {
    isAPILoader=true;
    notifyListeners();
    Response response=await DownloadableProductService().getDownloadableProductDetails(context: context, param: '/$orderGuid', param1:'?agree=$isAgree');
    if (response.statusCode == 200) {

      var urlTag ="${response.headers["content-type"]}".split(";");
      if(urlTag.length > 1) {
        Navigator.push(context, PageTransition(type: selectedTransition, child: UserAgreement(orderGuid)));
        isAPILoader=false;
      }else{
        String base64 = base64Encode(response.bodyBytes);
        var fileType =response.headers["content-disposition"].toString().split(";");
        var separateName = fileType[1].split("=");
        var fileName = separateName[1].split(".");

        FileConfig().saveFile(context: context, base64: base64, fileName: fileName[0], fileType: fileName[1]);
      }
      isAPILoader=false;
    }
    getHeaderData(context: context);
    notifyListeners();
  }
}