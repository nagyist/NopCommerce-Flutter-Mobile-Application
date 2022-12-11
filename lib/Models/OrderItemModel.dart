/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


import 'CustomProperties.dart';

class OrderListItem {
  OrderListItem({
    required this.customOrderNumber,
    required this.orderTotal,
    required this.isReturnRequestAllowed,
    required this.orderStatusEnum,
    required this.orderStatus,
    required this.paymentStatus,
    required this.shippingStatus,
    required this.createdOn,
    required this.id,
    required this.customProperties,
  });

  String customOrderNumber;
  String orderTotal;
  bool isReturnRequestAllowed;
  String orderStatusEnum;
  String orderStatus;
  String paymentStatus;
  String shippingStatus;
  DateTime createdOn;
  int id;
  CustomProperties customProperties;

  factory OrderListItem.fromJson(Map<String, dynamic> json) => OrderListItem(
    customOrderNumber: json["CustomOrderNumber"],
    orderTotal: json["OrderTotal"],
    isReturnRequestAllowed: json["IsReturnRequestAllowed"],
    orderStatusEnum: json["OrderStatusEnum"],
    orderStatus: json["OrderStatus"],
    paymentStatus: json["PaymentStatus"],
    shippingStatus: json["ShippingStatus"],
    createdOn: DateTime.parse(json["CreatedOn"]),
    id: json["Id"],
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "CustomOrderNumber": customOrderNumber,
    "OrderTotal": orderTotal,
    "IsReturnRequestAllowed": isReturnRequestAllowed,
    "OrderStatusEnum": orderStatusEnum,
    "OrderStatus": orderStatus,
    "PaymentStatus": paymentStatus,
    "ShippingStatus": shippingStatus,
    "CreatedOn": createdOn.toIso8601String(),
    "Id": id,
    "CustomProperties": customProperties.toJson(),
  };
}