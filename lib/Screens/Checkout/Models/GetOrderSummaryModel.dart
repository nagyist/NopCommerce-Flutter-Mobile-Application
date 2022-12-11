/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:nopcommerce/Models/AddressModel.dart';
import 'package:nopcommerce/Models/CheckoutAttribute.dart';
import 'dart:convert';
import 'package:nopcommerce/Models/CustomProperties.dart';
import 'package:nopcommerce/Models/DiscountBox.dart';
import 'package:nopcommerce/Models/GiftCardBoxModel.dart';
import 'package:nopcommerce/Models/ProductSummeryModel.dart';

GetOrderSummaryModel getOrderSummaryModelFromJson(String str) => GetOrderSummaryModel.fromJson(json.decode(str));

String getOrderSummaryModelToJson(GetOrderSummaryModel data) => json.encode(data.toJson());

class GetOrderSummaryModel {
  GetOrderSummaryModel({
    required this.onePageCheckoutEnabled,
    required this.showSku,
    required this.showProductImages,
    required this.isEditable,
    required this.items,
    required this.checkoutAttributes,
    required this.warnings,
    required this.minOrderSubtotalWarning,
    required this.displayTaxShippingInfo,
    required this.termsOfServiceOnShoppingCartPage,
    required this.termsOfServiceOnOrderConfirmPage,
    required this.termsOfServicePopup,
    required this.discountBox,
    required this.giftCardBox,
    required this.orderReviewData,
    required this.buttonPaymentMethodViewComponentNames,
    required this.hideCheckoutButton,
    required this.showVendorName,
    required this.customProperties,
  });

  bool onePageCheckoutEnabled;
  bool showSku;
  bool showProductImages;
  bool isEditable;
  List<ProductSummeryModel> items;
  List<CheckoutAttribute> checkoutAttributes;
  List<String> warnings;
  dynamic minOrderSubtotalWarning;
  bool displayTaxShippingInfo;
  bool termsOfServiceOnShoppingCartPage;
  bool termsOfServiceOnOrderConfirmPage;
  bool termsOfServicePopup;
  DiscountBox discountBox;
  GiftCardBox giftCardBox;
  OrderReviewData orderReviewData;
  List<String> buttonPaymentMethodViewComponentNames;
  bool hideCheckoutButton;
  bool showVendorName;
  CustomProperties customProperties;

  factory GetOrderSummaryModel.fromJson(Map<String, dynamic> json) => GetOrderSummaryModel(
    onePageCheckoutEnabled: json["OnePageCheckoutEnabled"],
    showSku: json["ShowSku"],
    showProductImages: json["ShowProductImages"],
    isEditable: json["IsEditable"],
    items: List<ProductSummeryModel>.from(json["Items"].map((x) => ProductSummeryModel.fromJson(x))),
    checkoutAttributes: List<CheckoutAttribute>.from(json["CheckoutAttributes"].map((x) => CheckoutAttribute.fromJson(x))),
    warnings: List<String>.from(json["Warnings"].map((x) => x)),
    minOrderSubtotalWarning: json["MinOrderSubtotalWarning"],
    displayTaxShippingInfo: json["DisplayTaxShippingInfo"],
    termsOfServiceOnShoppingCartPage: json["TermsOfServiceOnShoppingCartPage"],
    termsOfServiceOnOrderConfirmPage: json["TermsOfServiceOnOrderConfirmPage"],
    termsOfServicePopup: json["TermsOfServicePopup"],
    discountBox: DiscountBox.fromJson(json["DiscountBox"]),
    giftCardBox: GiftCardBox.fromJson(json["GiftCardBox"]),
    orderReviewData: OrderReviewData.fromJson(json["OrderReviewData"]),
    buttonPaymentMethodViewComponentNames: List<String>.from(json["ButtonPaymentMethodViewComponentNames"].map((x) => x)),
    hideCheckoutButton: json["HideCheckoutButton"],
    showVendorName: json["ShowVendorName"],
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "OnePageCheckoutEnabled": onePageCheckoutEnabled,
    "ShowSku": showSku,
    "ShowProductImages": showProductImages,
    "IsEditable": isEditable,
    "Items": List<ProductSummeryModel>.from(items.map((x) => x.toJson())),
    "CheckoutAttributes": List<dynamic>.from(checkoutAttributes.map((x) => x.toJson())),
    "Warnings": List<dynamic>.from(warnings.map((x) => x)),
    "MinOrderSubtotalWarning": minOrderSubtotalWarning,
    "DisplayTaxShippingInfo": displayTaxShippingInfo,
    "TermsOfServiceOnShoppingCartPage": termsOfServiceOnShoppingCartPage,
    "TermsOfServiceOnOrderConfirmPage": termsOfServiceOnOrderConfirmPage,
    "TermsOfServicePopup": termsOfServicePopup,
    "DiscountBox": discountBox.toJson(),
    "GiftCardBox": giftCardBox.toJson(),
    "OrderReviewData": orderReviewData.toJson(),
    "ButtonPaymentMethodViewComponentNames": List<dynamic>.from(buttonPaymentMethodViewComponentNames.map((x) => x)),
    "HideCheckoutButton": hideCheckoutButton,
    "ShowVendorName": showVendorName,
    "CustomProperties": customProperties.toJson(),
  };
}

class OrderReviewData {
  OrderReviewData({
    required this.display,
    required this.billingAddress,
    required this.isShippable,
    required this.shippingAddress,
    required this.selectedPickupInStore,
    required this.pickupAddress,
    required this.shippingMethod,
    required this.paymentMethod,
    required this.customValues,
    required this.customProperties,
  });

  bool display;
  AddressModel billingAddress;
  bool isShippable;
  AddressModel shippingAddress;
  bool selectedPickupInStore;
  AddressModel pickupAddress;
  String shippingMethod;
  String paymentMethod;
  CustomProperties customValues;
  CustomProperties customProperties;

  factory OrderReviewData.fromJson(Map<String, dynamic> json) => OrderReviewData(
    display: json["Display"],
    billingAddress: AddressModel.fromJson(json["BillingAddress"]),
    isShippable: json["IsShippable"],
    shippingAddress: AddressModel.fromJson(json["ShippingAddress"]),
    selectedPickupInStore: json["SelectedPickupInStore"],
    pickupAddress: AddressModel.fromJson(json["PickupAddress"]),
    shippingMethod: json["ShippingMethod"],
    paymentMethod: json["PaymentMethod"],
    customValues: CustomProperties.fromJson(json["CustomValues"]),
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "Display": display,
    "BillingAddress": billingAddress.toJson(),
    "IsShippable": isShippable,
    "ShippingAddress": shippingAddress.toJson(),
    "SelectedPickupInStore": selectedPickupInStore,
    "PickupAddress": pickupAddress.toJson(),
    "ShippingMethod": shippingMethod,
    "PaymentMethod": paymentMethod,
    "CustomValues": customValues.toJson(),
    "CustomProperties": customProperties.toJson(),
  };
}