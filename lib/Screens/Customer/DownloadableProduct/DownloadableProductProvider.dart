/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nopcommerce/Common/FlushbarMessage.dart';
import 'package:nopcommerce/Common/FileConfig.dart';
import 'package:nopcommerce/Models/HeaderInfoResponseModel.dart';
import 'package:nopcommerce/Models/InvalidResponseModel.dart';
import 'package:nopcommerce/Screens/Customer/DownloadableProduct/Models/GetDownloadableProductModel.dart';
import 'package:nopcommerce/Screens/Customer/DownloadableProduct/UserAgreement/UserAgreement.dart';
import 'package:nopcommerce/Services/CommonService.dart';
import 'package:nopcommerce/Services/DownloadableProductService.dart';
import 'package:nopcommerce/Utils/CacheDatabase.dart';
import 'package:nopcommerce/Utils/Enum/PageTransitionType.dart';
import 'package:nopcommerce/Utils/Strings.dart';
import 'package:nopcommerce/Widgets/DialogBoxWidget.dart';
import 'package:nopcommerce/Widgets/PageTransition/page_transition.dart';
import 'package:nopcommerce/Models/CustomProperties.dart';

class DownloadableProductProvider extends ChangeNotifier {

  bool isPageLoader = false;
  bool isAPILoader=false;
  Map<int,bool> expandRow={};
  late GetDownloadableProductModel getDownloadableProductModel;
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

  pageLoadData({required BuildContext context}) async
  {
    getDownloadableProductData(context: context);
    notifyListeners();
  }

  getDownloadableProductData({required BuildContext context}) async{
    Response response = await  DownloadableProductService().getDownloadableProduct(context: context);
    if(response.statusCode==200){
      storage.setItem(StringConstants.CACHE_DOWNLOAD_PRODUCTS_LIST, response.body);
      getDownloadableProductModel=getDownloadableProductModelFromJson(response.body);
    }else if(response.statusCode==400){
      InvalidResponseModel errors = invalidResponseModelFromJson(response.body);
      FlushBarMessage().failedMessage(context: context, title: errors.errors.join("\n"));
      isAPILoader=false;
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
      }else{
        storage.setItem(StringConstants.CACHE_HEADER, null);
      }
    }
    isPageLoader=false;
    isAPILoader=false;
    notifyListeners();
  }

  getDownloadableProductDetailsData({required BuildContext context,required String orderGuid,required bool isAgree}) async{
    bool permissionGranted = await FileConfig().permissionCheck(context: context, messageType: StringConstants.STORAGE_PERMISSION_MESSAGE);
    if(permissionGranted)
    {
      isAPILoader=true;
      notifyListeners();
      Response response = await  DownloadableProductService().getDownloadableProductDetails(context: context, param: '/$orderGuid', param1: '?agree=$isAgree');

      if(response.statusCode==200){
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
          isAPILoader=false;
          notifyListeners();
        }
      }
    }
    notifyListeners();
  }

  getOrderItemLicenseData({required BuildContext context,required String orderGuid}) async{

    bool permissionGranted = await FileConfig().permissionCheck(context: context, messageType: StringConstants.STORAGE_PERMISSION_MESSAGE);
    if(permissionGranted)
    {
      isAPILoader=true;
      notifyListeners();

      Response response = await DownloadableProductService().getOrderItemLicense(context: context, param:'/$orderGuid');
      if(response.statusCode==200){

        String base64 = base64Encode(response.bodyBytes);
        var fileType =response.headers["content-disposition"].toString().split(";");
        var separateName = fileType[1].split("=");
        var fileName = separateName[1].split(".");

        FileConfig().saveFile(context: context, base64: base64, fileName: fileName[0], fileType: fileName[1]);
        isAPILoader=false;
      }
    }

    notifyListeners();
  }

  loadCacheData({required BuildContext context}) async
  {
    isPageLoader = true;
    isAPILoader=false;

    await getCacheDownloadableProductData(context: context);
    await getCacheHeader(context: context);
  }

  getCacheDownloadableProductData({required BuildContext context}) async {
    await storage.ready;
    String res = storage.getItem(StringConstants.CACHE_DOWNLOAD_PRODUCTS_LIST);
    if(res != null)
    {
      getDownloadableProductModel = getDownloadableProductModelFromJson(res);
      isPageLoader = false;
      notifyListeners();
      return getDownloadableProductModel;
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