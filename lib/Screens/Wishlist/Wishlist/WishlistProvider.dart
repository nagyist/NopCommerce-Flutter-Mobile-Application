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
import 'package:nopcommerce/Models/TaxTypeModel.dart';
import 'package:nopcommerce/Screens/Home/MainScreen.dart';
import 'package:nopcommerce/Services/CommonService.dart';
import 'package:nopcommerce/Services/WishlistService.dart';
import 'package:nopcommerce/Utils/CacheDatabase.dart';
import 'package:nopcommerce/Utils/Enum/PageTransitionType.dart';
import 'package:nopcommerce/Utils/Strings.dart';
import 'package:nopcommerce/Widgets/DialogBoxWidget.dart';
import 'package:nopcommerce/Widgets/PageTransition/page_transition.dart';
import 'package:nopcommerce/DataProvider/APIConstants.dart';
import 'package:share_plus/share_plus.dart';
import 'Model/WishlistModel.dart';
import 'package:nopcommerce/Models/CustomProperties.dart';

class WishlistProvider extends ChangeNotifier {

  bool isPageLoader = true;
  bool isAPILoader = false;
  late WishlistModel wishlistModel;
  late TaxTypeModel taxTypeModel;
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

  pageLoadData({required BuildContext context}) async
  {
    getWishlistData(context: context);
  }

  getWishlistData({required BuildContext context}) async
  {
    isAPILoader = true;
    notifyListeners();

    Response response = await WishlistService().getWishlist(context: context);
    storage.setItem(StringConstants.CACHE_WISHLIST, response.body);
    if(response.statusCode == 200)
    {
      wishlistModel = wishlistModelFromJson(response.body);
      wishlistShareURL = APIConstants.WISHLIST_SHARE_BASEURL + wishlistModel.customerGuid;
      notifyListeners();
    }
    getTaxData(context: context);
  }

  getTaxData({required BuildContext context})async{
    Response response = await CommonService().getTaxType(context: context);
    storage.setItem(StringConstants.CACHE_TAX_TYPE, response.body);
    if(response.statusCode == 200)
    {
      taxTypeModel = taxTypeModelFromJson(response.body);
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

  addToCartWishlistItem({required BuildContext context, required int itemId}) async
  {
    isAPILoader = true;
    notifyListeners();
    List<int> wishlistIds = [];
    wishlistIds.add(itemId);

    var body = '{ '
          '"customerGuid": "",'
          '"wishListItemIds": $wishlistIds'
        '}';

    Response response = await WishlistService().addToCartWishlistItem(context: context,body: body);
    if(response.statusCode == 200)
    {
      Navigator.push(context, PageTransition(type: selectedTransition, child: MainScreen(tabIndex: 2))).then((value)
      {
        getWishlistData(context: context);
      });
    }else if(response.statusCode == 400)
    {
      InvalidResponseModel invalidResponseModel = invalidResponseModelFromJson(response.body);
      FlushBarMessage().failedMessage(context: context, title: invalidResponseModel.errors.join('\n'));
    }

    isAPILoader = false;
    notifyListeners();
  }

  deleteWishlistItem({required BuildContext context, required int itemId}) async
  {
    isAPILoader = true;
    notifyListeners();
    List<int> wishlistIds = [];
    wishlistIds.add(itemId);

    var body = '{ '
        '"wishListItemIds": $wishlistIds'
        '}';

    Response response = await WishlistService().deleteWishlistItem(context: context,body: body);
    if(response.statusCode == 200)
    {
      getWishlistData(context: context);
    }else if(response.statusCode == 400)
    {
      InvalidResponseModel invalidResponseModel = invalidResponseModelFromJson(response.body);
      FlushBarMessage().failedMessage(context: context, title: invalidResponseModel.errors.join('\n'));
    }

    isAPILoader = false;
    notifyListeners();
  }

  loadCacheData({required BuildContext context}) async
  {
    var wishlistData = await getCacheWishList();
    await getCacheTaxType();

    if(wishlistData != null)
    {
      var cacheHeader = await getCacheHeader();

      if(cacheHeader != null)
      {
        if(headerModel.alertMessage != "")
        {
          DialogBoxWidget().confirmationDialogBox(context: context, title: "Notification", content: headerModel.alertMessage, cancelText: "Cancel", submitText: "Ok", isCancelable: true, onSubmit: (){});
        }
      }
      print("Page");
      isAPILoader = false;
      isPageLoader = false;
      notifyListeners();
    }
  }

  getCacheWishList() async {
    await storage.ready;
    String res = storage.getItem(StringConstants.CACHE_WISHLIST);
    if(res != null)
    {
      wishlistModel = wishlistModelFromJson(res);
      wishlistShareURL = APIConstants.WISHLIST_SHARE_BASEURL + wishlistModel.customerGuid;
      return wishlistModel;
    }else{
      return null;
    }
  }

  getCacheTaxType() async {
    await storage.ready;
    String res = storage.getItem(StringConstants.CACHE_TAX_TYPE);
    if(res != null)
    {
      taxTypeModel = taxTypeModelFromJson(res);
      return taxTypeModel;
    }else{
      return null;
    }
  }

  getCacheHeader() async {
    await storage.ready;
    String res = storage.getItem(StringConstants.CACHE_HEADER);
    if(res != null)
    {
      headerModel = headerInfoResponseModelFromJson(res);
      return headerModel;
    }else{
      return null;
    }
  }

  sharedWishlist({required BuildContext context}) async
  {
    isAPILoader = true;
    notifyListeners();

    await Share.share(wishlistShareURL.trim());

    isAPILoader = false;
    notifyListeners();
  }
}