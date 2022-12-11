/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:nopcommerce/Models/CustomProperties.dart';
import 'dart:convert';

GetProductReviewsModel getProductReviewsModelFromJson(String str) => GetProductReviewsModel.fromJson(json.decode(str));

String getProductReviewsModelToJson(GetProductReviewsModel data) => json.encode(data.toJson());

class GetProductReviewsModel {
  GetProductReviewsModel({
    required this.productId,
    required this.productName,
    required this.productSeName,
    required this.items,
    required this.addProductReview,
    required this.reviewTypeList,
    required this.addAdditionalProductReviewList,
    required this.customProperties,
  });

  int productId;
  String productName;
  String productSeName;
  List<ProductReviewItem> items;
  AddProductReview addProductReview;
  List<ReviewTypeList> reviewTypeList;
  List<AddAdditionalProductReviewList> addAdditionalProductReviewList;
  CustomProperties customProperties;

  factory GetProductReviewsModel.fromJson(Map<String, dynamic> json) => GetProductReviewsModel(
    productId: json["ProductId"],
    productName: json["ProductName"],
    productSeName: json["ProductSeName"],
    items: List<ProductReviewItem>.from(json["Items"].map((x) => ProductReviewItem.fromJson(x))),
    addProductReview: AddProductReview.fromJson(json["AddProductReview"]),
    reviewTypeList: List<ReviewTypeList>.from(json["ReviewTypeList"].map((x) => ReviewTypeList.fromJson(x))),
    addAdditionalProductReviewList: List<AddAdditionalProductReviewList>.from(json["AddAdditionalProductReviewList"].map((x) => AddAdditionalProductReviewList.fromJson(x))),
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "ProductId": productId,
    "ProductName": productName,
    "ProductSeName": productSeName,
    "Items": List<dynamic>.from(items.map((x) => x.toJson())),
    "AddProductReview": addProductReview.toJson(),
    "ReviewTypeList": List<dynamic>.from(reviewTypeList.map((x) => x.toJson())),
    "AddAdditionalProductReviewList": List<dynamic>.from(addAdditionalProductReviewList.map((x) => x.toJson())),
    "CustomProperties": customProperties.toJson(),
  };
}

class AddAdditionalProductReviewList {
  AddAdditionalProductReviewList({
    required this.productReviewId,
    required this.reviewTypeId,
    required this.rating,
    required this.name,
    required this.description,
    required this.displayOrder,
    required this.isRequired,
    required this.id,
    required this.customProperties,
  });

  int productReviewId;
  int reviewTypeId;
  int rating;
  String name;
  String description;
  int displayOrder;
  bool isRequired;
  int id;
  CustomProperties customProperties;

  factory AddAdditionalProductReviewList.fromJson(Map<String, dynamic> json) => AddAdditionalProductReviewList(
    productReviewId: json["ProductReviewId"],
    reviewTypeId: json["ReviewTypeId"],
    rating: json["Rating"],
    name: json["Name"],
    description: json["Description"],
    displayOrder: json["DisplayOrder"],
    isRequired: json["IsRequired"],
    id: json["Id"],
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "ProductReviewId": productReviewId,
    "ReviewTypeId": reviewTypeId,
    "Rating": rating,
    "Name": name,
    "Description": description,
    "DisplayOrder": displayOrder,
    "IsRequired": isRequired,
    "Id": id,
    "CustomProperties": customProperties.toJson(),
  };
}


class AddProductReview {
  AddProductReview({
    required this.title,
    required this.reviewText,
    required this.rating,
    required this.displayCaptcha,
    required this.canCurrentCustomerLeaveReview,
    required this.successfullyAdded,
    required this.canAddNewReview,
    required this.result,
    required this.customProperties,
  });

  dynamic title;
  dynamic reviewText;
  int rating;
  bool displayCaptcha;
  bool canCurrentCustomerLeaveReview;
  bool successfullyAdded;
  bool canAddNewReview;
  dynamic result;
  CustomProperties customProperties;

  factory AddProductReview.fromJson(Map<String, dynamic> json) => AddProductReview(
    title: json["Title"],
    reviewText: json["ReviewText"],
    rating: json["Rating"],
    displayCaptcha: json["DisplayCaptcha"],
    canCurrentCustomerLeaveReview: json["CanCurrentCustomerLeaveReview"],
    successfullyAdded: json["SuccessfullyAdded"],
    canAddNewReview: json["CanAddNewReview"],
    result: json["Result"],
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "Title": title,
    "ReviewText": reviewText,
    "Rating": rating,
    "DisplayCaptcha": displayCaptcha,
    "CanCurrentCustomerLeaveReview": canCurrentCustomerLeaveReview,
    "SuccessfullyAdded": successfullyAdded,
    "CanAddNewReview": canAddNewReview,
    "Result": result,
    "CustomProperties": customProperties.toJson(),
  };
}

class ProductReviewItem {
  ProductReviewItem({
    required this.customerId,
    required this.customerAvatarUrl,
    required this.customerName,
    required this.allowViewingProfiles,
    required this.title,
    required this.reviewText,
    required this.replyText,
    required this.rating,
    required this.writtenOnStr,
    required this.helpfulness,
    required this.additionalProductReviewList,
    required this.id,
    required this.customProperties,
  });

  int customerId;
  dynamic customerAvatarUrl;
  String customerName;
  bool allowViewingProfiles;
  String title;
  String reviewText;
  dynamic replyText;
  int rating;
  String writtenOnStr;
  Helpfulness helpfulness;
  List<AdditionalProductReviewList> additionalProductReviewList;
  int id;
  CustomProperties customProperties;

  factory ProductReviewItem.fromJson(Map<String, dynamic> json) => ProductReviewItem(
    customerId: json["CustomerId"],
    customerAvatarUrl: json["CustomerAvatarUrl"],
    customerName: json["CustomerName"],
    allowViewingProfiles: json["AllowViewingProfiles"],
    title: json["Title"],
    reviewText: json["ReviewText"],
    replyText: json["ReplyText"],
    rating: json["Rating"],
    writtenOnStr: json["WrittenOnStr"],
    helpfulness: Helpfulness.fromJson(json["Helpfulness"]),
    additionalProductReviewList: List<AdditionalProductReviewList>.from(json["AdditionalProductReviewList"].map((x) => AdditionalProductReviewList.fromJson(x))),
    id: json["Id"],
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "CustomerId": customerId,
    "CustomerAvatarUrl": customerAvatarUrl,
    "CustomerName": customerName,
    "AllowViewingProfiles": allowViewingProfiles,
    "Title": title,
    "ReviewText": reviewText,
    "ReplyText": replyText,
    "Rating": rating,
    "WrittenOnStr": writtenOnStr,
    "Helpfulness": helpfulness.toJson(),
    "AdditionalProductReviewList": List<dynamic>.from(additionalProductReviewList.map((x) => x.toJson())),
    "Id": id,
    "CustomProperties": customProperties.toJson(),
  };
}

class AdditionalProductReviewList {
  AdditionalProductReviewList({
    required this.productReviewId,
    required this.reviewTypeId,
    required this.rating,
    required this.name,
    required this.visibleToAllCustomers,
    required this.id,
    required this.customProperties,
  });

  int productReviewId;
  int reviewTypeId;
  int rating;
  String name;
  bool visibleToAllCustomers;
  int id;
  CustomProperties customProperties;

  factory AdditionalProductReviewList.fromJson(Map<String, dynamic> json) => AdditionalProductReviewList(
    productReviewId: json["ProductReviewId"],
    reviewTypeId: json["ReviewTypeId"],
    rating: json["Rating"],
    name: json["Name"],
    visibleToAllCustomers: json["VisibleToAllCustomers"],
    id: json["Id"],
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "ProductReviewId": productReviewId,
    "ReviewTypeId": reviewTypeId,
    "Rating": rating,
    "Name": name,
    "VisibleToAllCustomers": visibleToAllCustomers,
    "Id": id,
    "CustomProperties": customProperties.toJson(),
  };
}

class Helpfulness {
  Helpfulness({
    required this.productReviewId,
    required this.helpfulYesTotal,
    required this.helpfulNoTotal,
    required this.customProperties,
  });

  int productReviewId;
  int helpfulYesTotal;
  int helpfulNoTotal;
  CustomProperties customProperties;

  factory Helpfulness.fromJson(Map<String, dynamic> json) => Helpfulness(
    productReviewId: json["ProductReviewId"],
    helpfulYesTotal: json["HelpfulYesTotal"],
    helpfulNoTotal: json["HelpfulNoTotal"],
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "ProductReviewId": productReviewId,
    "HelpfulYesTotal": helpfulYesTotal,
    "HelpfulNoTotal": helpfulNoTotal,
    "CustomProperties": customProperties.toJson(),
  };
}

class ReviewTypeList {
  ReviewTypeList({
    required this.name,
    required this.description,
    required this.displayOrder,
    required this.isRequired,
    required this.visibleToAllCustomers,
    required this.averageRating,
    required this.id,
    required this.customProperties,
  });

  String name;
  String description;
  int displayOrder;
  bool isRequired;
  bool visibleToAllCustomers;
  double averageRating;
  int id;
  CustomProperties customProperties;

  factory ReviewTypeList.fromJson(Map<String, dynamic> json) => ReviewTypeList(
    name: json["Name"],
    description: json["Description"],
    displayOrder: json["DisplayOrder"],
    isRequired: json["IsRequired"],
    visibleToAllCustomers: json["VisibleToAllCustomers"],
    averageRating: json["AverageRating"],
    id: json["Id"],
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "Name": name,
    "Description": description,
    "DisplayOrder": displayOrder,
    "IsRequired": isRequired,
    "VisibleToAllCustomers": visibleToAllCustomers,
    "AverageRating": averageRating,
    "Id": id,
    "CustomProperties": customProperties.toJson(),
  };
}
