/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:nopcommerce/Models/CustomProperties.dart';
import 'dart:convert';

GetSubscribesModel getSubscribesModelFromJson(String str) => GetSubscribesModel.fromJson(json.decode(str));

String getSubscribesModelToJson(GetSubscribesModel data) => json.encode(data.toJson());

class GetSubscribesModel {
  GetSubscribesModel({
    required this.productId,
    required this.productName,
    required this.productSeName,
    required this.isCurrentCustomerRegistered,
    required this.subscriptionAllowed,
    required this.alreadySubscribed,
    required this.maximumBackInStockSubscriptions,
    required this.currentNumberOfBackInStockSubscriptions,
    required this.customProperties,
  });

  int productId;
  String productName;
  String productSeName;
  bool isCurrentCustomerRegistered;
  bool subscriptionAllowed;
  bool alreadySubscribed;
  int maximumBackInStockSubscriptions;
  int currentNumberOfBackInStockSubscriptions;
  CustomProperties customProperties;

  factory GetSubscribesModel.fromJson(Map<String, dynamic> json) => GetSubscribesModel(
    productId: json["ProductId"],
    productName: json["ProductName"],
    productSeName: json["ProductSeName"],
    isCurrentCustomerRegistered: json["IsCurrentCustomerRegistered"],
    subscriptionAllowed: json["SubscriptionAllowed"],
    alreadySubscribed: json["AlreadySubscribed"],
    maximumBackInStockSubscriptions: json["MaximumBackInStockSubscriptions"],
    currentNumberOfBackInStockSubscriptions: json["CurrentNumberOfBackInStockSubscriptions"],
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "ProductId": productId,
    "ProductName": productName,
    "ProductSeName": productSeName,
    "IsCurrentCustomerRegistered": isCurrentCustomerRegistered,
    "SubscriptionAllowed": subscriptionAllowed,
    "AlreadySubscribed": alreadySubscribed,
    "MaximumBackInStockSubscriptions": maximumBackInStockSubscriptions,
    "CurrentNumberOfBackInStockSubscriptions": currentNumberOfBackInStockSubscriptions,
    "CustomProperties": customProperties.toJson(),
  };
}
