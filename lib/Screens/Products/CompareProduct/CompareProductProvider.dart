/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nopcommerce/Models/HeaderInfoResponseModel.dart';
import 'package:nopcommerce/Models/ProductSpecificationModel.dart';
import 'package:nopcommerce/Utils/CacheDatabase.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Screens/Products/ProductDetails/Model/GetProductDetailsModel.dart';
import 'package:nopcommerce/Services/CommonService.dart';
import 'package:nopcommerce/Services/ProductDetailService.dart';
import 'package:nopcommerce/Utils/SQFliteDatabase.dart';
import 'package:nopcommerce/Utils/Strings.dart';
import 'package:nopcommerce/Widgets/DialogBoxWidget.dart';
import 'Models/CompareProductModel.dart';
import 'package:nopcommerce/Models/CustomProperties.dart';

class CompareProductProvider extends ChangeNotifier {

  bool isPageLoader = true;
  bool isAPILoader = false;
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
  List<CompareProductResourseModel> compareProductsList = [];
  List<GetProductDetailsModel> compareProductDetailsList = [];
  late GetProductDetailsModel getProductDetailsModel;
  List<Group> uniqueGroups = [];
  List<AttributeGroup> uniqueGroupAttributes = [];

  pageLoadData({required BuildContext context}) async
  {
    isPageLoader = true;
    isAPILoader = false;
    notifyListeners();
    getCompareProductsData(context: context);
  }

  getCompareProductsData({required BuildContext context}) async {
    compareProductsList.clear();
    compareProductsList = await SQFLiteDatabase().dbHelper.getCompareProductsData();

    notifyListeners();
    getProductListData(context: context);
  }

  getProductListData({required BuildContext context})async {

    compareProductDetailsList.clear();
    compareProductsList.sort((b, a) => a.productId.compareTo(b.productId));

    for(var productData in compareProductsList.take(4))
    {
      Response response = await ProductDetailsService().getProductDetails(context: context,params: "/${productData.productId}");
      if(response.statusCode == 200)
      {
        compareProductDetailsList.add(getProductDetailsModelFromJson(response.body));
      }
    }
    uniqueGroups=[];
    for(var product in compareProductDetailsList)
    {
      for(var group in product.productSpecificationModel.groups)
      {
        if (!uniqueGroups.any((g) => g.id == group.id))
        {
          uniqueGroups.add(group);
        }
      }
    }
    notifyListeners();
    getHeaderData(context: context);
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

  deleteProductById({required BuildContext context, required int productId}){
    SQFLiteDatabase().dbHelper.deleteByProductId(productId: productId);
    pageLoadData(context: context);
  }
  deleteAllProduct({required BuildContext context}){
    SQFLiteDatabase().dbHelper.deleteAllCompareProductId();
    pageLoadData(context: context);
  }
}