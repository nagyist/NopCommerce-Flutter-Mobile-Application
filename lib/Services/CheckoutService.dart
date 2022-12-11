/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:nopcommerce/DataProvider/APIConstants.dart';
import 'package:nopcommerce/DataProvider/APIService.dart';

class CheckoutService {
  APIService _apiService = new APIService();

  getBillingAddress({required BuildContext context, required String params}) async {
    return await _apiService.httpGet(context: context ,url: APIConstants.BILLING_ADDRESSES_API + params, isWithoutToken: false);
  }

  getShippingAddress({required BuildContext context, required String params}) async {
    return await _apiService.httpGet(context: context ,url: APIConstants.SHIPPING_ADDRESSES_API + params, isWithoutToken: false);
  }

  getShippingMethods({required BuildContext context}) async {
    return await _apiService.httpGet(context: context ,url: APIConstants.SHIPPING_METHODS_API, isWithoutToken: false);
  }

  getOrderSummery({required BuildContext context}) async {
    return await _apiService.httpGet(context: context ,url: APIConstants.ORDER_SUMMARY_API + '?validateCheckoutAttributes=true&prepareOrderReviewData=true', isWithoutToken: false);
  }

  getOrderTotal({required BuildContext context}) async {
    return await _apiService.httpGet(context: context ,url: APIConstants.GET_CART_ORDER_TOTAL_API, isWithoutToken: false);
  }

  getPickupPoints({required BuildContext context}) async {
    return await _apiService.httpGet(context: context ,url: APIConstants.PICKUP_POINT_API, isWithoutToken: false);
  }

  getPaymentMethods({required BuildContext context}) async {
    return await _apiService.httpGet(context: context ,url: APIConstants.PAYMENT_METHODS_API, isWithoutToken: false);
  }

  postAddBillingAddress({required BuildContext context, required var body}) async {
    return await _apiService.httpPost(context: context ,url: APIConstants.ADD_BILLING_ADDRESS_API, body: body);
  }

  postAddShippingAddress({required BuildContext context, required var body}) async {
    return await _apiService.httpPost(context: context ,url: APIConstants.ADD_SHIPPING_ADDRESS_API, body: body);
  }

  uploadBillingAddress({required BuildContext context, required String params}) async {
    return await _apiService.httpGet(context: context ,url: APIConstants.SELECT_BILLING_ADDRESS_API + params, isWithoutToken: false);
  }

  uploadShippingAddress({required BuildContext context, required String params}) async {
    return await _apiService.httpGet(context: context ,url: APIConstants.SELECT_SHIPPING_ADDRESS_API + params, isWithoutToken: false);
  }

  uploadShippingMethod({required BuildContext context, required var body}) async {
    return await _apiService.httpPost(context: context ,url: APIConstants.SELECT_SHIPPING_METHODS_API, body: body);
  }

  uploadPaymentMethod({required BuildContext context, required String params}) async {
    return await _apiService.httpGet(context: context ,url: APIConstants.SELECT_PAYMENT_METHODS_API + params, isWithoutToken: false);
  }

  getPaymentInfo({required BuildContext context}) async {
    return await _apiService.httpGet(context: context ,url: APIConstants.PAYMENT_INFO_API, isWithoutToken: false);
  }

  validatePaymentInfo({required BuildContext context,required var body}) async {
    return await _apiService.httpPost(context: context ,url: APIConstants.VALIDATION_PAYMENT_API, body: body);
  }

  confirmOrder({required BuildContext context,required var body}) async {
    return await _apiService.httpPost(context: context ,url: APIConstants.CONFIRM_ORDER_API, body: body);
  }

  getOrderCompleteInfo({required BuildContext context}) async {
    return await _apiService.httpGet(context: context ,url: APIConstants.GET_COMPLETE_ORDER, isWithoutToken: false);
  }
}