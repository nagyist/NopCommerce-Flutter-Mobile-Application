/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:nopcommerce/DataProvider/APIConstants.dart';
import 'package:nopcommerce/DataProvider/APIService.dart';

class ProductService {
  APIService _apiService = new APIService();

  popularProductTags({required BuildContext context}) async {
    return await _apiService.httpGet(context: context ,url: APIConstants.GET_POPULAR_PRODUCT_TAGS_API, isWithoutToken: false);
  }

  getProductReview({required BuildContext context,required String params}) async {
    return await _apiService.httpGet(context: context ,url: APIConstants.GET_PRODUCT_REVIEWS_API + params, isWithoutToken: false);
  }

  addProductReview({required BuildContext context, required String params, required var body}) async {
    return await _apiService.httpPost(context: context , url: APIConstants.ADD_PRODUCT_REVIEWS_API + params, body: body);
  }

  setProductReviewHelpfulness({required BuildContext context, required var body}) async {
    return await _apiService.httpPost(context: context , url: APIConstants.SET_PRODUCT_REVIEW_HELPFULNESS_API, body: body);
  }

  postProductEstimateShipping({required BuildContext context,required String params, required var body}) async {
    return await _apiService.httpPost(context: context , url: APIConstants.PRODUCT_ESTIMATE_SHIPPING_API + params, body: body);
  }

  getEmailProduct({required BuildContext context,required String params}) async {
    return await _apiService.httpGet(context: context , url: APIConstants.GET_PRODUCT_EMAIL_A_FRIEND_API + params, isWithoutToken: false);
  }

  postProductEmailAFriend({required BuildContext context,required String params, required var body}) async {
    return await _apiService.httpPost(context: context , url: APIConstants.PRODUCT_EMAIL_A_FRIEND_API + params, body: body);
  }

  searchProducts({required BuildContext context,required String params}) async {
    return await _apiService.httpGet(context: context , url: APIConstants.SEARCH_PRODUCTS_API + params, isWithoutToken: false);
  }

  getNewProducts({required BuildContext context}) async {
    return await _apiService.httpGet(context: context , url: APIConstants.GET_NEW_PRODUCT_API, isWithoutToken: false);
  }

}