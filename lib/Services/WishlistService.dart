/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:nopcommerce/DataProvider/APIConstants.dart';
import 'package:nopcommerce/DataProvider/APIService.dart';

class WishlistService {
  APIService _apiService = new APIService();

  getWishlist({required BuildContext context}) async {
    return await _apiService.httpGet(context: context ,url: APIConstants.GET_WISH_LIST_API,isWithoutToken: false);
  }

  productDetailsAddToWishlist({required BuildContext context, required String params, required var body}) async {
    return await _apiService.httpPost(context: context ,url: APIConstants.SET_ADD_TO_WISHLIST_API+params,body: body);
  }

  getEmailWishlist({required BuildContext context}) async {
    return await _apiService.httpGet(context: context ,url: APIConstants.GET_EMAIL_WISHLIST_API,isWithoutToken: false);
  }

  shareEmailWishlist({required BuildContext context, required var body}) async {
    return await _apiService.httpPost(context: context ,url: APIConstants.EMAIL_WISHLIST_API, body: body);
  }

  addToCartWishlistItem({required BuildContext context, required var body}) async {
    return await _apiService.httpPost(context: context ,url: APIConstants.ADD_ITEMS_TO_CART_FROM_WISHLIST_API, body: body);
  }

  deleteWishlistItem({required BuildContext context, required var body}) async {
    return await _apiService.httpDelete(context: context ,url: APIConstants.DELETE_WISHLIST_ITEMS_API, body: body);
  }

}