/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:nopcommerce/Models/CustomProperties.dart';
import 'dart:convert';

import 'package:nopcommerce/Models/PictureBoxModel.dart';

WishlistModel wishlistModelFromJson(String str) => WishlistModel.fromJson(json.decode(str));

String wishlistModelToJson(WishlistModel data) => json.encode(data.toJson());

class WishlistModel {
  WishlistModel({
    required this.customerGuid,
    required this.customerFullName,
    required this.emailWishlistEnabled,
    required this.showSku,
    required this.showProductImages,
    required this.isEditable,
    required this.displayAddToCart,
    required this.displayTaxShippingInfo,
    required this.items,
    required this.warnings,
    required this.customProperties,
  });

  String customerGuid;
  String customerFullName;
  bool emailWishlistEnabled;
  bool showSku;
  bool showProductImages;
  bool isEditable;
  bool displayAddToCart;
  bool displayTaxShippingInfo;
  List<WishlistItem> items;
  List<dynamic> warnings;
  CustomProperties customProperties;

  factory WishlistModel.fromJson(Map<String, dynamic> json) => WishlistModel(
    customerGuid: json["CustomerGuid"],
    customerFullName: json["CustomerFullname"],
    emailWishlistEnabled: json["EmailWishlistEnabled"],
    showSku: json["ShowSku"],
    showProductImages: json["ShowProductImages"],
    isEditable: json["IsEditable"],
    displayAddToCart: json["DisplayAddToCart"],
    displayTaxShippingInfo: json["DisplayTaxShippingInfo"],
    items: List<WishlistItem>.from(json["Items"].map((x) => WishlistItem.fromJson(x))),
    warnings: List<dynamic>.from(json["Warnings"].map((x) => x)),
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "CustomerGuid": customerGuid,
    "CustomerFullname": customerFullName,
    "EmailWishlistEnabled": emailWishlistEnabled,
    "ShowSku": showSku,
    "ShowProductImages": showProductImages,
    "IsEditable": isEditable,
    "DisplayAddToCart": displayAddToCart,
    "DisplayTaxShippingInfo": displayTaxShippingInfo,
    "Items": List<dynamic>.from(items.map((x) => x.toJson())),
    "Warnings": List<dynamic>.from(warnings.map((x) => x)),
    "CustomProperties": customProperties.toJson(),
  };
}

class WishlistItem {
  WishlistItem({
    required this.sku,
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
    required this.warnings,
    required this.id,
    required this.customProperties,
  });

  String sku;
  PictureModel picture;
  int productId;
  String productName;
  String productSeName;
  String unitPrice;
  String subTotal;
  dynamic discount;
  dynamic maximumDiscountedQty;
  int quantity;
  List<AllowedQuantity> allowedQuantities;
  String attributeInfo;
  dynamic recurringInfo;
  dynamic rentalInfo;
  bool allowItemEditing;
  List<dynamic> warnings;
  int id;
  CustomProperties customProperties;

  factory WishlistItem.fromJson(Map<String, dynamic> json) => WishlistItem(
    sku: json["Sku"],
    picture: PictureModel.fromJson(json["Picture"]),
    productId: json["ProductId"],
    productName: json["ProductName"],
    productSeName: json["ProductSeName"],
    unitPrice: json["UnitPrice"],
    subTotal: json["SubTotal"],
    discount: json["Discount"],
    maximumDiscountedQty: json["MaximumDiscountedQty"],
    quantity: json["Quantity"],
    allowedQuantities: List<AllowedQuantity>.from(json["AllowedQuantities"].map((x) => AllowedQuantity.fromJson(x))),
    attributeInfo: json["AttributeInfo"],
    recurringInfo: json["RecurringInfo"],
    rentalInfo: json["RentalInfo"],
    allowItemEditing: json["AllowItemEditing"],
    warnings: List<dynamic>.from(json["Warnings"].map((x) => x)),
    id: json["Id"],
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "Sku": sku,
    "Picture": picture.toJson(),
    "ProductId": productId,
    "ProductName": productName,
    "ProductSeName": productSeName,
    "UnitPrice": unitPrice,
    "SubTotal": subTotal,
    "Discount": discount,
    "MaximumDiscountedQty": maximumDiscountedQty,
    "Quantity": quantity,
    "AllowedQuantities": List<dynamic>.from(allowedQuantities.map((x) => x.toJson())),
    "AttributeInfo": attributeInfo,
    "RecurringInfo": recurringInfo,
    "RentalInfo": rentalInfo,
    "AllowItemEditing": allowItemEditing,
    "Warnings": List<dynamic>.from(warnings.map((x) => x)),
    "Id": id,
    "CustomProperties": customProperties.toJson(),
  };
}

class AllowedQuantity {
  AllowedQuantity({
    required this.disabled,
    required this.group,
    required this.selected,
    required this.text,
    required this.value,
  });

  bool disabled;
  dynamic group;
  bool selected;
  String text;
  String value;

  factory AllowedQuantity.fromJson(Map<String, dynamic> json) => AllowedQuantity(
    disabled: json["Disabled"],
    group: json["Group"],
    selected: json["Selected"],
    text: json["Text"],
    value: json["Value"],
  );

  Map<String, dynamic> toJson() => {
    "Disabled": disabled,
    "Group": group,
    "Selected": selected,
    "Text": text,
    "Value": value,
  };
}
