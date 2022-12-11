/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/cupertino.dart';
import 'package:nopcommerce/DataProvider/APIConstants.dart';
import 'package:nopcommerce/DataProvider/APIService.dart';

class CommonService {
  APIService _apiService = new APIService();

  getLocalResource({required BuildContext context}) async {
    return await _apiService.httpGet(context: context ,url: APIConstants.GET_LOCAL_STRING_RESOURCES_API, isWithoutToken: true);
  }

  getSettings({required BuildContext context}) async {
    return await _apiService.httpGet(context: context ,url: APIConstants.GET_SETTING_API, isWithoutToken: true);
  }

  getPing({required BuildContext context}) async {
    return await _apiService.httpGet(context: context ,url: APIConstants.GET_PING_API, isWithoutToken: true);
  }

  getGuestToken({required BuildContext context}) async {
    return await _apiService.httpGet(context: context ,url: APIConstants.GUEST_TOKEN_API, isWithoutToken: true);
  }

  getTopicBlock({required BuildContext context, required String topic}) async {
    return await _apiService.httpGet(context: context ,url: APIConstants.GET_TOPIC_BLOCK_API+'/$topic', isWithoutToken: false);
  }

  getTopicBlockById({required BuildContext context, required int topicId}) async {
    return await _apiService.httpGet(context: context ,url: APIConstants.GET_TOPIC_BLOCK_BY_ID_API+'/$topicId', isWithoutToken: false);
  }

  getHeaderData({required BuildContext context}) async {
    return await _apiService.httpGet(context: context ,url: APIConstants.GET_HEADER_INFO_API, isWithoutToken: false);
  }

  getStateData({required BuildContext context,required int countryId}) async {
    return await _apiService.httpGet(context: context ,url: APIConstants.GET_STATE_API + "/$countryId", isWithoutToken: false);
  }

  getTaxType({required BuildContext context}) async {
    return await _apiService.httpGet(context: context ,url: APIConstants.GET_TAX_TYPE_API, isWithoutToken: false);
  }

  postTaxType({required BuildContext context,required String params}) async {
    return await _apiService.httpPostWithoutBody(context: context ,url: APIConstants.SET_TAX_TYPE_API +params);
  }

  getCustomerNavigation({required BuildContext context}) async {
    return await _apiService.httpGet(context: context ,url: APIConstants.NAVIGATION_API, isWithoutToken: false);
  }

  getLanguages({required BuildContext context}) async {
    return await _apiService.httpGet(context: context ,url: APIConstants.GET_LANGUAGE_API, isWithoutToken: false);
  }

  postLanguages({required BuildContext context,required String params}) async {
    return await _apiService.httpPostWithoutBody(context: context ,url: APIConstants.SET_LANGUAGE_API +params);
  }

  getCurrency({required BuildContext context}) async {
    return await _apiService.httpGet(context: context ,url: APIConstants.GET_CURRENCY_API, isWithoutToken: false);
  }

  postCurrency({required BuildContext context,required String params}) async {
    return await _apiService.httpPostWithoutBody(context: context ,url: APIConstants.SET_CURRENCY_API+params);
  }

  getUserAgreement({required BuildContext context,required String params}) async {
    return await _apiService.httpGet(context: context ,url: APIConstants.USER_AGREEMENT_API+params, isWithoutToken: false);
  }

  getContactUs({required BuildContext context}) async {
    return await _apiService.httpGet(context: context ,url: APIConstants.GET_CONTACTUS_API, isWithoutToken: false);
  }

  postContactUs({required BuildContext context,required var body}) async {
    return await _apiService.httpPost(context: context ,url: APIConstants.CONTACTUS_API,body: body);
  }
}
