/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nopcommerce/DataProvider/APIConstants.dart';
import 'package:nopcommerce/DataProvider/APIService.dart';

class ShoppingCartService {
  APIService _apiService = new APIService();


  getCartData({required BuildContext context}) async {
    return await _apiService.httpGet(context: context ,url: APIConstants.GET_CART_API, isWithoutToken: false);
  }

  getCrossProductCartData({required BuildContext context}) async {
    return await _apiService.httpGet(context: context ,url: APIConstants.GET_CROSS_SELL_PRODUCT_API, isWithoutToken: false);
  }

  getCartTotalData({required BuildContext context}) async {
    return await _apiService.httpGet(context: context ,url: APIConstants.GET_CART_ORDER_TOTAL_API, isWithoutToken: false);
  }

  getCartEstimateShippingData({required BuildContext context}) async {
    return await _apiService.httpGet(context: context ,url: APIConstants.CART_ESTIMATE_SHIPPING_API, isWithoutToken: false);
  }

  postCartEstimateShippingData({required BuildContext context, required var body}) async {
    return await _apiService.httpPost(context: context ,url: APIConstants.CART_POST_ESTIMATE_SHIPPING_API,body: body);
  }

  deleteCartData({required BuildContext context, required var body}) async {
    return await _apiService.httpDelete(context: context ,url: APIConstants.REMOVE_CART_ITEM_API,body: body);
  }

  updateCartQuantity({required BuildContext context, required var body}) async {
    return await _apiService.httpPut(context: context ,url: APIConstants.UPDATE_CART_QUANTITY_API+"?prepareCart=true",body: body);
  }

  postCartUploadFileAttributeChange({required BuildContext context, required var body, required String params}) async {
    return await _apiService.httpPost(context: context ,url: APIConstants.POST_CART_UPLOAD_FILE_ATTRIBUTE_API+params,body: body);
  }

  postCartAttributeChange({required BuildContext context, required var body}) async {
    return await _apiService.httpPost(context: context ,url: APIConstants.POST_CART_CHANGE_ATTRIBUTE_API,body: body);
  }

  postDiscountCoupon({required BuildContext context,required String params}) async {
    return await _apiService.httpPostWithoutBody(context: context ,url: APIConstants.GET_DISCOUNT_COUPON_API+params);
  }

  removeDiscountCoupon({required BuildContext context,required String params}) async {
    return await _apiService.httpPostWithoutBody(context: context ,url: APIConstants.DELETE_DISCOUNT_COUPON_API+params);
  }

  postGiftCardCoupon({required BuildContext context,required String params}) async {
    return await _apiService.httpPostWithoutBody(context: context ,url: APIConstants.GET_GIFT_CARD_COUPON_API+params);
  }

  removeGiftCardCoupon({required BuildContext context,required String params}) async {
    return await _apiService.httpPostWithoutBody(context: context ,url: APIConstants.DELETE_GIFT_CARD_COUPON_API+params);
  }

  getPdfDownload({required BuildContext context, required String params}) async {
    return await _apiService.httpGet(context: context ,url: APIConstants.DOWNLOAD_PDF_API+params, isWithoutToken: false);
  }

  startCheckout({required BuildContext context,required String body}) async {
    return await _apiService.httpPost(context: context ,url: APIConstants.START_CHECKOUT_API,body: body);
  }

  postProductDetailsAddToCart({required BuildContext context,required String params,required String body}) async {
    return await _apiService.httpPost(context: context ,url: APIConstants.SET_ADD_TO_CART_API + params,body: body);
  }

  postProductEstimateShipping({required BuildContext context, required var body}) async {
    return await _apiService.httpPost(context: context ,url: APIConstants.CART_POST_ESTIMATE_SHIPPING_API, body: body);
  }

  postSelectShippingOption({required BuildContext context, required String params,required var body}) async {
    return await _apiService.httpPost(context: context ,url: APIConstants.SELECT_SHIPPING_OPTION_API + params, body: body);
  }
}