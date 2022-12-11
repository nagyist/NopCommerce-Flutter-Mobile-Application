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
import 'package:nopcommerce/Screens/Customer/CustomerProductReview/Model/GetCustomerProductReviewsModel.dart';
import 'package:nopcommerce/Services/CommonService.dart';
import 'package:nopcommerce/Services/CustomerProductReviewService.dart';
import 'package:nopcommerce/Utils/CacheDatabase.dart';
import 'package:nopcommerce/Utils/Strings.dart';
import 'package:nopcommerce/Widgets/DialogBoxWidget.dart';

class CustomerProductReviewProvider extends ChangeNotifier {

  bool isPageLoader = false;
  bool isAPILoader = false;
  bool isLazyLoader = false;
  int pageNumber=0;
  List<int> pagNumber=[];
  List<ProductReview> productReview=[];
  late GetCustomerProductReviewsModel getCustomerProductReviewsModel;
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

  pageLoadData({required BuildContext context}) {
   customerProductReviewData(context: context, pageNumber: pageNumber);
   notifyListeners();
 }

  customerProductReviewData({required BuildContext context,required int pageNumber}) async {
   Response response = await CustomerProductReviewService().getCustomerProductReview(context: context, param: '?pageNumber=$pageNumber');
    if (response.statusCode == 200) {
      storage.setItem(StringConstants.CACHE_PRODUCT_REVIEW, response.body);
      getCustomerProductReviewsModel = getCustomerProductReviewsModelFromJson(response.body);
      productReview.clear();
      productReview.addAll(getCustomerProductReviewsModel.productReviews);
    }
    getHeaderData(context: context);
    notifyListeners();
  }

  getHeaderData({required BuildContext context}) async {
      Response response = await CommonService().getHeaderData(context: context);
      if (response.statusCode == 200) {
        storage.setItem(StringConstants.CACHE_HEADER, response.body);
        headerModel = headerInfoResponseModelFromJson(response.body);
        if (headerModel.alertMessage != "") {
          DialogBoxWidget().confirmationDialogBox(context: context,
              title: "Notification",
              content: headerModel.alertMessage,
              cancelText: "Cancel",
              submitText: "Ok",
              isCancelable: true,
              onSubmit: () {});
        }
      }else{
        storage.setItem(StringConstants.CACHE_HEADER, null);
      }
      isPageLoader = false;
      isAPILoader = false;
      notifyListeners();
    }

  Future loadMoreProducts({required BuildContext context}) async {
   if(getCustomerProductReviewsModel.pagerModel.currentPage!=getCustomerProductReviewsModel.pagerModel.totalPages)
    {
      isLazyLoader = true;
      notifyListeners();
      Response response = await CustomerProductReviewService().getCustomerProductReview(context: context, param: '?pageNumber=${getCustomerProductReviewsModel.pagerModel.currentPage+1}');
      if (response.statusCode == 200) {
        getCustomerProductReviewsModel = getCustomerProductReviewsModelFromJson(response.body);
        productReview.addAll(getCustomerProductReviewsModel.productReviews);
        isLazyLoader = false;
      }
    }
    notifyListeners();
  }

  loadCacheData({required BuildContext context}) async{
    isPageLoader = true;
    isAPILoader = false;
    isLazyLoader = false;
    productReview=[];
    pageNumber=0;
    productReview.clear();
    pagNumber.clear();

    await getCacheProductReview(context: context);
    await getCacheHeader(context: context);
 }

  getCacheProductReview({required BuildContext context}) async {
    await storage.ready;
    String res = storage.getItem(StringConstants.CACHE_PRODUCT_REVIEW);
    if(res != null)
    {
      getCustomerProductReviewsModel = getCustomerProductReviewsModelFromJson(res);
      productReview.addAll(getCustomerProductReviewsModel.productReviews);
      int i=1;
      while(i<=getCustomerProductReviewsModel.pagerModel.totalPages){
        pagNumber.add(i);
        i++;
      }
      isPageLoader = false;
      notifyListeners();
      return getCustomerProductReviewsModel;
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
