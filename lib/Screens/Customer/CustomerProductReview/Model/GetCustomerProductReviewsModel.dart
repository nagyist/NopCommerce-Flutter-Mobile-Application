/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:nopcommerce/Models/CustomProperties.dart';
import 'package:nopcommerce/Models/PagerModel.dart';

GetCustomerProductReviewsModel getCustomerProductReviewsModelFromJson(String str) => GetCustomerProductReviewsModel.fromJson(json.decode(str));

String getCustomerProductReviewsModelToJson(GetCustomerProductReviewsModel data) => json.encode(data.toJson());

class GetCustomerProductReviewsModel {
  GetCustomerProductReviewsModel({
    required this.productReviews,
    required this.pagerModel,
    required this.customProperties,
  });

  List<ProductReview> productReviews;
  PagerModel pagerModel;
  CustomProperties customProperties;

  factory GetCustomerProductReviewsModel.fromJson(Map<String, dynamic> json) => GetCustomerProductReviewsModel(
    productReviews: List<ProductReview>.from(json["ProductReviews"].map((x) => ProductReview.fromJson(x))),
    pagerModel: PagerModel.fromJson(json["PagerModel"]),
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "ProductReviews": List<dynamic>.from(productReviews.map((x) => x.toJson())),
    "PagerModel": pagerModel.toJson(),
    "CustomProperties": customProperties.toJson(),
  };
}

class ProductReview {
  ProductReview({
    required this.productId,
    required this.productName,
    required this.productSeName,
    required this.title,
    required this.reviewText,
    required this.replyText,
    required this.rating,
    required this.writtenOnStr,
    required this.approvalStatus,
    required this.additionalProductReviewList,
    required this.customProperties,
  });

  int productId;
  String productName;
  String productSeName;
  String title;
  String reviewText;
  dynamic replyText;
  int rating;
  String writtenOnStr;
  dynamic approvalStatus;
  List<AdditionalProductReviewList> additionalProductReviewList;
  CustomProperties customProperties;

  factory ProductReview.fromJson(Map<String, dynamic> json) => ProductReview(
    productId: json["ProductId"],
    productName: json["ProductName"],
    productSeName: json["ProductSeName"],
    title: json["Title"],
    reviewText: json["ReviewText"],
    replyText: json["ReplyText"],
    rating: json["Rating"],
    writtenOnStr: json["WrittenOnStr"],
    approvalStatus: json["ApprovalStatus"],
    additionalProductReviewList: List<AdditionalProductReviewList>.from(json["AdditionalProductReviewList"].map((x) => AdditionalProductReviewList.fromJson(x))),
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "ProductId": productId,
    "ProductName": productName,
    "ProductSeName": productSeName,
    "Title": title,
    "ReviewText": reviewText,
    "ReplyText": replyText,
    "Rating": rating,
    "WrittenOnStr": writtenOnStr,
    "ApprovalStatus": approvalStatus,
    "AdditionalProductReviewList": List<dynamic>.from(additionalProductReviewList.map((x) => x.toJson())),
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

