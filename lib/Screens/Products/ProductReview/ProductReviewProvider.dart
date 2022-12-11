/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nopcommerce/Common/CheckInternet.dart';
import 'package:nopcommerce/Common/FlushbarMessage.dart';
import 'package:nopcommerce/Models/HeaderInfoResponseModel.dart';
import 'package:nopcommerce/Utils/CacheDatabase.dart';
import 'package:nopcommerce/Screens/Products/ProductDetails/Model/GetProductDetailsModel.dart';
import 'package:nopcommerce/Services/CommonService.dart';
import 'package:nopcommerce/Services/ProductServices.dart';
import 'package:nopcommerce/Utils/Strings.dart';
import 'package:nopcommerce/Widgets/DialogBoxWidget.dart';
import 'Models/GetProductReviewsModel.dart';
import 'Models/SetProductReviewHelpfulnessModel.dart';
import 'package:nopcommerce/Models/CustomProperties.dart';

class ProductReviewProvider extends ChangeNotifier
{
  late GetProductReviewsModel getProductReviewsModel;
  late ProductReviewOverview productReviewOverview;
  bool isPageLoader = true;
  bool isAPILoader = false;
  bool isHeaderLoader = true;
  int rating=5;
  int dynamicRating=5;
  Map<int,List<Map<String,int>>> customMap = {};
  Map<int,Map<String,int>> customReview = {};

  TextEditingController reviewTitleController=new TextEditingController();
  TextEditingController reviewTextController=new TextEditingController();
  SetProductReviewHelpfulnessModel setProductReviewHelpfulnessModel=new SetProductReviewHelpfulnessModel(result: '', totalYes: 0, totalNo: 0);

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

  pageLoadData({required BuildContext context, required ProductReviewOverview productReviewOverview}) async
  {
    this.productReviewOverview=productReviewOverview;
    notifyListeners();

    getProductReview(context: context);
  }

  getProductReview({required BuildContext context})async{

    Response response = await ProductService().getProductReview(context: context,params: "/${productReviewOverview.productId}");

    if(response.statusCode == 200)
    {
      getProductReviewsModel = getProductReviewsModelFromJson(response.body);
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
      isHeaderLoader = false;
      isPageLoader = false;
      if(headerModel.alertMessage != "")
      {
        DialogBoxWidget().confirmationDialogBox(context: context, title: "Notification", content: headerModel.alertMessage, cancelText: "Cancel", submitText: "Ok", isCancelable: true, onSubmit: (){});
      }
      notifyListeners();
    }else{
      isHeaderLoader = false;
      isPageLoader = false;
      storage.setItem(StringConstants.CACHE_HEADER, null);
      notifyListeners();
    }
    notifyListeners();
  }

  submitReview({required BuildContext context}) async
  {
    if(await CheckConnectivity().checkInternet(context))
    {
      isAPILoader = true;
      notifyListeners();

      List<Map<String,int>> additionAttributes=[];
      for(var i in customReview.values){
        additionAttributes.add(i);
      }
      final body = '{'
          '"rating": $rating,'
          '"title": "${reviewTitleController.text.toString()}",'
          '"reviewText": "${reviewTextController.text.toString()}",'
          '"prepareReviews": true,'
          '"additionalProductReviewList":$additionAttributes'
          '}';

      Response response = await ProductService().addProductReview(context: context, params: "/${productReviewOverview.productId}",body: body);
      if(response.statusCode == 200){
        getProductReview(context: context);

        FlushBarMessage().successMessage(context: context, title: StringConstants.PRODUCT_REVIEW_SUCCESS_MESSAGE);
        reviewTextController.clear();
        reviewTitleController.clear();
        customReview.clear();
        dynamicRating = 5;
        for(var e in getProductReviewsModel.reviewTypeList){
          customReview[e.id]={
            '"reviewTypeId"':e.id,
            '"rating"': dynamicRating
          };
        }

        rating = 5;
        isAPILoader = false;
        notifyListeners();
      }
    }
  }

  reviewHelpfulnessClick({required BuildContext context, required int productReviewId, required bool isHelpful}) async
  {
    isAPILoader = true;
    notifyListeners();

    final body = ''
        '{'
        '"productReviewId": $productReviewId,'
        '"washelpful": $isHelpful'
        '}';

    Response response = await ProductService().setProductReviewHelpfulness(context: context, body: body);
    if(response.statusCode == 200)
    {
      isAPILoader = false;
      setProductReviewHelpfulnessModel = setProductReviewHelpfulnessModelFromJson(response.body);
      notifyListeners();
      return true;
    }else{
      isAPILoader = false;
      notifyListeners();
      return false;
    }
  }
}