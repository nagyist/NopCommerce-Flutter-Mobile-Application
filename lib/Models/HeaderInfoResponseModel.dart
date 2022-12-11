/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


import 'package:nopcommerce/Models/CustomProperties.dart';
import 'dart:convert';

HeaderInfoResponseModel headerInfoResponseModelFromJson(String str) => HeaderInfoResponseModel.fromJson(json.decode(str));

String headerInfoResponseModelToJson(HeaderInfoResponseModel data) => json.encode(data.toJson());

class HeaderInfoResponseModel {
  HeaderInfoResponseModel({
    required this.isAuthenticated,
    required this.customerName,
    required this.shoppingCartEnabled,
    required this.shoppingCartItems,
    required this.wishlistEnabled,
    required this.wishlistItems,
    required this.allowPrivateMessages,
    required this.unreadPrivateMessages,
    required this.alertMessage,
    required this.registrationType,
    required this.customProperties,
  });

  bool isAuthenticated;
  String customerName;
  bool shoppingCartEnabled;
  int shoppingCartItems;
  bool wishlistEnabled;
  int wishlistItems;
  bool allowPrivateMessages;
  String unreadPrivateMessages;
  String alertMessage;
  String registrationType;
  CustomProperties customProperties;

  factory HeaderInfoResponseModel.fromJson(Map<String, dynamic> json) => HeaderInfoResponseModel(
    isAuthenticated: json["IsAuthenticated"],
    customerName: json["CustomerName"],
    shoppingCartEnabled: json["ShoppingCartEnabled"],
    shoppingCartItems: json["ShoppingCartItems"],
    wishlistEnabled: json["WishlistEnabled"],
    wishlistItems: json["WishlistItems"],
    allowPrivateMessages: json["AllowPrivateMessages"],
    unreadPrivateMessages: json["UnreadPrivateMessages"],
    alertMessage: json["AlertMessage"],
    registrationType: json["RegistrationType"],
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "IsAuthenticated": isAuthenticated,
    "CustomerName": customerName,
    "ShoppingCartEnabled": shoppingCartEnabled,
    "ShoppingCartItems": shoppingCartItems,
    "WishlistEnabled": wishlistEnabled,
    "WishlistItems": wishlistItems,
    "AllowPrivateMessages": allowPrivateMessages,
    "UnreadPrivateMessages": unreadPrivateMessages,
    "AlertMessage": alertMessage,
    "RegistrationType": registrationType,
    "CustomProperties": customProperties.toJson(),
  };
}
