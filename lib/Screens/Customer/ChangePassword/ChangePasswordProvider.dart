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
import 'package:nopcommerce/Services/ChangePasswordService.dart';
import 'package:nopcommerce/Services/CommonService.dart';
import 'package:nopcommerce/Utils/CacheDatabase.dart';
import 'package:nopcommerce/Utils/Strings.dart';
import 'package:nopcommerce/Widgets/DialogBoxWidget.dart';
import 'package:nopcommerce/Models/CustomProperties.dart';

class ChangePasswordProvider extends ChangeNotifier {

  bool isAPILoader = false;
  bool isPageLoader = true;
  List<String> errors = [];
  TextEditingController passwordController=new TextEditingController();
  TextEditingController newPasswordController=new TextEditingController();
  TextEditingController confirmPassController=new TextEditingController();
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
    isPageLoader = false;
    notifyListeners();
  }

  updateButtonClickEvent({required BuildContext context})async
  {
    errors.clear();
    isAPILoader=true;
    notifyListeners();
    final body='{ '
      '"oldPassword": "${passwordController.text}",'
      '"newPassword": "${newPasswordController.text}",'
      '"confirmNewPassword": "${confirmPassController.text}"'
      '}';
    Response response = await ChangePasswordService().userChangePassword(context: context, body: body);
     if(response.statusCode==200){
        if(response.body.isNotEmpty){
          passwordController.clear();
          newPasswordController.clear();
          confirmPassController.clear();
          Navigator.pop(context);
          FlushBarMessage().successMessage(context: context, title: response.body.replaceAll('"', ""));
        }
        isAPILoader=false;
        notifyListeners();
      }
      else if(response.statusCode == 400) {
        InvalidResponseModel errors = invalidResponseModelFromJson(response.body);
        for(var er in errors.errors)
        {
          addError(error: er);
          notifyListeners();
        }
      }
      isPageLoader=false;
      isAPILoader=false;
      notifyListeners();
  }

  void addError({required String error}) {
    if (!errors.contains(error))
    {
      errors.add(error);
      notifyListeners();
    }
  }

  loadCacheData({required BuildContext context})async{
    errors.clear();
    isAPILoader = false;
    isPageLoader = true;
    passwordController.text="";
    newPasswordController.text="";
    confirmPassController.text="";
    await getCacheHeader(context: context);
    isPageLoader = false;
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

