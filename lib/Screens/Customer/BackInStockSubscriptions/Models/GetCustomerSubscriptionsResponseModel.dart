/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:nopcommerce/Models/CustomProperties.dart';
import 'dart:convert';

import 'package:nopcommerce/Models/PagerModel.dart';

GetCustomerSubscriptionsResponseModel getCustomerSubscriptionsResponseModelFromJson(String str) => GetCustomerSubscriptionsResponseModel.fromJson(json.decode(str));

String getCustomerSubscriptionsResponseModelToJson(GetCustomerSubscriptionsResponseModel data) => json.encode(data.toJson());

class GetCustomerSubscriptionsResponseModel {
  GetCustomerSubscriptionsResponseModel({
    required this.subscriptions,
    required this.pagerModel,
    required this.customProperties,
  });

  List<Subscription> subscriptions;
  PagerModel pagerModel;
  CustomProperties customProperties;

  factory GetCustomerSubscriptionsResponseModel.fromJson(Map<String, dynamic> json) => GetCustomerSubscriptionsResponseModel(
    subscriptions: List<Subscription>.from(json["Subscriptions"].map((x) => Subscription.fromJson(x))),
    pagerModel: PagerModel.fromJson(json["PagerModel"]),
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "Subscriptions": List<dynamic>.from(subscriptions.map((x) => x.toJson())),
    "PagerModel": pagerModel.toJson(),
    "CustomProperties": customProperties.toJson(),
  };
}


class Subscription {
  Subscription({
   required this.productId,
   required this.productName,
   required this.seName,
   required this.id,
   required this.customProperties,
  });

  int productId;
  String productName;
  String seName;
  int id;
  CustomProperties customProperties;

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
    productId: json["ProductId"],
    productName: json["ProductName"],
    seName: json["SeName"],
    id: json["Id"],
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "ProductId": productId,
    "ProductName": productName,
    "SeName": seName,
    "Id": id,
    "CustomProperties": customProperties.toJson(),
  };
}
