/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


import 'package:nopcommerce/Models/CustomProperties.dart';
import 'package:nopcommerce/Models/PictureBoxModel.dart';
import 'dart:convert';

import 'package:nopcommerce/Models/ProductCatalogModel.dart';

GetCategoryResponseModel getCategoryResponseModelFromJson(String str) => GetCategoryResponseModel.fromJson(json.decode(str));

String getCategoryResponseModelToJson(GetCategoryResponseModel data) => json.encode(data.toJson());

class GetCategoryResponseModel {
  GetCategoryResponseModel({
    required this.name,
    required this.description,
    required this.metaKeywords,
    required this.metaDescription,
    required this.metaTitle,
    required this.seName,
    required this.pictureModel,
    required this.displayCategoryBreadcrumb,
    required this.categoryBreadcrumb,
    required this.subCategories,
    required this.featuredProducts,
    required this.catalogProductsModel,
    required this.id,
    required this.customProperties,
  });

  String name;
  dynamic description;
  dynamic metaKeywords;
  dynamic metaDescription;
  dynamic metaTitle;
  String seName;
  PictureModel pictureModel;
  bool displayCategoryBreadcrumb;
  List<GetCategoryResponseModel> categoryBreadcrumb;
  List<SubCategory> subCategories;
  List<dynamic> featuredProducts;
  CatalogProductsModel catalogProductsModel;
  int id;
  CustomProperties customProperties;

  factory GetCategoryResponseModel.fromJson(Map<String, dynamic> json) => GetCategoryResponseModel(
    name: json["Name"],
    description: json["Description"],
    metaKeywords: json["MetaKeywords"],
    metaDescription: json["MetaDescription"],
    metaTitle: json["MetaTitle"],
    seName: json["SeName"],
    pictureModel: PictureModel.fromJson(json["PictureModel"]),
    displayCategoryBreadcrumb: json["DisplayCategoryBreadcrumb"],
    categoryBreadcrumb: List<GetCategoryResponseModel>.from(json["CategoryBreadcrumb"].map((x) => GetCategoryResponseModel.fromJson(x))),
    subCategories: List<SubCategory>.from(json["SubCategories"].map((x) => SubCategory.fromJson(x))),
    featuredProducts: List<dynamic>.from(json["FeaturedProducts"].map((x) => x)),
    catalogProductsModel: CatalogProductsModel.fromJson(json["CatalogProductsModel"]),
    id: json["Id"],
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "Name": name,
    "Description": description,
    "MetaKeywords": metaKeywords,
    "MetaDescription": metaDescription,
    "MetaTitle": metaTitle,
    "SeName": seName,
    "PictureModel": pictureModel.toJson(),
    "DisplayCategoryBreadcrumb": displayCategoryBreadcrumb,
    "CategoryBreadcrumb": List<dynamic>.from(categoryBreadcrumb.map((x) => x.toJson())),
    "SubCategories": List<dynamic>.from(subCategories.map((x) => x.toJson())),
    "FeaturedProducts": List<dynamic>.from(featuredProducts.map((x) => x)),
    "CatalogProductsModel": catalogProductsModel.toJson(),
    "Id": id,
    "CustomProperties": customProperties.toJson(),
  };
}

class SubCategory {
  SubCategory({
    required this.name,
    required this.seName,
    required this.description,
    required this.pictureModel,
    required this.id,
    required this.customProperties,
  });

  String name;
  String seName;
  dynamic description;
  PictureModel pictureModel;
  int id;
  CustomProperties customProperties;

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
    name: json["Name"],
    seName: json["SeName"],
    description: json["Description"],
    pictureModel: PictureModel.fromJson(json["PictureModel"]),
    id: json["Id"],
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "Name": name,
    "SeName": seName,
    "Description": description,
    "PictureModel": pictureModel.toJson(),
    "Id": id,
    "CustomProperties": customProperties.toJson(),
  };
}

