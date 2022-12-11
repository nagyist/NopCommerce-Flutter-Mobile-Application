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
import 'package:nopcommerce/Screens/Products/EmailProduct/Models/GetProductEmailAFriendResponseModel.dart';
import 'package:nopcommerce/Utils/CacheDatabase.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Services/CommonService.dart';
import 'package:nopcommerce/Services/ProductServices.dart';
import 'package:nopcommerce/Utils/Strings.dart';
import 'package:nopcommerce/Widgets/DialogBoxWidget.dart';
import 'package:nopcommerce/Models/CustomProperties.dart';

class EmailProductProvider extends ChangeNotifier {

  bool isPageLoader = true;
  bool isAPILoader = false;
  int productID = 0;
  late GetProductEmailAFriendResponseModel getProductEmailAFriendResponseModel;
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

  TextEditingController friendEmailController = new TextEditingController();
  TextEditingController yourEmailController = new TextEditingController();
  TextEditingController messageController = new TextEditingController();

  pageLoadData({required BuildContext context, required int productID}) async
  {
    isPageLoader = true;
    isAPILoader = false;
    this.productID=productID;
    yourEmailController.clear();
    friendEmailController.clear();
    messageController.clear();

    notifyListeners();
    getEmailProduct(context: context);
  }

  getEmailProduct({required BuildContext context}) async
  {
    Response response = await ProductService().getEmailProduct(context: context,params: "/$productID");
    if(response.statusCode == 200)
    {
      getProductEmailAFriendResponseModel = getProductEmailAFriendResponseModelFromJson(response.body);
      isAPILoader=false;
      if(getProductEmailAFriendResponseModel.friendEmail != null)
      {
        friendEmailController.text = getProductEmailAFriendResponseModel.friendEmail;
      }

      if(getProductEmailAFriendResponseModel.yourEmailAddress != null)
      {
        yourEmailController.text = getProductEmailAFriendResponseModel.yourEmailAddress;
      }

      if(getProductEmailAFriendResponseModel.personalMessage != null)
      {
        messageController.text = getProductEmailAFriendResponseModel.personalMessage;
      }
      notifyListeners();
      getHeaderData(context: context);
    }
  }
  getHeaderData({required BuildContext context})async {
    Response response = await CommonService().getHeaderData(context: context);
    if(response.statusCode == 200)
    {
      storage.setItem(StringConstants.CACHE_HEADER, response.body);
      headerModel = headerInfoResponseModelFromJson(response.body);
      isPageLoader = false;
      if(headerModel.alertMessage != "")
      {
        DialogBoxWidget().confirmationDialogBox(context: context, title: LocalResourceProvider().getResourseByKey("common.notification"), content: headerModel.alertMessage, cancelText: "Cancel", submitText: "Ok", isCancelable: true, onSubmit: (){});
      }
      notifyListeners();
    }else{
      isPageLoader = false;
      storage.setItem(StringConstants.CACHE_HEADER, null);
      notifyListeners();
    }
    notifyListeners();
  }
  submitOnClickEvent({required BuildContext context})async
  {
     isAPILoader=true;
     notifyListeners();
     var body = '{'
         '"yourEmailAddress": "${yourEmailController.text.toString()}",'
         '"friendEmail": "${friendEmailController.text.toString()}",'
         '"personalMessage": "${messageController.text.toString()}'
         '"}';

      Response response = await ProductService().postProductEmailAFriend(context: context,params: "/$productID",body: body);

      if(response.statusCode == 200){
        isAPILoader=false;
        yourEmailController.clear();
        friendEmailController.clear();
        messageController.clear();
        notifyListeners();
        Navigator.pop(context);
        FlushBarMessage().successMessage(context: context, title: response.body.toString().replaceAll('"',""));

      }else if( response.statusCode == 400)
      {
        isAPILoader=false;
        notifyListeners();
        InvalidResponseModel invalidResponseModel =invalidResponseModelFromJson(response.body);
        FlushBarMessage().failedMessage(context: context, title: invalidResponseModel.errors.join("\n"));
      }

  }
}