/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:nopcommerce/Models/CustomProperties.dart';
import 'dart:convert';

import 'package:nopcommerce/Models/OrderItemModel.dart';
import 'package:nopcommerce/Models/RecurringOrderModel.dart';

CustomerOrdersModel customerOrdersModelFromJson(String str) => CustomerOrdersModel.fromJson(json.decode(str));

String customerOrdersModelToJson(CustomerOrdersModel data) => json.encode(data.toJson());

class CustomerOrdersModel {
  CustomerOrdersModel({
    required this.orders,
    required this.recurringOrders,
    required this.recurringPaymentErrors,
    required this.customProperties,
  });

  List<OrderListItem> orders;
  List<RecurringOrder> recurringOrders;
  List<dynamic> recurringPaymentErrors;
  CustomProperties customProperties;

  factory CustomerOrdersModel.fromJson(Map<String, dynamic> json) => CustomerOrdersModel(
    orders: List<OrderListItem>.from(json["Orders"].map((x) => OrderListItem.fromJson(x))),
    recurringOrders: List<RecurringOrder>.from(json["RecurringOrders"].map((x) =>RecurringOrder.fromJson(x))),
    recurringPaymentErrors: List<dynamic>.from(json["RecurringPaymentErrors"].map((x) => x)),
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "Orders": List<dynamic>.from(orders.map((x) => x.toJson())),
    "RecurringOrders": List<dynamic>.from(recurringOrders.map((x) => x)),
    "RecurringPaymentErrors": List<dynamic>.from(recurringPaymentErrors.map((x) => x)),
    "CustomProperties": customProperties.toJson(),
  };
}