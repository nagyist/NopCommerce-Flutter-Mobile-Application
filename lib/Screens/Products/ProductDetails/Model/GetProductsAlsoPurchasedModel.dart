/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:nopcommerce/Models/CustomProperties.dart';
import 'dart:convert';

import 'package:nopcommerce/Models/PictureBoxModel.dart';
import 'package:nopcommerce/Models/ProductSpecificationModel.dart';

List<GetProductsAlsoPurchasedModel> getProductsAlsoPurchasedModelFromJson(String str) => List<GetProductsAlsoPurchasedModel>.from(json.decode(str).map((x) => GetProductsAlsoPurchasedModel.fromJson(x)));

String getProductsAlsoPurchasedModelToJson(List<GetProductsAlsoPurchasedModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetProductsAlsoPurchasedModel {
  GetProductsAlsoPurchasedModel({
    required this.name,
    required this.shortDescription,
    required this.fullDescription,
    required this.seName,
    required this.sku,
    required this.productType,
    required this.markAsNew,
    required this.productPrice,
    required this.defaultPictureModel,
    required this.productSpecificationModel,
    required this.reviewOverviewModel,
    required this.id,
    required this.customProperties,
  });

  String name;
  String shortDescription;
  String fullDescription;
  String seName;
  String sku;
  String productType;
  bool markAsNew;
  ProductPrice productPrice;
  PictureModel defaultPictureModel;
  ProductSpecificationModel productSpecificationModel;
  ReviewOverviewModel reviewOverviewModel;
  int id;
  CustomProperties customProperties;

  factory GetProductsAlsoPurchasedModel.fromJson(Map<String, dynamic> json) => GetProductsAlsoPurchasedModel(
    name: json["Name"],
    shortDescription: json["ShortDescription"] == null ? null : json["ShortDescription"],
    fullDescription: json["FullDescription"],
    seName: json["SeName"],
    sku: json["Sku"],
    productType: json["ProductType"],
    markAsNew: json["MarkAsNew"],
    productPrice: ProductPrice.fromJson(json["ProductPrice"]),
    defaultPictureModel: PictureModel.fromJson(json["DefaultPictureModel"]),
    productSpecificationModel: ProductSpecificationModel.fromJson(json["ProductSpecificationModel"]),
    reviewOverviewModel: ReviewOverviewModel.fromJson(json["ReviewOverviewModel"]),
    id: json["Id"],
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "Name": name,
    "ShortDescription": shortDescription == null ? null : shortDescription,
    "FullDescription": fullDescription,
    "SeName": seName,
    "Sku": sku,
    "ProductType": productType,
    "MarkAsNew": markAsNew,
    "ProductPrice": productPrice.toJson(),
    "DefaultPictureModel": defaultPictureModel.toJson(),
    "ProductSpecificationModel": productSpecificationModel.toJson(),
    "ReviewOverviewModel": reviewOverviewModel.toJson(),
    "Id": id,
    "CustomProperties": customProperties.toJson(),
  };
}


class ProductPrice {
  ProductPrice({
    required this.oldPrice,
    required this.price,
    required this.priceValue,
    required this.basePricePAngV,
    required this.disableBuyButton,
    required this.disableWishlistButton,
    required this.disableAddToCompareListButton,
    required this.availableForPreOrder,
    required this.preOrderAvailabilityStartDateTimeUtc,
    required this.isRental,
    required this.forceRedirectionAfterAddingToCart,
    required this.displayTaxShippingInfo,
    required this.customProperties,
  });

  dynamic oldPrice;
  String price;
  double priceValue;
  dynamic basePricePAngV;
  bool disableBuyButton;
  bool disableWishlistButton;
  bool disableAddToCompareListButton;
  bool availableForPreOrder;
  dynamic preOrderAvailabilityStartDateTimeUtc;
  bool isRental;
  bool forceRedirectionAfterAddingToCart;
  bool displayTaxShippingInfo;
  CustomProperties customProperties;

  factory ProductPrice.fromJson(Map<String, dynamic> json) => ProductPrice(
    oldPrice: json["OldPrice"],
    price: json["Price"],
    priceValue: json["PriceValue"],
    basePricePAngV: json["BasePricePAngV"],
    disableBuyButton: json["DisableBuyButton"],
    disableWishlistButton: json["DisableWishlistButton"],
    disableAddToCompareListButton: json["DisableAddToCompareListButton"],
    availableForPreOrder: json["AvailableForPreOrder"],
    preOrderAvailabilityStartDateTimeUtc: json["PreOrderAvailabilityStartDateTimeUtc"],
    isRental: json["IsRental"],
    forceRedirectionAfterAddingToCart: json["ForceRedirectionAfterAddingToCart"],
    displayTaxShippingInfo: json["DisplayTaxShippingInfo"],
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "OldPrice": oldPrice,
    "Price": price,
    "PriceValue": priceValue,
    "BasePricePAngV": basePricePAngV,
    "DisableBuyButton": disableBuyButton,
    "DisableWishlistButton": disableWishlistButton,
    "DisableAddToCompareListButton": disableAddToCompareListButton,
    "AvailableForPreOrder": availableForPreOrder,
    "PreOrderAvailabilityStartDateTimeUtc": preOrderAvailabilityStartDateTimeUtc,
    "IsRental": isRental,
    "ForceRedirectionAfterAddingToCart": forceRedirectionAfterAddingToCart,
    "DisplayTaxShippingInfo": displayTaxShippingInfo,
    "CustomProperties": customProperties.toJson(),
  };
}

class ReviewOverviewModel {
  ReviewOverviewModel({
    required this.productId,
    required this.ratingSum,
    required this.totalReviews,
    required this.allowCustomerReviews,
    required this.canAddNewReview,
    required this.customProperties,
  });

  int productId;
  int ratingSum;
  int totalReviews;
  bool allowCustomerReviews;
  bool canAddNewReview;
  CustomProperties customProperties;

  factory ReviewOverviewModel.fromJson(Map<String, dynamic> json) => ReviewOverviewModel(
    productId: json["ProductId"],
    ratingSum: json["RatingSum"],
    totalReviews: json["TotalReviews"],
    allowCustomerReviews: json["AllowCustomerReviews"],
    canAddNewReview: json["CanAddNewReview"],
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "ProductId": productId,
    "RatingSum": ratingSum,
    "TotalReviews": totalReviews,
    "AllowCustomerReviews": allowCustomerReviews,
    "CanAddNewReview": canAddNewReview,
    "CustomProperties": customProperties.toJson(),
  };
}
