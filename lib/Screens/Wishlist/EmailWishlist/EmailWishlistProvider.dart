/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nopcommerce/Common/FlushbarMessage.dart';
import 'package:nopcommerce/Models/CustomProperties.dart';
import 'package:nopcommerce/Models/HeaderInfoResponseModel.dart';
import 'package:nopcommerce/Models/InvalidResponseModel.dart';
import 'package:nopcommerce/Services/CommonService.dart';
import 'package:nopcommerce/Services/WishlistService.dart';
import 'package:nopcommerce/Utils/CacheDatabase.dart';
import 'package:nopcommerce/Utils/Strings.dart';
import 'package:nopcommerce/Widgets/DialogBoxWidget.dart';
import 'Model/GetEmailWishlistResponseModel.dart';

class EmailWishlistProvider extends ChangeNotifier {
  bool isPageLoader = true;
  bool isAPILoader = false;
  late GetEmailWishlistResponseModel getEmailWishlistResponseModel;
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
  String wishlistShareURL = "";
  TextEditingController friendEmailController = new TextEditingController();
  TextEditingController yourEmailController = new TextEditingController();
  TextEditingController messageController = new TextEditingController();

  pageLoadData({required BuildContext context}) async
  {
    isPageLoader = true;
    isAPILoader = false;
    notifyListeners();
    getEmailWishlistData(context: context);
  }

  getEmailWishlistData({required BuildContext context}) async
  {
    isAPILoader = true;
    notifyListeners();

    Response response = await WishlistService().getEmailWishlist(context: context);
    if(response.statusCode == 200)
    {
      getEmailWishlistResponseModel = getEmailWishlistResponseModelFromJson(response.body);
      if(getEmailWishlistResponseModel.friendEmail != null)
      {
        friendEmailController.text = getEmailWishlistResponseModel.friendEmail;
      }

      if(getEmailWishlistResponseModel.yourEmailAddress != null)
      {
        yourEmailController.text = getEmailWishlistResponseModel.yourEmailAddress;
      }

      if(getEmailWishlistResponseModel.personalMessage != null)
      {
        messageController.text = getEmailWishlistResponseModel.personalMessage;
      }
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
      if(headerModel.alertMessage != "")
      {
        DialogBoxWidget().confirmationDialogBox(context: context, title: "Notification", content: headerModel.alertMessage, cancelText: "Cancel", submitText: "Ok", isCancelable: true, onSubmit: (){});
      }
      notifyListeners();
    }
    isAPILoader = false;
    isPageLoader = false;
    notifyListeners();
  }

  shareEmailWishlist({required BuildContext context}) async
  {
    isAPILoader = true;
    notifyListeners();
    var body = '{'
          '"friendEmail": "${friendEmailController.text.toString()}",'
          ' "yourEmailAddress": "${yourEmailController.text.toString()}",'
          ' "personalMessage": "${messageController.text.toString()}'
      '"}';
    Response response = await WishlistService().shareEmailWishlist(context: context,body: body);
    if(response.statusCode == 200)
    {
      Navigator.pop(context);
      FlushBarMessage().successMessage(context: context, title: response.body.replaceAll('"', ""));
      friendEmailController.clear();
      yourEmailController.clear();
      messageController.clear();
      notifyListeners();
    }else if(response.statusCode == 400)
    {
      InvalidResponseModel invalidResponseModel = invalidResponseModelFromJson(response.body);
      FlushBarMessage().failedMessage(context: context, title: invalidResponseModel.errors.join('\n'));
    }
    isAPILoader = false;
    notifyListeners();
  }
}