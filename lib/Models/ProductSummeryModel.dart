/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:nopcommerce/Models/PictureBoxModel.dart';

import 'CustomProperties.dart';

class ProductSummeryModel {
  ProductSummeryModel({
    required this.sku,
    required this.vendorName,
    required this.picture,
    required this.productId,
    required this.productName,
    required this.productSeName,
    required this.unitPrice,
    required this.subTotal,
    required this.discount,
    required this.maximumDiscountedQty,
    required this.quantity,
    required this.allowedQuantities,
    required this.attributeInfo,
    required this.recurringInfo,
    required this.rentalInfo,
    required this.allowItemEditing,
    required this.disableRemoval,
    required this.warnings,
    required this.id,
    required this.customProperties,
  });

  String sku;
  dynamic vendorName;
  PictureModel picture;
  int productId;
  String productName;
  String productSeName;
  String unitPrice;
  String subTotal;
  dynamic discount;
  dynamic maximumDiscountedQty;
  int quantity;
  List<dynamic> allowedQuantities;
  String attributeInfo;
  dynamic recurringInfo;
  dynamic rentalInfo;
  bool allowItemEditing;
  bool disableRemoval;
  List<dynamic> warnings;
  int id;
  CustomProperties customProperties;

  factory ProductSummeryModel.fromJson(Map<String, dynamic> json) => ProductSummeryModel(
    sku: json["Sku"],
    vendorName: json["VendorName"],
    picture: PictureModel.fromJson(json["Picture"]),
    productId: json["ProductId"],
    productName: json["ProductName"],
    productSeName: json["ProductSeName"],
    unitPrice: json["UnitPrice"],
    subTotal: json["SubTotal"],
    discount: json["Discount"],
    maximumDiscountedQty: json["MaximumDiscountedQty"],
    quantity: json["Quantity"],
    allowedQuantities: List<dynamic>.from(json["AllowedQuantities"].map((x) => x)),
    attributeInfo: json["AttributeInfo"],
    recurringInfo: json["RecurringInfo"],
    rentalInfo: json["RentalInfo"],
    allowItemEditing: json["AllowItemEditing"],
    disableRemoval: json["DisableRemoval"],
    warnings: List<dynamic>.from(json["Warnings"].map((x) => x)),
    id: json["Id"],
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "Sku": sku,
    "VendorName": vendorName,
    "Picture": picture.toJson(),
    "ProductId": productId,
    "ProductName": productName,
    "ProductSeName": productSeName,
    "UnitPrice": unitPrice,
    "SubTotal": subTotal,
    "Discount": discount,
    "MaximumDiscountedQty": maximumDiscountedQty,
    "Quantity": quantity,
    "AllowedQuantities": List<dynamic>.from(allowedQuantities.map((x) => x)),
    "AttributeInfo": attributeInfo,
    "RecurringInfo": recurringInfo,
    "RentalInfo": rentalInfo,
    "AllowItemEditing": allowItemEditing,
    "DisableRemoval": disableRemoval,
    "Warnings": List<dynamic>.from(warnings.map((x) => x)),
    "Id": id,
    "CustomProperties": customProperties.toJson(),
  };
}
