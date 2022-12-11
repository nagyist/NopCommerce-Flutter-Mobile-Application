/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/cupertino.dart';
import 'package:nopcommerce/DataProvider/APIService.dart';
import 'package:nopcommerce/DataProvider/APIConstants.dart';


class OrderServices{
  APIService _apiService = new APIService();

  getListOfOrderData({required BuildContext context}) async {
    return _apiService.httpGet(context: context ,url: APIConstants.GET_CUSTOMER_ORDERS_API, isWithoutToken: false);
  }

  getOrderDetail({required BuildContext context,required  String param }) async {
    return _apiService.httpGet(context: context ,url: APIConstants.GET_ORDER_DETAILS_API+param, isWithoutToken: false);
  }


  setReOrder({required BuildContext context,required String param}) async {
    return await _apiService.httpPostWithoutBody(context: context ,url: APIConstants.SET_ORDER_API+param);
  }

  rePaymentOrder({required BuildContext context,required String param}) async {
    return await _apiService.httpPostWithoutBody(context: context ,url: APIConstants.REPAYMENT_DETAILS_API+param,);
  }

  getPdfInvoiceOrder({required BuildContext context,required String param}) async {
    return _apiService.httpGet(context: context ,url: APIConstants.GET_PDF_INVOICE_API+param, isWithoutToken: false);
  }

  getOrderShipmentDetails({required BuildContext context,required String param}) async {
    return _apiService.httpGet(context: context ,url: APIConstants.GET_SHIPMENT_DETAILS_API+param, isWithoutToken: false);
  }

  cancelRecurringPayment({required BuildContext context,required String param}) async {
    return await _apiService.httpPostWithoutBody(context: context ,url: APIConstants.CANCEL_RECURRING_PAYMENT_API+param);
  }

  retryLastRecurringPayment({required BuildContext context,required String param,required var body}) async {
    return await _apiService.httpPost(context: context ,url: APIConstants.RETRY_LAST_RECURRING_PAYMENT_API+param,body: body);
  }

}