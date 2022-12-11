/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


import 'CustomProperties.dart';

class OrderSummeryModel {
  OrderSummeryModel({
    required this.orderItemGuid,
    required this.sku,
    required this.productId,
    required this.productName,
    required this.productSeName,
    required this.unitPrice,
    required this.subTotal,
    required this.quantity,
    required this.attributeInfo,
    required this.rentalInfo,
    required this.vendorName,
    required this.downloadId,
    required this.licenseId,
    required this.id,
    required this.customProperties,
  });

  String orderItemGuid;
  String sku;
  int productId;
  String productName;
  String productSeName;
  String unitPrice;
  String subTotal;
  int quantity;
  String attributeInfo;
  dynamic rentalInfo;
  String vendorName;
  int downloadId;
  int licenseId;
  int id;
  CustomProperties customProperties;

  factory OrderSummeryModel.fromJson(Map<String, dynamic> json) => OrderSummeryModel(
    orderItemGuid: json["OrderItemGuid"],
    sku: json["Sku"] == null ? null : json["Sku"],
    productId: json["ProductId"],
    productName: json["ProductName"],
    productSeName: json["ProductSeName"],
    unitPrice: json["UnitPrice"],
    subTotal: json["SubTotal"],
    quantity: json["Quantity"],
    attributeInfo: json["AttributeInfo"],
    rentalInfo: json["RentalInfo"],
    vendorName: json["VendorName"],
    downloadId: json["DownloadId"],
    licenseId: json["LicenseId"],
    id: json["Id"],
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "OrderItemGuid": orderItemGuid,
    "Sku": sku == null ? null : sku,
    "ProductId": productId,
    "ProductName": productName,
    "ProductSeName": productSeName,
    "UnitPrice": unitPrice,
    "SubTotal": subTotal,
    "Quantity": quantity,
    "AttributeInfo": attributeInfo,
    "RentalInfo": rentalInfo,
    "VendorName": vendorName,
    "DownloadId": downloadId,
    "LicenseId": licenseId,
    "Id": id,
    "CustomProperties": customProperties.toJson(),
  };
}

